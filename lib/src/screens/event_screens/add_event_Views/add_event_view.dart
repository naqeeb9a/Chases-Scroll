import 'dart:developer';
import 'dart:io';

import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/models/list_model.dart';
import 'package:chases_scroll/src/models/product_data_type.dart';
import 'package:chases_scroll/src/providers/eventicket_provider.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/repositories/post_repository.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/checkbox_widget_view.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/community_widget_view.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/drop_down_widget_view.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/dropdown_list_string_view.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/emptyImage_container_view.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/get_community_id_view.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/pageview_animate_text.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/radio_button_view.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/set_date_time_view.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/helpers/strings.dart';
import 'package:chases_scroll/src/utils/constants/helpers/validations.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddEventView extends ConsumerStatefulWidget {
  const AddEventView({super.key});

  @override
  ConsumerState<AddEventView> createState() => _WidgetState();
}

class TextButtonEvent extends StatelessWidget {
  final Function()? function;

  final String? title;
  const TextButtonEvent({super.key, this.function, this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Align(
        alignment: Alignment.centerRight,
        child: customText(
          text: title ?? "Continue >>",
          fontSize: 14,
          textColor: AppColors.deepPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _WidgetState extends ConsumerState<AddEventView> {
  static final eventTitle = TextEditingController();
  static final eventDesc = TextEditingController();
  static final location = TextEditingController();
  static final link = TextEditingController();
  static final desc = TextEditingController();
  static final ImagePicker picker = ImagePicker();
  static final PostRepository _postRepository = PostRepository();
  static final EventRepository eventRepository = EventRepository();
  PageController pageController = PageController(viewportFraction: 1);

  final _scrollController = ScrollController();

  //list
  List<ProductTypeDataa> formDataList = [];

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  File? image;

  String? imageString;

  //Radio for "to be announce checkBox"
  bool announcedBox = true;
  //checkbox for either paid or free
  bool eventkindPaid = true;

  bool eventkindFree = false;

  bool isExclusive = false;

  //event type title
  String? eventTypeValue = "Select Event Type";
  String? eventTypeValueMain = "Corporate_Event";

  //event type title
  String? eventCurrencyType = "NGN";

  //select location type
  String? eventLocationType = "Select Location";

  //event visibility String
  String? _radioJoinValue;

  //event go live
  String? _radioGoLiveValue;

  //event go live
  String? _radioShowEventVisibility;

  //start date
  DateTime sDate = DateTime.now();

  //end date
  DateTime eDate = DateTime.now();

//start time
  TimeOfDay startTime = TimeOfDay.now();

  //end time
  TimeOfDay endTime = TimeOfDay.now();

  //logic boolean here
  bool hasTicketsWithZero = false;
  bool hasPriceMinusZero = false;
  bool hasTicketTypeNull = false;
  bool hasMinTicketsWithZero = false;
  bool hasMaxTicketsWithZero = false;

  List<String> locationType = [
    "Select Location",
    "Physical Location",
    "Online Location",
    "Hybrid Location",
  ];

  void animateTo(int page) {
    pageController.animateToPage(
      page, // convert int to double
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final notifier = ref.watch(eventCommFunnelDataProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: PAD_ALL_15,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(
                      text: "Create Event",
                      fontSize: 18,
                      textColor: AppColors.black,
                      fontWeight: FontWeight.w500),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black12),
                      child: const Center(
                        child: Icon(
                          Icons.clear_rounded,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              heightSpace(1.5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AddEventExtendedTextLeft(
                      title: "Theme",
                      function: () => animateTo(0),
                    ),
                  ),
                  Expanded(
                    child: AddEventExtendedTextLeft(
                      title: "Information",
                      function: () => animateTo(1),
                    ),
                  ),
                  Expanded(
                    child: AddEventExtendedTextLeft(
                      title: "Ticket",
                      function: () => animateTo(2),
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: PageView(
                  controller: pageController,
                  children: [
                    //---------------- First Phase ---------------------///
                    Container(
                      height: height,
                      width: width,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              heightSpace(1),
                              customText(
                                  text: "Event Cover Image",
                                  fontSize: 14,
                                  textColor: AppColors.black,
                                  fontWeight: FontWeight.w500),
                              customText(
                                text:
                                    "Add photos/posters that has size of 2100 x 1080 dimension",
                                fontSize: 12,
                                textColor: AppColors.black,
                                fontWeight: FontWeight.w400,
                                lines: 3,
                              ),
                              heightSpace(3),
                              StatefulBuilder(
                                builder: (BuildContext context, setState) {
                                  return image != null && image!.path.isNotEmpty
                                      ? Container(
                                          height: 25.h,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(
                                                File(image!.path).absolute,
                                              ),
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.file(
                                                  File(image!.path).absolute,
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Positioned(
                                                right: 15,
                                                top: 20,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    // image!.delete();
                                                    // setState(() {});

                                                    if (image != null) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Confirm Deletion'),
                                                            content: const Text(
                                                                'Are you sure you want to delete this image file?'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: const Text(
                                                                    'Cancel'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                              TextButton(
                                                                child: const Text(
                                                                    'Delete'),
                                                                onPressed: () {
                                                                  image!
                                                                      .delete();
                                                                  setState(() {
                                                                    image =
                                                                        null; // Set image to null to indicate that it has been deleted
                                                                  });
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(); // Close the dialog
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color:
                                                          AppColors.deepPrimary,
                                                    ),
                                                    child: const Padding(
                                                      padding: PAD_ALL_10,
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : EmptyImageContainerWidget(
                                          function: () => uploadImages(),
                                        );
                                },
                              ),
                              heightSpace(3),
                              customText(
                                text: "Basic Event Details",
                                fontSize: 18,
                                textColor: AppColors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              customText(
                                text:
                                    "This section highlights details that should attract attendees to your event",
                                fontSize: 12,
                                textColor: AppColors.black,
                                fontWeight: FontWeight.w400,
                                lines: 2,
                              ),
                              heightSpace(3),
                              AppTextFormField(
                                validator: emptyStringValidation,
                                textEditingController: eventTitle,
                                label: "Event Title *",
                                hintText: "Event Title *",
                              ),
                              heightSpace(2),
                              DropDownListView(
                                typeValue: eventTypeValue,
                                typeList: eventTypeList,
                                onChanged: (value) {
                                  setState(() {
                                    eventTypeValue = value;
                                  });
                                },
                                onSaved: (value) => eventTypeValue = value,
                              ),
                              heightSpace(2),
                              AppTextFormField(
                                validator: emptyStringValidation,
                                textEditingController: eventDesc,
                                label: "Event Description",
                                hintText: "Event Description",
                                maxLines: 4,
                              ),
                              heightSpace(2),
                              customText(
                                  text: 'Go Live',
                                  fontSize: 14,
                                  textColor: AppColors.black),
                              heightSpace(2),
                              Column(
                                children: <Widget>[
                                  RadioButtonView(
                                    title: "Yes",
                                    value: "yes",
                                    radioGoLiveValue: _radioGoLiveValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _radioGoLiveValue = value!;
                                      });
                                    },
                                  ),
                                  RadioButtonView(
                                    title: "No",
                                    value: "no",
                                    radioGoLiveValue: _radioGoLiveValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _radioGoLiveValue = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              heightSpace(2),
                              customText(
                                  text: 'Event Visibility',
                                  fontSize: 14,
                                  textColor: AppColors.black),
                              heightSpace(2),
                              Column(
                                children: <Widget>[
                                  RadioButtonView(
                                    title: "Public",
                                    value: "public",
                                    radioGoLiveValue: _radioJoinValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _radioJoinValue = value!;
                                      });
                                    },
                                  ),
                                  RadioButtonView(
                                    title: "Private",
                                    value: "private",
                                    radioGoLiveValue: _radioJoinValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _radioJoinValue = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              heightSpace(2),
                              customText(
                                  text: 'Attendee Visibility',
                                  fontSize: 14,
                                  textColor: AppColors.black),
                              heightSpace(2),
                              Column(
                                children: <Widget>[
                                  RadioButtonView(
                                    title: "Show 👀",
                                    value: "show",
                                    radioGoLiveValue: _radioShowEventVisibility,
                                    onChanged: (value) {
                                      setState(() {
                                        _radioShowEventVisibility = value!;
                                      });
                                    },
                                  ),
                                  RadioButtonView(
                                    title: "Hide",
                                    value: "hide",
                                    radioGoLiveValue: _radioShowEventVisibility,
                                    onChanged: (value) {
                                      setState(() {
                                        _radioShowEventVisibility = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              heightSpace(4),
                              TextButtonEvent(function: () {
                                if (_formKey1.currentState!.validate()) {
                                  if (image == null) {
                                    ToastResp.toastMsgError(
                                        resp: "No Image has been Selected");
                                  } else if (_radioGoLiveValue == null) {
                                    ToastResp.toastMsgError(
                                        resp: "Go live not Selected");
                                  } else if (_radioJoinValue == null) {
                                    ToastResp.toastMsgError(
                                        resp: "Join type Not selected");
                                  } else if (_radioShowEventVisibility ==
                                      null) {
                                    ToastResp.toastMsgError(
                                        resp: "Show visibility Not Selected");
                                  } else {
                                    createEventDraft();
                                  }
                                }
                              }),
                              heightSpace(4)
                            ],
                          ),
                        ),
                      ),
                    ),
                    //------------------ Second phase ---------------------///
                    Container(
                      height: height,
                      width: width,
                      color: Colors.white,
                      child: SingleChildScrollView(
                          child: Form(
                              key: _formKey2,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    heightSpace(1),
                                    customText(
                                        text: "Event Date",
                                        fontSize: 14,
                                        textColor: AppColors.black,
                                        fontWeight: FontWeight.w500),
                                    heightSpace(1),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: SetDateEventView(
                                            dateTime: sDate,
                                            title: "Start Date",
                                            onpress: () async {
                                              DateTime? newDate =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: sDate,
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime(2100),
                                              );

                                              // If cancel return null..
                                              if (newDate == null) {
                                                return;
                                              }

                                              setState(() {
                                                sDate =
                                                    newDate; // Update eDate with the selected date
                                              });
                                            },
                                          ),
                                        ),
                                        widthSpace(3),
                                        Expanded(
                                          child: SetDateEventView(
                                            dateTime: eDate,
                                            title: "End Date",
                                            onpress: () async {
                                              DateTime? newDate =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: eDate,
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime(2100),
                                              );

                                              // If cancel return null..
                                              if (newDate == null) {
                                                return;
                                              }

                                              setState(() {
                                                eDate =
                                                    newDate; // Update eDate with the selected date
                                              });
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    heightSpace(1.5),
                                    customText(
                                        text: "Event Time",
                                        fontSize: 14,
                                        textColor: AppColors.black,
                                        fontWeight: FontWeight.w500),
                                    heightSpace(1),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: EventSetTimeView(
                                          time: startTime,
                                          function: () {
                                            _openStartTimePicker(context);
                                          },
                                          title: "Start Time",
                                        )),
                                        widthSpace(3),
                                        Expanded(
                                            child: EventSetTimeView(
                                          time: endTime,
                                          function: () {
                                            _openEndTimePicker(context);
                                          },
                                          title: "End Time",
                                        )),
                                      ],
                                    ),
                                    heightSpace(2),
                                    customText(
                                        text: "Location Type",
                                        fontSize: 14,
                                        textColor: AppColors.black,
                                        fontWeight: FontWeight.w500),
                                    heightSpace(1),
                                    DropDownListStringView(
                                      typeList: locationType,
                                      typeValue: eventLocationType,
                                      onChanged: (value) {
                                        setState(() {
                                          eventLocationType = value;
                                        });
                                      },
                                      onSaved: (value) {
                                        eventLocationType = value;
                                      },
                                    ),
                                    heightSpace(2),
                                    Visibility(
                                      visible: eventLocationType ==
                                                  "Physical Location" ||
                                              eventLocationType ==
                                                  "Hybrid Location"
                                          ? true
                                          : false,
                                      child: AppTextFormField(
                                        validator: emptyStringValidation,
                                        textEditingController: location,
                                        label: "Physical Location",
                                        hintText:
                                            "Enter your event venue exact address",
                                      ),
                                    ),
                                    heightSpace(1),
                                    Visibility(
                                      visible: eventLocationType ==
                                                  "Online Location" ||
                                              eventLocationType ==
                                                  "Hybrid Location"
                                          ? true
                                          : false,
                                      child: AppTextFormField(
                                        validator: emptyStringValidation,
                                        textEditingController: link,
                                        label: "Event Online Link",
                                        hintText:
                                            "Enter your event online link",
                                      ),
                                    ),
                                    heightSpace(2),
                                    AppTextFormField(
                                      validator: emptyStringValidation,
                                      textEditingController: desc,
                                      label: "Event Nearest Landmark",
                                      hintText:
                                          "Description event nearest nearest",
                                      maxLines: 4,
                                    ),
                                    heightSpace(2),
                                    CheckboxListTile(
                                      dense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 0.0),
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      activeColor: AppColors.deepPrimary,
                                      value: announcedBox,
                                      title: customText(
                                        text: "To Be Announced",
                                        fontSize: 14,
                                        textColor: AppColors.searchTextGrey,
                                        textAlignment: TextAlign.left,
                                      ),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          announcedBox = value!;
                                        });
                                      },
                                    ),
                                    heightSpace(4),
                                    TextButtonEvent(
                                      function: () async {
                                        int convertToMinutes(TimeOfDay time) {
                                          return time.hour * 60 + time.minute;
                                        }

                                        TimeOfDay currentTime = TimeOfDay.now();

                                        int currentMinutes =
                                            convertToMinutes(currentTime);
                                        int startMinutes =
                                            convertToMinutes(startTime);
                                        int endMinutes =
                                            convertToMinutes(endTime);

                                        if (_formKey2.currentState!
                                            .validate()) {
                                          if (sDate.isBefore(DateTime.now())) {
                                            ToastResp.toastMsgError(
                                                resp:
                                                    "Selecte Valid Start Date");
                                          } else if (eDate
                                              .isBefore(DateTime.now())) {
                                            ToastResp.toastMsgError(
                                                resp: "Select Valid End Date");
                                          } else {
                                            log("whats happeninng");
                                            updateEventDraft();
                                          }
                                        }
                                      },
                                    ),
                                    heightSpace(4)
                                  ]))),
                    ),
                    //-----------------  THird Phase ------------------------///
                    SizedBox(
                      height: height,
                      width: width,
                      child: SingleChildScrollView(
                          child: Form(
                              key: _formKey3,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText(
                                        text: "Event Type",
                                        fontSize: 14,
                                        textColor: AppColors.black,
                                        fontWeight: FontWeight.w500),
                                    heightSpace(1),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CheckBoxWidgetView(
                                            title: "Free",
                                            kind: eventkindFree,
                                            onChanged: (value) {
                                              setState(() {
                                                eventkindFree = value!;
                                                eventkindPaid = false;
                                              });
                                            },
                                          ),
                                        ),
                                        widthSpace(4),
                                        Expanded(
                                          child: CheckBoxWidgetView(
                                            title: "Paid",
                                            kind: eventkindPaid,
                                            onChanged: (value) {
                                              setState(() {
                                                eventkindPaid = value!;
                                                eventkindFree = false;
                                                print(eventkindPaid.toString());
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    heightSpace(2),
                                    Visibility(
                                      visible: eventkindPaid,
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxHeight: height / 2.5,
                                        ),
                                        child: ListView.builder(
                                          itemCount: formDataList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            log(formDataList.length.toString());
                                            ProductTypeDataa formData =
                                                formDataList[index];

                                            return Container(
                                              padding: PAD_ALL_13,
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1.3,
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                children: [
                                                  AppTextFormField(
                                                    validator:
                                                        emptyStringValidation,
                                                    hintText:
                                                        "Total Number of Tickets",
                                                    onChanged: (value) {
                                                      formDataList[index]
                                                              .totalNumberOfTickets =
                                                          int.tryParse(value);
                                                    },
                                                  ),
                                                  AppTextFormField(
                                                    validator:
                                                        emptyStringValidation,
                                                    hintText: "Ticket Price",
                                                    onChanged: (value) {
                                                      formDataList[index]
                                                              .ticketPrice =
                                                          double.tryParse(
                                                              value);
                                                    },
                                                  ),
                                                  AppTextFormField(
                                                    validator:
                                                        emptyStringValidation,
                                                    hintText: "Regular",
                                                    onChanged: (value) {
                                                      formDataList[index]
                                                          .ticketType = value;
                                                    },
                                                  ),
                                                  AppTextFormField(
                                                    validator:
                                                        emptyStringValidation,
                                                    hintText:
                                                        "Min. Ticket Avaible for this Ticket Type",
                                                    onChanged: (value) {
                                                      formDataList[index]
                                                              .minTicketBuy =
                                                          int.tryParse(value);
                                                      log(formDataList[index]
                                                          .minTicketBuy
                                                          .toString());
                                                    },
                                                  ),
                                                  AppTextFormField(
                                                    validator:
                                                        emptyStringValidation,
                                                    hintText:
                                                        "Max. Ticket Avaible for this Ticket Type",
                                                    onChanged: (value) {
                                                      formDataList[index]
                                                              .maxTicketBuy =
                                                          int.tryParse(value);
                                                    },
                                                  ),
                                                  heightSpace(0.4),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(AppColors
                                                                    .primary),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          formDataList
                                                              .removeAt(index);
                                                        });
                                                      },
                                                      child: customText(
                                                          text: "Delete",
                                                          fontSize: 12,
                                                          textColor:
                                                              AppColors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    heightSpace(1.3),
                                    Visibility(
                                        visible: eventkindPaid,
                                        child: ChasescrollButton(
                                          buttonText: "Add Ticket Type",
                                          width: 40.w,
                                          onTap: () {
                                            setState(() {
                                              formDataList
                                                  .add(ProductTypeDataa());
                                            });
                                            //print(formDataList);
                                            _scrollToBottom();
                                          },
                                        )),
                                    heightSpace(2),
                                    customText(
                                      text:
                                          "Select Currency type for your event",
                                      fontSize: 14,
                                      textColor: AppColors.searchTextGrey,
                                      textAlignment: TextAlign.left,
                                    ),
                                    heightSpace(1),
                                    DropDownListStringView(
                                      typeList: currencyTypeList,
                                      typeValue: eventCurrencyType,
                                      onChanged: (value) {
                                        setState(() {
                                          eventCurrencyType = value;
                                        });
                                      },
                                      onSaved: (value) {
                                        eventCurrencyType = value;
                                      },
                                    ),
                                    heightSpace(1),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              AppImages.eventFolder,
                                              height: 17,
                                              width: 17,
                                            ),
                                            widthSpace(0.7),
                                            customText(
                                              text: "Community Funnel",
                                              fontSize: 14,
                                              textColor: AppColors.primary,
                                              textAlignment: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                showMaterialModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (context) =>
                                                      StatefulBuilder(builder:
                                                          (BuildContext context,
                                                              StateSetter
                                                                  state) {
                                                    return ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(20),
                                                        topRight:
                                                            Radius.circular(20),
                                                      ),
                                                      child: Container(
                                                        height: 500,
                                                        color: Colors.white,
                                                        child:
                                                            GetCommunityFunnelID(),
                                                      ),
                                                    );
                                                  }),
                                                );

                                                setState(() {});
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                size: 25,
                                              ),
                                              color: Colors.black,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                showDialogBoard(context);
                                              },
                                              icon: const Icon(
                                                Icons.info,
                                                size: 25,
                                              ),
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    notifier.state.commName!.isNotEmpty
                                        ? CommunityWidgetView(
                                            name: notifier.state.commName,
                                            imageString:
                                                notifier.state.commImage,
                                            desc: notifier.state.commDesc,
                                          )
                                        : Container(),
                                    heightSpace(4),
                                    ChasescrollButton(
                                      buttonText: "Submit",
                                      onTap: () {
                                        for (var productData in formDataList) {
                                          if (productData
                                                  .totalNumberOfTickets! <=
                                              0) {
                                            hasTicketsWithZero = true;
                                            break;
                                          } else if (productData.ticketPrice! <=
                                              0) {
                                            hasPriceMinusZero = true;
                                            break;
                                          } else if (productData
                                              .ticketType!.isEmpty) {
                                            hasTicketTypeNull = true;
                                            break;
                                          } else if (productData
                                                  .minTicketBuy! <=
                                              0) {
                                            hasMinTicketsWithZero = true;
                                            break;
                                          } else if (productData
                                                  .maxTicketBuy! <=
                                              0) {
                                            hasMaxTicketsWithZero = true;
                                            break;
                                          }
                                        }

                                        if (hasTicketsWithZero) {
                                          // Do something when at least one item has totalNumberOfTickets == 0
                                          log('At least one item has totalNumberOfTickets equal to zero');
                                        } else if (hasPriceMinusZero) {
                                          // Do something when all items have totalNumberOfTickets > 0
                                          log('At least one item has price is minus value');
                                        } else if (hasTicketTypeNull) {
                                          // Do something when all items have totalNumberOfTickets > 0
                                          log('At least one item has Ticket Type does not have a value');
                                        } else if (hasMinTicketsWithZero) {
                                          // Do something when all items have totalNumberOfTickets > 0
                                          log('At least one item has 0 for Minimum Tickets');
                                        } else if (hasMaxTicketsWithZero) {
                                          // Do something when all items have totalNumberOfTickets > 0
                                          log('At least one item has 0 for Maximum Tickets');
                                        } else {
                                          createEvent(notifier.state.id);
                                        }

                                        // log(formDataList.toString());
                                      },
                                    ),
                                  ]))),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //to convert dateTime in to millis epoach
  int convertDateTimeToEpoch(DateTime dateTime) {
    final epoch = dateTime.millisecondsSinceEpoch;
    return epoch;
  }

  //time of the day to epoach
  int convertTimeOfDayToEpoch(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final epoch = dateTime.millisecondsSinceEpoch;
    return epoch;
  }

  createEvent(String? funnelID) async {
    bool result = await eventRepository.createEvent(
      address: location.text,
      attendeesVisibility: _radioShowEventVisibility == "show" ? true : false,
      currency: eventCurrencyType,
      currentPicUrl: imageString,
      endDate: convertDateTimeToEpoch(eDate),
      startDate: convertDateTimeToEpoch(sDate),
      endTime: convertTimeOfDayToEpoch(startTime),
      startTime: convertTimeOfDayToEpoch(endTime),
      eventDescription: desc.text,
      eventFunnelGroupID: funnelID!,
      eventName: eventTitle.text,
      eventType: eventTypeValue,
      isExclusive: isExclusive,
      isPublic: _radioShowEventVisibility == "show" ? true : false,
      link: link.text,
      locationDetails: desc.text,
      locationType: link.text.isEmpty ? "Physical" : "Virtual",
      picUrls: [],
      toBeAnnounced: announcedBox,
      productTypeData: formDataList,
    );
    if (result) {
      if (context.mounted) {
        TextEditingController().clear();
        ToastResp.toastMsgSuccess(resp: "Event Created Successfully");
        context.push(AppRoutes.bottomNav, extra: false);
      }
    } else {
      return;
    }
  }

  //create draft
  createEventDraft() async {
    bool result = await eventRepository.createEventDraft(
      address: location.text,
      attendeesVisibility: _radioShowEventVisibility == "show" ? true : false,
      currency: eventCurrencyType,
      currentPicUrl: imageString,
      endDate: convertDateTimeToEpoch(eDate),
      startDate: convertDateTimeToEpoch(sDate),
      endTime: convertTimeOfDayToEpoch(startTime),
      startTime: convertTimeOfDayToEpoch(endTime),
      eventDescription: desc.text,
      eventFunnelGroupID: "",
      eventName: eventTitle.text,
      eventType: eventTypeValue,
      isExclusive: isExclusive,
      isPublic: _radioShowEventVisibility == "show" ? true : false,
      link: link.text,
      locationDetails: desc.text,
      locationType: link.text.isEmpty ? "Physical" : "Virtual",
      picUrls: [],
      toBeAnnounced: announcedBox,
      productTypeData: formDataList,
    );
    if (result) {
      if (context.mounted) {
        ToastResp.toastMsgSuccess(resp: "Event Details Saved");
        animateTo(1);
      }
    } else {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    formDataList.add(ProductTypeDataa());
  }

  //create draft
  updateEventDraft() async {
    bool result = await eventRepository.updateEventDraft(
      address: location.text,
      attendeesVisibility: _radioShowEventVisibility == "show" ? true : false,
      currency: eventCurrencyType,
      currentPicUrl: imageString,
      endDate: convertDateTimeToEpoch(eDate),
      startDate: convertDateTimeToEpoch(sDate),
      endTime: convertTimeOfDayToEpoch(startTime),
      startTime: convertTimeOfDayToEpoch(endTime),
      eventDescription: desc.text,
      eventFunnelGroupID: "",
      eventName: eventTitle.text,
      eventType: eventTypeValue,
      isExclusive: isExclusive,
      isPublic: _radioShowEventVisibility == "show" ? true : false,
      link: link.text,
      locationDetails: desc.text,
      locationType: link.text.isEmpty ? "Physical" : "Virtual",
      picUrls: [],
      toBeAnnounced: announcedBox,
      productTypeData: formDataList,
    );
    if (result) {
      if (context.mounted) {
        ToastResp.toastMsgSuccess(resp: "Event Details Saved");
        animateTo(2);
      }
    } else {
      return;
    }
  }

  void uploadImages() async {
    final imagePath =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (imagePath != null) {
      image = File(imagePath.path);
      String imageName = await eventRepository.addImage(File((image!.path)));

      log("Image String is not null");
      log(imageName);
      setState(() {
        imageString = imageName;
      });
    }
  }

  //start time function
  Future<void> _openEndTimePicker(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: endTime,
    );
    if (picked != null && picked != endTime) {
      setState(() {
        endTime = picked;
      });
    }
  }

  //start time function
  Future<void> _openStartTimePicker(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime,
    );
    if (picked != null && picked != startTime) {
      setState(() {
        startTime = picked;
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }
}

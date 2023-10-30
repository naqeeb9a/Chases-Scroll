import 'dart:developer';
import 'dart:io';

import 'package:chases_scroll/src/models/list_model.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/checkbox_widget_view.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/community_widget_view.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/drop_down_widget_view.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/dropdown_list_string_view.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/emptyImage_container_view.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/radio_button_view.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/set_date_time_view.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/helpers/strings.dart';
import 'package:chases_scroll/src/utils/constants/helpers/validations.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';

import '../../../models/product_data_type.dart';

class AddEventExtendedTextLeft extends StatelessWidget {
  final Function()? function;
  final String? title;
  final Alignment? alignment;
  const AddEventExtendedTextLeft({
    super.key,
    required this.function,
    required this.title,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        child: Align(
          alignment: alignment ?? Alignment.centerLeft,
          child: customText(
              text: title!,
              fontSize: 14,
              textColor: AppColors.black,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class AddEventView extends StatefulWidget {
  const AddEventView({super.key});

  @override
  State<AddEventView> createState() => _AddEventViewState();
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

class _AddEventViewState extends State<AddEventView> {
  //TextEditingController
  static final eventTitle = TextEditingController();
  static final organizer = TextEditingController();
  static final eventDesc = TextEditingController();
  static final location = TextEditingController();
  static final link = TextEditingController();
  static final desc = TextEditingController();
  PageController pageController = PageController(viewportFraction: 1);
  final _scrollController = ScrollController();

  //list
  List<ProductTypeDataa> formDataList = [];

  final int _currentPageValue = 0;
  final _formKey = GlobalKey<FormState>();

  File? image;

  //Radio for "to be announce checkBox"
  bool announcedBox = false;

  //checkbox for either paid or free
  bool eventkindPaid = true;
  bool eventkindFree = false;

  //event type title
  String? eventTypeValue = "Select Event Type";

  //event type title
  String? eventCurrencyType = "NGN";

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
                    Container(
                      height: height,
                      width: width,
                      color: Colors.white,
                      child: SingleChildScrollView(
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
                                              top: 15,
                                              child: GestureDetector(
                                                onTap: () {
                                                  //getImage(context);
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
                                                      Icons.camera_alt,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 15,
                                              top: 70,
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
                                                                image!.delete();
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
                                        function: () {},
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
                              textEditingController: organizer,
                              label: "Organizer *",
                              hintText: "Organizer *",
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
                                      print(_radioGoLiveValue);
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
                                      print(_radioGoLiveValue);
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
                                      print(_radioJoinValue);
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
                                      print(_radioJoinValue);
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
                                      print(_radioShowEventVisibility);
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
                                      print(_radioShowEventVisibility);
                                    });
                                  },
                                ),
                              ],
                            ),
                            heightSpace(4),
                            TextButtonEvent(
                              function: () => animateTo(1),
                            ),
                            heightSpace(4)
                          ],
                        ),
                      ),
                    ),
                    //---------------------------------------------///
                    Container(
                      height: height,
                      width: width,
                      color: Colors.white,
                      child: SingleChildScrollView(
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
                              AppTextFormField(
                                validator: emptyStringValidation,
                                textEditingController: location,
                                label: "Physical Location",
                                hintText:
                                    "Enter your event venue exact address",
                              ),
                              heightSpace(2),
                              AppTextFormField(
                                validator: emptyStringValidation,
                                textEditingController: desc,
                                label: "Event Nearest Landmark",
                                hintText: "Description event nearest nearest",
                                maxLines: 4,
                              ),
                              heightSpace(2),
                              AppTextFormField(
                                validator: emptyStringValidation,
                                textEditingController: link,
                                label: "Event Online Link",
                                hintText: "Enter your event online link",
                              ),
                              heightSpace(2),
                              CheckboxListTile(
                                dense: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
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
                                function: () => animateTo(2),
                              ),
                              heightSpace(4)
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: height,
                      width: width,
                      child: SingleChildScrollView(
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    log(formDataList.length.toString());
                                    ProductTypeDataa formData =
                                        formDataList[index];

                                    return Container(
                                      padding: PAD_ALL_13,
                                      margin: const EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.3, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          AppTextFormField(
                                            validator: emptyStringValidation,
                                            hintText: "Total Number of Tickets",
                                            onChanged: (value) {
                                              formData.totalNumberOfTickets =
                                                  int.tryParse(value);
                                            },
                                          ),
                                          AppTextFormField(
                                            validator: emptyStringValidation,
                                            hintText: "Enter Number of Tickets",
                                            onChanged: (value) {
                                              formDataList[index].ticketPrice =
                                                  double.tryParse(value);
                                            },
                                          ),
                                          AppTextFormField(
                                            validator: emptyStringValidation,
                                            hintText: "Regular",
                                            onChanged: (value) {
                                              formDataList[index].ticketType =
                                                  value;
                                            },
                                          ),
                                          AppTextFormField(
                                            validator: emptyStringValidation,
                                            hintText:
                                                "Min. Ticket Avaible for this Ticket Type",
                                            onChanged: (value) {
                                              formDataList[index].minTicketBuy =
                                                  int.tryParse(value);
                                            },
                                          ),
                                          AppTextFormField(
                                            validator: emptyStringValidation,
                                            hintText:
                                                "Max. Ticket Avaible for this Ticket Type",
                                            onChanged: (value) {
                                              formDataList[index].maxTicketBuy =
                                                  int.tryParse(value);
                                            },
                                          ),
                                          heightSpace(0.4),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        AppColors.primary),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  formDataList.removeAt(index);
                                                });
                                              },
                                              child: customText(
                                                  text: "Delete",
                                                  fontSize: 12,
                                                  textColor: AppColors.white,
                                                  fontWeight: FontWeight.w500),
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
                                      formDataList.add(ProductTypeDataa());
                                    });
                                    //print(formDataList);
                                    _scrollToBottom();
                                  },
                                )),
                            heightSpace(2),
                            customText(
                              text: "Select Currency type for your event",
                              fontSize: 14,
                              textColor: AppColors.searchTextGrey,
                              textAlignment: TextAlign.left,
                            ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      onPressed: () async {
                                        // final List<FunnelModel> friends =
                                        //     await showModalBottomSheet(
                                        //   backgroundColor: Colors.transparent,
                                        //   context: context,
                                        //   builder: (context) => StatefulBuilder(
                                        //       builder: (BuildContext context,
                                        //           StateSetter state) {
                                        //     return ClipRRect(
                                        //       borderRadius:
                                        //           const BorderRadius.only(
                                        //         topLeft: Radius.circular(20),
                                        //         topRight: Radius.circular(20),
                                        //       ),
                                        //       child: Container(
                                        //         color: Colors.white,
                                        //         child:
                                        //             const AddFunnelScreenView(),
                                        //       ),
                                        //     );
                                        //   }),
                                        // );

                                        // setState(() {
                                        //   if (commFunnel.isNotEmpty) {
                                        //     commFunnel = friends;
                                        //     if (commFunnel[0].id.isEmpty) {
                                        //       // You can directly assign the value of id to a variable here if needed.
                                        //       // For example:
                                        //       firstId = commFunnel[0].id;
                                        //       // Use the value as needed within this scope.
                                        //     } else {
                                        //       firstId = null;
                                        //     }
                                        //   }
                                        // });
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
                            const CommunityWidgetView(),
                            heightSpace(4),
                            const ChasescrollButton(
                              buttonText: "Submit",
                            ),
                          ],
                        ),
                      ),
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

  @override
  void initState() {
    super.initState();
    formDataList.add(ProductTypeDataa());
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

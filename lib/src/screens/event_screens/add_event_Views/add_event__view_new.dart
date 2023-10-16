import 'dart:developer';
import 'dart:io';

import 'package:chases_scroll/src/models/list_model.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/add_event_view.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/drop_down_widget_view.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/emptyImage_container_view.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/pageview_animate_text.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/radio_button_view.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/helpers/validations.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:image_picker/image_picker.dart';

class AddEventNewView extends HookWidget {
  static final eventTitle = TextEditingController();

  static final organizer = TextEditingController();
  static final eventDesc = TextEditingController();
  static final location = TextEditingController();
  static final link = TextEditingController();
  static final ImagePicker picker = ImagePicker();
  static final EventRepository eventRepository = EventRepository();
  const AddEventNewView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    PageController pageController = PageController(viewportFraction: 0.95);
    final currentPageValue = useState<double>(0);
    final imageFile = useState<File?>(null);
    final imageString = useState<String>("");
    final eventTypeValue = useState<String>("Select Event Type");
    final radioGoLiveValue = useState<String>("");
    final radioShowEventVisibility = useState<String>("");
    final radioJoinValue = useState<String>("");
    //event go live

    void animateTo(int page) {
      pageController.animateToPage(
        page, // convert int to double
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }

    void uploadImages() async {
      final XFile? image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (image != null) {
        imageFile.value = image as File;
        String imageName = await eventRepository.addImage(File((image.path)));

        log("Image String is not null");
        log(imageName);
        imageString.value = imageName;
      }
    }

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
                                return imageFile.value != null &&
                                        imageFile.value!.path.isNotEmpty
                                    ? Container(
                                        height: 25.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                              File(imageFile.value!.path)
                                                  .absolute,
                                            ),
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.file(
                                                File(imageFile.value!.path)
                                                    .absolute,
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

                                                  if (imageFile.value != null) {
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
                                                                File(imageFile
                                                                            .value
                                                                        as String)
                                                                    .delete();

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
                              typeValue: eventTypeValue.value,
                              typeList: eventTypeList,
                              onChanged: (value) {
                                eventTypeValue.value = value!;
                              },
                              onSaved: (value) => eventTypeValue.value = value!,
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
                                  radioGoLiveValue: radioGoLiveValue.value,
                                  onChanged: (value) {
                                    radioGoLiveValue.value = value!;
                                    print(radioGoLiveValue.value);
                                  },
                                ),
                                RadioButtonView(
                                  title: "No",
                                  value: "no",
                                  radioGoLiveValue: radioGoLiveValue.value,
                                  onChanged: (value) {
                                    radioGoLiveValue.value = value!;
                                    print(radioGoLiveValue.value);
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
                                  radioGoLiveValue: radioJoinValue.value,
                                  onChanged: (value) {
                                    radioJoinValue.value = value!;
                                    print(radioJoinValue.value);
                                  },
                                ),
                                RadioButtonView(
                                  title: "Private",
                                  value: "private",
                                  radioGoLiveValue: radioJoinValue.value,
                                  onChanged: (value) {
                                    radioJoinValue.value = value!;
                                    print(radioJoinValue.value);
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
                                  radioGoLiveValue:
                                      radioShowEventVisibility.value,
                                  onChanged: (value) {
                                    radioShowEventVisibility.value = value!;
                                    print(radioShowEventVisibility.value);
                                  },
                                ),
                                RadioButtonView(
                                  title: "Hide",
                                  value: "hide",
                                  radioGoLiveValue:
                                      radioShowEventVisibility.value,
                                  onChanged: (value) {
                                    radioShowEventVisibility.value = value!;
                                    print(radioShowEventVisibility.value);
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

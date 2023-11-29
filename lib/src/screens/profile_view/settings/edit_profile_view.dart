import 'dart:developer';
import 'dart:io';

import 'package:chases_scroll/src/models/user_model.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/repositories/profile_repository.dart';
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
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../event_screens/add_event_Views/widgets/drop_down_widget_view.dart';

class EditProfileScreenView extends StatefulWidget {
  const EditProfileScreenView({super.key});

  @override
  State<EditProfileScreenView> createState() => _EditProfileScreenViewState();
}

class _EditProfileScreenViewState extends State<EditProfileScreenView> {
  static final ProfileRepository _profileRepository = ProfileRepository();
  static final ImagePicker picker = ImagePicker();
  static final EventRepository eventRepository = EventRepository();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final about = TextEditingController();
  final weblink = TextEditingController();
  final email = TextEditingController();

  File? image;

  String? imageString;

  String? myListDaysValue = "Select option";

  List<String> myListDays = [
    "Male",
    "Female",
  ];

  UserModel? userModel = UserModel();
  var bool1 = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: customText(
          text: "Edit Profile",
          fontSize: 14,
          textColor: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
        toolbarHeight: 50,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Platform.isIOS
                ? Icons.arrow_back_ios_new_rounded
                : Icons.arrow_back_rounded,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: PAD_ALL_15,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(60),
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(0),
                        ),
                        color: Colors.grey.shade200,
                        border: Border.all(
                          width: 4,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      child: Stack(
                        children: [
                          image != null && image!.path.isNotEmpty
                              ? Container(
                                  height: 25.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(image!.path).absolute,
                                      ),
                                    ),
                                  ),
                                )
                              : userModel!.data!.imgMain!.value == null
                                  ? Center(
                                      child: customText(
                                        text:
                                            "${userModel!.firstName![0].toUpperCase()} ${userModel!.lastName![0].toUpperCase()}",
                                        fontSize: 16,
                                        textColor: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(60),
                                        bottomRight: Radius.circular(60),
                                        topLeft: Radius.circular(60),
                                        topRight: Radius.circular(0),
                                      ),
                                      child: SizedBox(
                                        height: 25.h,
                                        width: double.infinity,
                                        child: Image.network(
                                          "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${userModel!.data!.imgMain!.value}",
                                          scale: 1.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                          Center(
                            child: GestureDetector(
                              onTap: () => uploadImage(),
                              child: Icon(
                                Icons.camera_alt,
                                size: 40,
                                color: AppColors.deepPrimary.withOpacity(0.6),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                heightSpace(3),
                customText(
                  text: "Personal Details",
                  fontSize: 14,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
                heightSpace(1),
                Container(
                  width: width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45, width: 0.2),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextFormField(
                          validator: emptyStringValidation,
                          textEditingController: firstName,
                          label: "First Name",
                        ),
                        heightSpace(1),
                        AppTextFormField(
                          validator: emptyStringValidation,
                          textEditingController: lastName,
                          label: "Last Name",
                        ),
                        heightSpace(1),
                        AppTextFormField(
                          validator: emptyStringValidation,
                          textEditingController: username,
                          label: "UserName",
                        ),
                        heightSpace(1),
                        AppTextFormField(
                          validator: emptyStringValidation,
                          textEditingController: about,
                          label: "About Me",
                        ),
                        heightSpace(1),
                        AppTextFormField(
                          validator: emptyStringValidation,
                          textEditingController: weblink,
                          label: "Web Link",
                        ),
                        heightSpace(1),
                        customText(
                          text: "Select Gender",
                          fontSize: 14,
                          textColor: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        heightSpace(1),
                        DropDownListViewString(
                          typeValue:
                              userModel!.data!.gender!.value ?? "Select option",
                          typeList: myListDays,
                          onChanged: (value) {
                            myListDaysValue = value;
                          },
                          onSaved: (value) => myListDaysValue = value,
                        ),
                        heightSpace(1),
                        customText(
                          text: "Date-of-Birth",
                          fontSize: 14,
                          textColor: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        heightSpace(1),
                        Container(
                          height: 50,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xffE0E0E0),
                              width: 1.5,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              children: [
                                SvgPicture.asset(AppImages.calendarIcon),
                                widthSpace(1),
                                customText(
                                  text: userModel!.dob ?? "DOB",
                                  fontSize: 14,
                                  textColor: AppColors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                heightSpace(3),
                customText(
                  text: "Contact Details",
                  fontSize: 14,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
                heightSpace(1),
                Container(
                  width: width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45, width: 0.2),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextFormField(
                          validator: emptyStringValidation,
                          textEditingController: email,
                          label: "Email Address",
                        ),
                        heightSpace(1),
                        TextToggleFunction(
                          title: "Show Email:",
                          widget: Switch(
                            value: bool1,
                            activeColor: AppColors.deepPrimary,
                            onChanged: (bool newValue) {
                              setState(() {
                                bool1 = newValue;
                              });

                              if (bool1 == true) {
                                ToastResp.toastMsgSuccess(
                                  resp: "Show Email has been turned on",
                                );
                              } else {
                                ToastResp.toastMsgError(
                                    resp: "Show Email has been turned off");
                              }
                            },
                          ),
                        ),
                        heightSpace(1),
                        customText(
                          text: "Phone Number",
                          fontSize: 14,
                          textColor: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        heightSpace(1),
                        Container(
                          height: 50,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xffE0E0E0),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: customText(
                                  text:
                                      userModel!.data!.mobilePhone!.value ?? "",
                                  fontSize: 14,
                                  textColor: AppColors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                heightSpace(3),
                ChasescrollButton(
                  buttonText: "Edit Profile",
                  onTap: () => editProfile(),
                  // onTap: () {
                  //   log(bool1.value.toString());
                  // },
                ),
                heightSpace(3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void editProfile() async {
    bool result = await _profileRepository.editProfile(
      about: about.text,
      firstName: firstName.text,
      gender: myListDaysValue,
      lastName: lastName.text,
      phone: userModel!.data!.mobilePhone!.value,
      showEmail: bool1,
      username: username.text,
      webAddress: weblink.text,
    );
    if (result) {
      ToastResp.toastMsgSuccess(resp: "Profile updated successfully");
    } else {
      ToastResp.toastMsgError(resp: "Profile update not successful");
    }
  }

  void fetchUsers() async {
    try {
      userModel = await _profileRepository.getUserProfile();
      debugPrint("userSp =======> ${userModel!.data!.about!.value.toString()}");
      // Now you can use userSp in your UI
      setState(() {
        firstName.text = userModel!.firstName!;
        lastName.text = userModel!.lastName!;
        username.text = userModel!.username!;
        about.text = userModel!.data!.about!.value ?? "";
        weblink.text = userModel!.data!.webAddress!.value ?? "";
        email.text = userModel!.email ?? "";
        bool1 = userModel!.showEmail ?? true;
      });
    } catch (error) {
      // Handle the error
      print("Error fetching users: $error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUsers();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  void uploadImage() async {
    final imagePath =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (imagePath != null) {
      image = File(imagePath.path);
      String imageName = await eventRepository.addImage(File((image!.path)));

      log("Image String is not null");
      log(imageString.toString());
      log(image!.path.toString());

      imageString = imageName;
      if (imageName.isNotEmpty) {
        bool result = await _profileRepository.editProfilImage(
            profileImageRef: imageName);
        if (result) {
          ToastResp.toastMsgSuccess(resp: "Image updated successfuly");
        } else {
          ToastResp.toastMsgError(resp: "Image is not updating");
        }
      }
    }
  }
}

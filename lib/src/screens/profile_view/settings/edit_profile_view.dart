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
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../event_screens/add_event_Views/widgets/drop_down_widget_view.dart';

class EditProfileScreenView extends HookWidget {
  static final ProfileRepository _profileRepository = ProfileRepository();
  static final ImagePicker picker = ImagePicker();
  static final EventRepository eventRepository = EventRepository();

  const EditProfileScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    //get User Detials

    final userProfileLoading = useState<bool>(true);

    final userProfileModel = useState<UserModel>(UserModel());

    void getUsersProfile() {
      _profileRepository.getUserProfile().then((value) {
        userProfileLoading.value = false;
        userProfileModel.value = value!;
      });
    }

    bool? initialStatus = userProfileModel.value.showEmail ?? false;
    final bool1 = useState<bool>(initialStatus);

    //refresh data
    void refreshUsersProfileData() {
      userProfileLoading.value = false; // Set loading state back to true
      getUsersProfile(); // Trigger the API call again
    }

    final firstName =
        TextEditingController(text: userProfileModel.value.firstName);

    final lastName =
        TextEditingController(text: userProfileModel.value.lastName);
    final username =
        TextEditingController(text: userProfileModel.value.username);
    final about = TextEditingController(
      text: userProfileModel.value.data?.about?.value ?? "",
    );

    final weblink = TextEditingController(
        text: userProfileModel.value.data?.webAddress?.value ?? "");
    final email =
        TextEditingController(text: userProfileModel.value.email ?? "");

    File? image;

    String? imageString;

    String? myListDaysValue = "Select option";

    List<String> myListDays = [
      "Male",
      "Female",
    ];

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
            refreshUsersProfileData();
          } else {
            ToastResp.toastMsgError(resp: "Image is not updating");
          }
        }
      }
    }

    void editProfile() async {
      bool result = await _profileRepository.editProfile(
        about: about.text,
        firstName: firstName.text,
        gender: myListDaysValue,
        lastName: lastName.text,
        phone: userProfileModel.value.data!.mobilePhone!.value ?? "",
        showEmail: bool1.value,
        username: username.text,
        webAddress: weblink.text,
      );
      if (result) {
        ToastResp.toastMsgSuccess(resp: "Profile updated successfully");
        refreshUsersProfileData();
      } else {
        ToastResp.toastMsgError(resp: "Profile update not successful");
      }
    }

    useEffect(() {
      getUsersProfile();
      return null;
    }, []);
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
            child: userProfileLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                              File(image!.path).absolute,
                                            ),
                                          ),
                                        ),
                                      )
                                    : userProfileModel.value.data!.imgMain!
                                                .objectPublic ==
                                            false
                                        ? Center(
                                            child: customText(
                                              text:
                                                  "${userProfileModel.value.firstName![0].toUpperCase()} ${userProfileModel.value.lastName![0].toUpperCase()}",
                                              fontSize: 16,
                                              textColor: AppColors.primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(60),
                                              bottomRight: Radius.circular(60),
                                              topLeft: Radius.circular(60),
                                              topRight: Radius.circular(0),
                                            ),
                                            child: Image.network(
                                              "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${userProfileModel.value.data!.imgMain!.value}",
                                              scale: 1.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () => uploadImage(),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      size: 40,
                                      color: AppColors.deepPrimary,
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
                                hintText: userProfileModel.value.firstName,
                              ),
                              heightSpace(1),
                              AppTextFormField(
                                validator: emptyStringValidation,
                                textEditingController: lastName,
                                label: "Last Name",
                                hintText: userProfileModel.value.lastName,
                              ),
                              heightSpace(1),
                              AppTextFormField(
                                validator: emptyStringValidation,
                                textEditingController: username,
                                label: "UserName",
                                hintText: userProfileModel.value.username,
                              ),
                              heightSpace(1),
                              AppTextFormField(
                                validator: emptyStringValidation,
                                textEditingController: about,
                                label: "About Me",
                                hintText:
                                    userProfileModel.value.data!.about!.value ??
                                        "Say something about yourself",
                              ),
                              heightSpace(1),
                              AppTextFormField(
                                validator: emptyStringValidation,
                                textEditingController: weblink,
                                label: "Web Link",
                                hintText: userProfileModel
                                        .value.data!.webAddress!.value ??
                                    "Enter Web Link",
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
                                typeValue: userProfileModel
                                        .value.data!.gender!.value ??
                                    "Select option",
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
                                        text:
                                            userProfileModel.value.dob ?? "DOB",
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
                                hintText: "Enter First Name",
                              ),
                              heightSpace(1),
                              TextToggleFunction(
                                title: "Show Email:",
                                widget: Switch(
                                  value: bool1.value,
                                  activeColor: AppColors.deepPrimary,
                                  onChanged: (bool newValue) {
                                    bool1.value = newValue;

                                    if (bool1.value) {
                                      ToastResp.toastMsgSuccess(
                                        resp: "Show Email has been turned on",
                                      );
                                    } else {
                                      ToastResp.toastMsgError(
                                          resp:
                                              "Show Email has been turned off");
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
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: customText(
                                        text: userProfileModel.value.data!
                                                .mobilePhone!.value ??
                                            "",
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
}

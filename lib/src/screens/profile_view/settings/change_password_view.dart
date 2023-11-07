import 'dart:io';

import 'package:chases_scroll/src/repositories/profile_repository.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/helpers/validations.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordScreenView extends StatefulWidget {
  const ChangePasswordScreenView({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreenView> createState() =>
      _ChangePasswordScreenViewState();
}

class _ChangePasswordScreenViewState extends State<ChangePasswordScreenView> {
  final currentPassword = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();
  bool _isHiddenNew = true;
  bool _isHiddenOld = true;
  bool _isHiddenConfirm = true;

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  final ProfileRepository _profileRepository = ProfileRepository();

  bool enable = false;
  bool enable2 = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: customText(
          text: "Change Password",
          fontSize: 14,
          textColor: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Platform.isIOS
                ? Icons.arrow_back_ios_new_rounded
                : Icons.arrow_back_rounded,
            size: 20,
            color: Colors.black87,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: PAD_ALL_20,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightSpace(5),
                  Center(child: Image.asset(AppImages.logo)),
                  heightSpace(2),
                  AppTextFormField(
                    validator: passwordValidation,
                    textEditingController: currentPassword,
                    label: "Current password",
                    hintText: "Current password",
                    isPassword: true,
                  ),
                  heightSpace(2),
                  AppTextFormField(
                    validator: passwordValidation,
                    textEditingController: password,
                    label: "New password",
                    hintText: "New password",
                    isPassword: true,
                  ),
                  heightSpace(2),
                  enable && enable2
                      ? ChasescrollButton(
                          buttonText: "Change Password",
                          onTap: () => resetPassword(),
                          color: AppColors.deepPrimary,
                        )
                      : ChasescrollButton(
                          buttonText: "Change Password",
                          onTap: () => ToastResp.toastMsgError(
                              resp: "Fill in the right details to proceed"),
                          color: AppColors.primary.withOpacity(0.5),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getToggleEyesConfirm() {
    setState(() {
      _isHiddenConfirm = !_isHiddenConfirm;
    });
  }

  void getToggleEyesNew() {
    setState(() {
      _isHiddenNew = !_isHiddenNew;
    });
  }

  void getToggleEyesOld() {
    setState(() {
      _isHiddenOld = !_isHiddenOld;
    });
  }

  @override
  void initState() {
    super.initState();
    currentPassword.addListener(() {
      final enable = currentPassword.text.length >= 7 ? true : false;
      setState(() => this.enable = enable);
    });

    password.addListener(() {
      final enable2 = password.text.length >= 7 ? true : false;
      setState(() => this.enable2 = enable2);
    });
  }

  //function to edit profile
  //onsubmit to verify code
  void resetPassword() async {
    if (_formKey.currentState!.validate()) {
      if (_formKey.currentState!.validate()) {
        bool result = await _profileRepository.resetPassword(
          newPassword: password.text,
          oldPassword: currentPassword.text,
        );
        if (result) {
          ToastResp.toastMsgSuccess(resp: "Password updated successfuly");
          if (context.mounted) {
            context.pop();
          }
        } else {
          ToastResp.toastMsgError(resp: "Password not updating");
        }
      }
    }
  }
}

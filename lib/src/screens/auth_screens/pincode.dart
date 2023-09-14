import 'dart:developer';

import 'package:chases_scroll/src/repositories/auth_repository.dart';
import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/pin_widget.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/router/routes.dart';

class PinCodeScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final AuthRepository _authRepository = AuthRepository();
  final _formKey = GlobalKey<FormState>();
  final bool isSignup;
  String pincode = "";
  PinCodeScreen({super.key, required this.isSignup});

  @override
  Widget build(BuildContext context) {
    verify() async {
      if (pincode.length < 6) {
        ToastResp.toastMsgError(resp: "Enter a valid code");
        return;
      }
      bool result = await _authRepository.verifyPincode(pincode);
      if (result && context.mounted) {
        if (isSignup) {
          context.push(AppRoutes.emailScreen);
          return;
        }
        context.push(AppRoutes.newPassword, extra: pincode);

        log("signuped successfully");
      }
    }

    return Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                heightSpace(7),
                Center(child: Image.asset(AppImages.logo)),
                heightSpace(2),
                customText(
                    text: "Email Verification",
                    fontSize: 20,
                    textColor: AppColors.primary),
                heightSpace(2),
                customText(
                    text:
                        "Email  Verification A six digits code has been sent to your email for verification.",
                    fontSize: 14,
                    textAlignment: TextAlign.center,
                    textColor: AppColors.black),
                heightSpace(3),
                PinView(onChanged: (val) => pincode = val),
                heightSpace(3),
                ChasescrollButton(
                  buttonText: "Verify code",
                  onTap: verify,
                ),
                heightSpace(2),
              ],
            ),
          ),
        )));
  }
}

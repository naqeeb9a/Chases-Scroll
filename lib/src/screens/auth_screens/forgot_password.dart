import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/repositories/auth_repository.dart';
import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/helpers/validations.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static final _formKey = GlobalKey<FormState>();
  static final emailController = TextEditingController();
  static final AuthRepository _authRepository = AuthRepository();
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    sendEmail() async {
      if (_formKey.currentState!.validate()) {
        bool result = await _authRepository.sendEmail(emailController.text, 2);
        if (result) {
          if (context.mounted) {
            context.push(AppRoutes.pincode, extra: false);
          }
        }
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
                    text: "Chasescroll",
                    fontSize: 20,
                    textColor: AppColors.primary),
                heightSpace(2),
                AppTextFormField(
                  validator: emailValidation,
                  textEditingController: emailController,
                  label: "Forgot Password",
                  hintText: "Email Address",
                ),
                heightSpace(2),
                ChasescrollButton(
                  buttonText: "Next",
                  onTap: sendEmail,
                ),
                heightSpace(2),
                ChasescrollButton(
                  hasIcon: true,
                  iconWidget: SvgPicture.asset(AppImages.googleIcon),
                  buttonText: "Sign in with Google",
                  hasBorder: true,
                  borderColor: AppColors.grey,
                  textColor: AppColors.black,
                ),
                heightSpace(2),
                ChasescrollButton(
                  hasIcon: true,
                  iconWidget: SvgPicture.asset(AppImages.appleIcon),
                  buttonText: "Sign in with Apple",
                  hasBorder: true,
                  borderColor: AppColors.grey,
                  textColor: AppColors.black,
                ),
                heightSpace(2),
                Row(
                  children: [
                    customText(
                        text: "Don't have an account?",
                        fontSize: 12,
                        textColor: AppColors.black),
                    widthSpace(1),
                    InkWell(
                      onTap: sendEmail,
                      child: customText(
                          text: "Sign up",
                          fontSize: 12,
                          textColor: AppColors.primary),
                    )
                  ],
                )
              ],
            ),
          ),
        )));
  }
}

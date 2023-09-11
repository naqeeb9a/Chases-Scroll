import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/helpers/validations.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PinCodeScreen extends StatelessWidget {
  static final _formKey = GlobalKey<FormState>();
  static final emailController = TextEditingController();
  const PinCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading: const Icon(Icons.arrow_back_ios)),
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
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.push(AppRoutes.passwordScreen,
                          extra: emailController.text);
                    }
                  },
                ),
                heightSpace(2),
              ],
            ),
          ),
        )));
  }
}

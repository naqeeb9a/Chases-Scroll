import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/screens/auth_screens/data.dart';
import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/helpers/validations.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatelessWidget {
  static final emailController = TextEditingController();
  static final firstName = TextEditingController();
  static final lastName = TextEditingController();
  static final username = TextEditingController();
  static final password = TextEditingController();
  static final confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                heightSpace(5),
                Center(child: Image.asset(AppImages.logo)),
                heightSpace(2),
                customText(
                    text: "Sign Up", fontSize: 20, textColor: AppColors.black),
                heightSpace(2),
                AppTextFormField(
                  validator: stringValidation,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  ],
                  textEditingController: firstName,
                  hintText: "Enter First Name",
                ),
                heightSpace(.5),
                AppTextFormField(
                  validator: stringValidation,
                  textEditingController: lastName,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  ],
                  hintText: "Enter Last Name",
                ),
                heightSpace(.5),
                AppTextFormField(
                  validator: stringValidation,
                  textEditingController: username,
                  hintText: "Username",
                ),
                heightSpace(.5),
                AppTextFormField(
                  isPassword: true,
                  validator: passwordValidation,
                  textEditingController: password,
                  hintText: "Password",
                ),
                AppTextFormField(
                  isPassword: true,
                  validator: (val) {
                    if (val?.isEmpty??true) {
                      return "Atleast 2 characters is expected";
                    }
                    if (val != password.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  textEditingController: confirmPassword,
                  hintText: "Retype Password",
                ),
                heightSpace(4),
                ChasescrollButton(
                  buttonText: "Continue",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.push(AppRoutes.signuptwo,
                          extra: SignupOneModel(
                              firstname: firstName.text,
                              lastName: lastName.text,
                              username: username.text,
                              password: password.text,
                              retypePassword: confirmPassword.text));
                    }
                  },
                ),
                heightSpace(2),
                Row(
                  children: [
                    customText(
                        text: "Already have an account?",
                        fontSize: 12,
                        textColor: AppColors.black),
                    widthSpace(1),
                    InkWell(
                      onTap: () => context.push(AppRoutes.emailScreen),
                      child: customText(
                          text: "Log In",
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

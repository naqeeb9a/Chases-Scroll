import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/screens/auth_screens/data.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/helpers/validations.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignupTwoScreen extends StatelessWidget {
  static final _formKey = GlobalKey<FormState>();
  static final emailController = TextEditingController();
  static final fullName = TextEditingController();
  static final username = TextEditingController();
  static final password = TextEditingController();
  static final confirmPassword = TextEditingController();
  final SignupOneModel signupData;
  const SignupTwoScreen({super.key, required this.signupData});

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
                heightSpace(5),
                Center(child: Image.asset(AppImages.logo)),
                heightSpace(2),
                customText(
                    text: "Sign Up", fontSize: 20, textColor: AppColors.black),
                heightSpace(2),
                IntlPhoneField(
                  disableLengthCheck: false,
                  decoration: const InputDecoration(
                    counter: SizedBox.shrink(),
                    labelText: 'Phone Number',
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    contentPadding: EdgeInsets.only(left: 10),
                    errorStyle: TextStyle(fontSize: 14),
                  ),
                  initialCountryCode: 'NG',
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                ),
                AppTextFormField(
                  validator: stringValidation,
                  textEditingController: username,
                  hintText: "Email Address",
                ),
                heightSpace(.5),
                heightSpace(4),
                ChasescrollButton(
                  buttonText: "Continue",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.push(AppRoutes.passwordScreen,
                          extra: emailController.text);
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
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.push(AppRoutes.emailScreen,
                              extra: emailController.text);
                        }
                      },
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

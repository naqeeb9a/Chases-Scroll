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
import 'package:go_router/go_router.dart';

class NewPassword extends StatelessWidget {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final AuthRepository _authRepository = AuthRepository();
  final String token;
  final _formKey = GlobalKey<FormState>();
  NewPassword({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    void confirmPassword() async {
      if (_formKey.currentState!.validate()) {
        bool result = await _authRepository.changePassword(
            passwordController.text, token);

        if (result) {
          if (context.mounted) {
            context.push(AppRoutes.successPassword);
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
                heightSpace(3),
                AppTextFormField(
                  textEditingController: passwordController,
                  validator: passwordValidation,
                  label: "New Password",
                  hintText: "Password",
                ),
                heightSpace(2),
                AppTextFormField(
                  textEditingController: confirmPasswordController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Password can't be empty";
                    }
                    if (val != passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  hintText: "Confirm Password",
                ),
                heightSpace(3),
                ChasescrollButton(
                  buttonText: "Submit",
                  onTap: confirmPassword,
                ),
                heightSpace(2),
              ],
            ),
          ),
        )));
  }
}

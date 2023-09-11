import 'package:chases_scroll/src/repositories/auth_repository.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/helpers/validations.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';

class PasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final String email;
  final password = TextEditingController();
  final AuthRepository _authRepository = AuthRepository();
  PasswordScreen({super.key, required this.email});

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
                    text: "Chasescroll",
                    fontSize: 20,
                    textColor: AppColors.primary),
                heightSpace(2),
                AppTextFormField(
                  textEditingController: password,
                  validator: passwordValidation,
                  label: "Enter your password",
                  hintText: "Password",
                ),
                heightSpace(2),
                Align(
                    alignment: Alignment.centerLeft,
                    child: customText(
                        text: "Forgot Password?",
                        fontSize: 12,
                        textColor: AppColors.primary)),
                heightSpace(2),
                ChasescrollButton(
                  buttonText: "Login",
                  onTap: login,
                ),
                heightSpace(2),
              ],
            ),
          ),
        )));
  }

  void login() {
    if (_formKey.currentState!.validate()) {
      _authRepository.login(email, password.text);
    }
  }
}

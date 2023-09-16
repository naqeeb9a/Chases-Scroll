import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuccessPassword extends StatelessWidget {
  static final emailController = TextEditingController();
  const SuccessPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              heightSpace(7),
              Center(child: Image.asset(AppImages.logo)),
              heightSpace(2),
              customText(
                  text: "Thank you",
                  fontSize: 20,
                  textColor: AppColors.primary),
              heightSpace(2),
              customText(
                  text: "Your password has been changed successfully.",
                  fontSize: 14,
                  textAlignment: TextAlign.center,
                  textColor: AppColors.black),
              heightSpace(3),
              ChasescrollButton(
                buttonText: "Continue",
                onTap: () {
                  context.push(
                    AppRoutes.emailScreen,
                  );
                },
              ),
              heightSpace(2),
            ],
          ),
        )));
  }
}

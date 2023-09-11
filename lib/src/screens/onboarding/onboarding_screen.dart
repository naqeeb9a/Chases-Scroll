import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/screens/onboarding/data.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_view_indicator/flutter_page_view_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(children: [
            heightSpace(5),
            Center(
              child: Image.asset(AppImages.onboarding),
            ),
            heightSpace(5),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: PageView.builder(
                itemCount: sentences.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          customText(
                              textAlignment: TextAlign.center,
                              text: sentences[index],
                              fontSize: 18,
                              textColor: AppColors.black),
                          heightSpace(5),
                          PageViewIndicator(
                            length: sentences.length,
                            currentIndex: currentIndex,
                            currentColor: Colors.black,
                            otherColor: Colors.grey.shade300,
                            currentSize: 8,
                            otherSize: 8,
                            margin: const EdgeInsets.all(5),
                            borderRadius: 9999.0,
                            alignment: MainAxisAlignment.center,
                            animationDuration:
                                const Duration(milliseconds: 750),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                onPageChanged: (int v) {
                  currentIndex = v;
                  setState(() {});
                },
              ),
            ),
            heightSpace(3),
            ChasescrollButton(
                onTap: () => context.push(AppRoutes.signupone),
                buttonText: "Sign Up"),
            heightSpace(2),
            Row(
              children: [
                const Expanded(
                    child: Divider(
                  color: AppColors.grey,
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: customText(
                      text: "Or", fontSize: 12, textColor: AppColors.grey),
                ),
                const Expanded(
                    child: Divider(
                  color: AppColors.grey,
                )),
              ],
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
              onTap: () => context.push(AppRoutes.signupone),
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
          ]),
        ),
      ),
    );
  }
}

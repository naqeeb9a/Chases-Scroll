import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(children: [
          heightSpace(18),
          Center(
            child: Image.asset(AppImages.onboarding),
          ),
          heightSpace(5),
          customText(
              text: "Discover fun and unique \n events in your location",
              fontSize: 24,
              textColor: AppColors.black),
          heightSpace(3),
          SizedBox(
            width: 200,
            child: ChasescrollButton(
              buttonText: "Explore",
              onTap: () => context.push(AppRoutes.onboarding),
            ),
          )
        ]),
      )),
    );
  }
}

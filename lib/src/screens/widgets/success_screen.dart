import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventSuccessScreenView extends StatelessWidget {
  final String? widgetScreenString;

  const EventSuccessScreenView({Key? key, this.widgetScreenString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: PAD_ALL_15,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.successImage,
                ),
                customText(
                  text: "Payment\nSuccessful",
                  fontSize: 18,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.w500,
                  lines: 3,
                  textAlignment: TextAlign.center,
                ),
                heightSpace(3),
                ChasescrollButton(
                  buttonText: "Continue",
                  onTap: () {
                    context.push(widgetScreenString!);
                  },
                )
                // mainButton(
                //   width / 1.4,
                //   "Continue",
                //   function: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (context) => const ThreeDotLoadingScreenView(
                //           screen: PaidTicketDetailsScreenView(),
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

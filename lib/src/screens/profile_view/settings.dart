import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/screens/profile_view/widgets/icon_row_profile.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/helpers/pop_ups.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SettingsScreenView extends StatefulWidget {
  const SettingsScreenView({Key? key}) : super(key: key);

  @override
  State<SettingsScreenView> createState() => _SettingsScreenViewState();
}

class _SettingsScreenViewState extends State<SettingsScreenView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: customText(
          text: "Settings",
          fontSize: 14,
          textColor: AppColors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          color: Colors.white,
          child: Padding(
            padding: PAD_ALL_15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45, width: 0.2),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        iconTextRowContiner(
                          width,
                          "Payment",
                          AppImages.payment,
                          () => context.push(AppRoutes.settingPayment),
                        ),
                        heightSpace(2),
                        iconTextRowContiner(
                          width,
                          "Event DashBoard",
                          AppImages.eventDashboard,
                          () {},
                        ),
                        heightSpace(2),
                        iconTextRowContiner(
                          width,
                          "Change Password",
                          AppImages.changePassword,
                          () => context.push(AppRoutes.changePassword),
                        ),
                        heightSpace(2),
                        iconTextRowContiner(
                          width,
                          "Account Settings",
                          AppImages.accountSetting,
                          () => context.push(AppRoutes.accountSetting),
                        ),
                      ],
                    ),
                  ),
                ),
                heightSpace(2),
                customText(
                  text: "Support & Help",
                  fontSize: 12,
                  textColor: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
                heightSpace(2),
                Container(
                  width: width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45, width: 0.2),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        iconTextRowContiner(
                          width,
                          "Terms and Conditions",
                          AppImages.shield,
                          () => context.push(AppRoutes.terms),
                        ),
                        heightSpace(2),
                        iconTextRowContiner(
                          width,
                          "Privacy Policy",
                          AppImages.shield,
                          () => context.push(AppRoutes.privacy),
                        ),
                        heightSpace(2),
                        iconTextRowContiner(
                          width,
                          "Report a Bug",
                          AppImages.bug,
                          () => context.push(AppRoutes.reportBug),
                        ),
                        heightSpace(2),
                        iconTextRowContiner(
                          width,
                          "Request an Enhancement",
                          AppImages.arrowUp,
                          () => context.push(AppRoutes.enhancement),
                        ),
                        heightSpace(2),
                        iconTextRowContiner(
                          width,
                          "Blocked Users",
                          AppImages.block,
                          () {},
                        ),
                      ],
                    ),
                  ),
                ),
                heightSpace(2),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => showDialogDelete(context),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppImages.deleteAccount,
                              height: 25,
                              width: 25,
                            ),
                            widthSpace(5),
                            customText(
                              text: "Delete Account",
                              fontSize: 12,
                              textColor: AppColors.red,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),
                      heightSpace(1),
                      GestureDetector(
                        onTap: () => showDialogLogout(context),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppImages.logout,
                              height: 25,
                              width: 25,
                            ),
                            widthSpace(5),
                            customText(
                              text: "Logout",
                              fontSize: 12,
                              textColor: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

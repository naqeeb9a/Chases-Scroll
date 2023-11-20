import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//delete account
Future<dynamic> showDialogDelete(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        backgroundColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              customText(
                  text: "Delete Account?",
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  lines: 2,
                  textColor: AppColors.red),
              heightSpace(2),
              customText(
                  text: "Are you sure you want to Delete your account",
                  fontSize: 12,
                  textColor: AppColors.black,
                  lines: 20,
                  textAlignment: TextAlign.center),
              heightSpace(2),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => context.push(AppRoutes.emailScreen),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 20,
                      child: Center(
                        child: customText(
                          text: 'Delete',
                          fontSize: 14,
                          textColor: AppColors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  heightSpace(2),
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.white),
                      height: 20,
                      child: Center(
                        child: customText(
                          text: 'Cancel',
                          fontSize: 14,
                          textColor: AppColors.textGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              heightSpace(1.5),
            ],
          ),
        ),
      );
    },
  );
}

Future<dynamic> showDialogLogout(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        backgroundColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              customText(
                  text: "“Log out?”",
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  lines: 2,
                  textColor: AppColors.black),
              heightSpace(2),
              customText(
                  text: "Are you sure you want to log out of of your account?",
                  fontSize: 12,
                  textColor: AppColors.black,
                  lines: 20,
                  textAlignment: TextAlign.center),
              heightSpace(2),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => context.push(AppRoutes.emailScreen),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 20,
                      child: Center(
                        child: customText(
                          text: 'Log Out',
                          fontSize: 14,
                          textColor: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  heightSpace(2),
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.white),
                      height: 20,
                      child: Center(
                        child: customText(
                          text: 'Cancel',
                          fontSize: 14,
                          textColor: AppColors.textGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              heightSpace(1.5),
            ],
          ),
        ),
      );
    },
  );
}

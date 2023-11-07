import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//this is for pop up menu item
PopupMenuItem buildPopupMenuItem(String title, Color color,
    {Function()? function}) {
  return PopupMenuItem(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: function,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customText(
                text: title,
                fontSize: 12,
                textColor: color,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
        heightSpace(0.3),
        const Divider(),
      ],
    ),
  );
}

GestureDetector gestureTextContiner(
    double width, String title, VoidCallback function) {
  return GestureDetector(
    onTap: function,
    child: SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(
            text: title,
            fontSize: 14,
            textColor: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
          heightSpace(1),
          const Divider(),
        ],
      ),
    ),
  );
}

GestureDetector iconTextRowContiner(
    double width, String title, String iconstring, VoidCallback function) {
  return GestureDetector(
    onTap: function,
    child: SizedBox(
      child: Row(
        children: [
          SvgPicture.asset(
            iconstring,
            height: 25,
            width: 25,
            color: AppColors.black.withOpacity(0.8),
          ),
          widthSpace(5),
          customText(
            text: title,
            fontSize: 14,
            textColor: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    ),
  );
}

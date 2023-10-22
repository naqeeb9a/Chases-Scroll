import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/images.dart';

class EmptyImageContainerWidget extends StatelessWidget {
  final Function()? function;
  const EmptyImageContainerWidget({
    super.key,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 25.h,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: const Color(0xffE0E0E0),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppImages.imageAdd,
              height: 60,
              width: 60,
            ),
            heightSpace(2),
            customText(
              text: "Tap Icon to upload Image from gallery",
              fontSize: 14,
              textColor: AppColors.black,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}

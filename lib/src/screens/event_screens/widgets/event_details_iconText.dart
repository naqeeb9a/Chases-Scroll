import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventDetailsIconText extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? subTitle2;
  final String? link;
  final String? iconString;

  const EventDetailsIconText({
    super.key,
    this.title,
    this.subTitle,
    this.subTitle2,
    this.link,
    this.iconString,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.deepPrimary.withOpacity(0.1),
          child: SvgPicture.asset(
            iconString.toString(),
            color: AppColors.deepPrimary,
          ),
        ),
        widthSpace(2),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(
              text: title.toString(),
              fontSize: 13,
              textColor: AppColors.deepPrimary,
              fontWeight: FontWeight.w700,
            ),
            Visibility(
              visible: subTitle == null ? false : true,
              child: customText(
                text: subTitle.toString(),
                fontSize: 11,
                textColor: AppColors.subtitleColors,
                fontWeight: FontWeight.w400,
              ),
            ),
            Visibility(
              visible: subTitle2 != null ? true : false,
              child: customText(
                text: subTitle2.toString(),
                fontSize: 11,
                textColor: AppColors.subtitleColors,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        )
      ],
    );
  }
}

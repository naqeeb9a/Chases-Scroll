import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventDetailsIconText extends StatefulWidget {
  final String? title;
  final String? subTitle;
  final String? subTitle2;
  final String? link;
  final String? iconString;
  final Function()? onlinktap;

  const EventDetailsIconText({
    super.key,
    this.title,
    this.subTitle,
    this.subTitle2,
    this.link,
    this.iconString,
    this.onlinktap,
  });

  @override
  State<EventDetailsIconText> createState() => _EventDetailsIconTextState();
}

class _EventDetailsIconTextState extends State<EventDetailsIconText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.deepPrimary.withOpacity(0.1),
          child: SvgPicture.asset(
            widget.iconString.toString(),
            color: AppColors.deepPrimary,
          ),
        ),
        widthSpace(2),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                text: widget.title.toString(),
                fontSize: 13,
                textColor: AppColors.deepPrimary,
                fontWeight: FontWeight.w700,
                textAlignment: TextAlign.left,
                lines: 1,
              ),
              Visibility(
                visible: widget.subTitle == null ? false : true,
                child: SizedBox(
                  width: 80.w,
                  child: customText(
                    text: widget.subTitle.toString(),
                    fontSize: 11,
                    textColor: AppColors.subtitleColors,
                    fontWeight: FontWeight.w400,
                    lines: 1,
                  ),
                ),
              ),
              Visibility(
                visible: widget.link == null ? false : true,
                child: GestureDetector(
                  onTap: widget.onlinktap,
                  child: SizedBox(
                    width: 80.w,
                    child: customText(
                      text: widget.link.toString(),
                      fontSize: 11,
                      textColor: AppColors.green,
                      fontWeight: FontWeight.w700,
                      lines: 2,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.subTitle2 != null ? true : false,
                child: SizedBox(
                  width: 80.w,
                  child: customText(
                    text: widget.subTitle2.toString(),
                    fontSize: 11,
                    textColor: AppColors.subtitleColors,
                    fontWeight: FontWeight.w400,
                    lines: 1,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

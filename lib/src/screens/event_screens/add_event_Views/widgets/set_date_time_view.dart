import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/constants/helpers/strings.dart';
import '../../../../utils/constants/images.dart';
import '../../../widgets/custom_fonts.dart';

class EventSetTimeView extends StatefulWidget {
  final Function()? function;
  final TimeOfDay? time;
  final String? title;
  const EventSetTimeView({super.key, this.function, this.title, this.time});

  @override
  State<EventSetTimeView> createState() => _EventSetTimeViewState();
}

class SetDateEventView extends StatefulWidget {
  final DateTime? dateTime;
  final String? title;
  final Function()? onpress;
  const SetDateEventView({super.key, this.dateTime, this.onpress, this.title});

  @override
  State<SetDateEventView> createState() => _SetDateEventViewState();
}

class _EventSetTimeViewState extends State<EventSetTimeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: Colors.grey.shade300,
        ),
      ),
      child: Padding(
        padding: PAD_ALL_5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customText(
                text: widget.title.toString(),
                fontSize: 11,
                textColor: AppColors.black,
                fontWeight: FontWeight.w400),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: widget.function,
                  icon: const Icon(
                    Icons.more_time,
                    color: AppColors.iconGrey,
                    size: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: customText(
                      text: formatTimeOfDay(widget.time as TimeOfDay),
                      fontSize: 14,
                      textColor: AppColors.black,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SetDateEventViewState extends State<SetDateEventView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: Colors.grey.shade300,
        ),
      ),
      child: Padding(
        padding: PAD_ALL_5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customText(
                text: widget.title.toString(),
                fontSize: 11,
                textColor: AppColors.black,
                fontWeight: FontWeight.w400),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: widget.onpress,
                  icon: SvgPicture.asset(
                    AppImages.calendarIcon,
                    height: 20,
                    width: 20,
                    color: AppColors.iconGrey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: customText(
                      text:
                          "${widget.dateTime!.day.toString().padLeft(2, '0')}/${widget.dateTime!.month.toString().padLeft(2, '0')}/${widget.dateTime!.year}",
                      fontSize: 14,
                      textColor: AppColors.black,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

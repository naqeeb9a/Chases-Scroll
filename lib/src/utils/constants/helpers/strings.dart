//String to initails
//this is to format the string value
//formatter from Time of Day to String
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../spacer.dart';

GestureDetector cardPaymentContainerGesture(String title, String iconstring,
    VoidCallback function, double heightWidth) {
  return GestureDetector(
    onTap: function,
    child: Container(
      decoration: BoxDecoration(
          color: const Color(0xffD0D4EB).withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.deepPrimary.withOpacity(.2))),
      child: Padding(
        padding: PAD_ASYM_H15_V35,
        child: Row(
          children: [
            SvgPicture.asset(
              iconstring,
              height: heightWidth,
              width: heightWidth,
            ),
            widthSpace(2),
            customText(
              text: title,
              fontSize: 14,
              textColor: AppColors.black,
            ),
          ],
        ),
      ),
    ),
  );
}

String formatTimeOfDay(TimeOfDay timeOfDay) {
  final now = DateTime.now();
  final dateTime =
      DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  final formattedTime = DateFormat.jm().format(dateTime);
  return formattedTime;
}

String getAcronym(String name) {
  // Split the name into individual words
  List<String> words = name.split(" ");

  // Initialize an empty string to store the initials
  String acronym = "";

  // Iterate through each word and get the initial letter
  for (String word in words) {
    if (word.isNotEmpty) {
      acronym += word[0].toUpperCase();
    }
  }

  return acronym;
}

GestureDetector payMethodContainerGesture(
    String title, String iconstring, VoidCallback function,
    {Widget? icon}) {
  return GestureDetector(
    onTap: function,
    child: Container(
      decoration: BoxDecoration(
          color: const Color(0xffD0D4EB).withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primary.withOpacity(.2))),
      child: Padding(
        padding: PAD_ASYM_H15_V35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  iconstring,
                  height: 25,
                  width: 25,
                  color: Colors.black87,
                ),
                widthSpace(2),
                customText(
                    text: title,
                    fontSize: 14,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w700,
                    lines: 2),
              ],
            ),
            Container(
              child: icon,
            ),
          ],
        ),
      ),
    ),
  );
}

Future<dynamic> showDialogBoard(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.white,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              customText(
                  text: "Why & how to add community funnel?",
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  textColor: AppColors.black),
              heightSpace(2),
              customText(
                  text:
                      """Link your event to a new or existing community so that all your attendees will be added automatically into a community. Here, they can ask questions, you can share future events and also network with other event attendees. You can organically grow any community of your choice, share pictures, videos, engage attendees in one on one chat or group chat.""",
                  fontSize: 12,
                  textColor: AppColors.black,
                  lines: 20),
              heightSpace(2),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: customText(
                    text: "Done",
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    textColor: AppColors.deepPrimary),
              ),
              heightSpace(1.5),
            ],
          ),
        ),
      );
    },
  );
}

class PlaceHolderTitle extends StatelessWidget {
  final String title;

  final String? star;
  final Color? color;
  const PlaceHolderTitle({
    Key? key,
    required this.title,
    this.star,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        customText(
          text: title,
          fontSize: 12,
          textColor: color ?? Colors.black87,
          fontWeight: FontWeight.w600,
          lines: 2,
        ),
        const SizedBox(width: 5),
        customText(
          text: star ?? '',
          fontSize: 18,
          textColor: AppColors.red,
          fontWeight: FontWeight.w600,
          lines: 2,
        ),
      ],
    );
  }
}

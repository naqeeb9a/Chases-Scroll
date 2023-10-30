//String to initails
//this is to format the string value
//formatter from Time of Day to String
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../spacer.dart';

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

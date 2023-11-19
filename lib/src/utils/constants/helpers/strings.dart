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

const String naira = "₦";

List<dynamic> bankList = [
  {"id": '14', "bank_code": '044', "name": 'Access Bank Nigeria Plc'},
  {"id": '16', "bank_code": '063', "name": 'Access Bank(Diamond)'},
  {"id": '15', "bank_code": '014', "name": 'Afribank Nigeria Plc'},
  {"id": '13', "bank_code": '401', "name": 'Aso Savings and Loans Ltd'},
  {"id": '38', "bank_code": '317\r\n', "name": 'Cellulant'},
  {"id": '58', "bank_code": '50823', "name": 'CEMCS Microfinance Bank'},
  {"id": '37', "bank_code": '303', "name": 'Chams Mobile'},
  {"id": '32', "bank_code": '023', "name": 'Citibank Nigeria'},
  {"id": '36', "bank_code": '302', "name": 'Eartholeum'},
  {"id": '17', "bank_code": '050', "name": 'Ecobank Nigeria Plc'},
  {"id": '54', "bank_code": '562', "name": 'Ekondo Microfinance Bank'},
  {"id": '18', "bank_code": '084', "name": 'Enterprise Bank Plc'},
  {"id": '19', 'bank_code': '070', 'name': 'Fidelity Bank Plc'},
  {"id": '8', "bank_code": '309', "name": 'First Bank Nigeria Mobile'},
  {"id": '20', "bank_code": '011', "name": 'First Bank Of Nigeria Plc'},
  {"id": '1', "bank_code": '214', "name": 'First City Monument Bank Plc'},
  {"id": '53', "bank_code": '00103', "name": 'Globus Bank'},
  {"id": '21', "bank_code": '058', "name": 'Guaranty Trust Bank Plc'},
  {"id": '52', "bank_code": '50383', "name": 'Hasal Microfinance Bank'},
  {"id": '22', "bank_code": '030', "name": 'Heritage Bank'},
  {'id': '30', 'bank_code': '301', 'name': 'Jaiz Bank Plc'},
  {'id': '23', "bank_code": '082', "name": 'Keystone Bank Plc'},
  {"id": '49', "bank_code": '50211', "name": 'Kuda Bank'},
  {"id": '33', 'bank_code': '014', "name": 'MainStreet Bank'},
  {"id": '48', "bank_code": '565', "name": 'One Finance'},
  {"id": '47', "bank_code": '526', "name": 'Parallex Bank'},
  {"id": '39', "bank_code": '526', "name": 'Parallex Microfinance Bank'},
  {"id": '9', "bank_code": '311', "name": 'Parkway'},
  {"id": '6', "bank_code": '305', "name": 'Paycom'},
  {"id": '46', "bank_code": '076', "name": 'Polaris Bank'},
  {'id': '31', "bank_code": '101', "name": 'Providus Bank'},
  {"id": '45', "bank_code": '125', 'name': 'Rubies MFB'},
  {"id": '24', 'bank_code': '076', "name": 'Skye Bank Plc'},
  {'id': '44', 'bank_code': '51310', "name": 'Sparkle Microfinance Bank'},
  {'id': '3', 'bank_code': '221', 'name': 'Stanbic - Ibtc Bank Plc'},
  {'id': '25', "bank_code": '068', 'name': 'Standard Chartered Bank'},
  {'id': '4', "bank_code": '232', 'name': 'Sterling Bank Plc'},
  {"id": '34', 'bank_code': '100', 'name': 'Suntrust Bank Nigeria'},
  {'id': '43', 'bank_code': '302', 'name': 'TAJ Bank'},
  {"id": '42', 'bank_code': '51211', 'name': 'TCF MFB'},
  {"id": '41', 'bank_code': '102', 'name': 'Titan Bank'},
  {"id": '26', 'bank_code': '032', "name": 'Union Bank Of Nigeria Plc'},
  {'id': '2', 'bank_code': '032', "name": 'Union Bank Plc'},
  {"id": '27', "bank_code": '033', "name": 'United Bank for africa Plc'},
  {"id": '35', "bank_code": '215', "name": 'Unity Bank Plc'},
  {"id": '40', "bank_code": '566', "name": 'VFD'},
  {"id": '28', "bank_code": '035', 'name': 'Wema Bank Plc'},
  {'id': '11', "bank_code": '322', "name": 'Zenith Bank Mobile'},
  {'id': '29', 'bank_code': '057', "name": 'Zenith Bank Plc'},
  {'id': '688', 'bank_code': '50515', "name": 'Moniepoint MFB'},
];

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
                  lines: 2,
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

class TextToggleFunction extends StatelessWidget {
  final String title;

  final String? subTitle;
  final Widget? widget;
  final Widget? widgetIcon;
  final Function()? iconFunction;
  const TextToggleFunction({
    super.key,
    required this.title,
    this.widget,
    this.subTitle,
    this.widgetIcon,
    this.iconFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: iconFunction,
                  child: customText(
                    text: title,
                    fontSize: 14,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(child: widget),
          ],
        ),
        heightSpace(0.3),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customText(
        {required String text,
        required double fontSize,
        required Color textColor,
        GlobalKey? key,
        FontWeight? fontWeight,
        TextAlign? textAlignment}) =>
    Text(text,
        key: key,
        textAlign: textAlignment ?? TextAlign.left,
        style: GoogleFonts.dmSans(
            textStyle: TextStyle(
                color: textColor,
                fontWeight: fontWeight ?? FontWeight.w500,
                fontSize: fontSize.dp)));

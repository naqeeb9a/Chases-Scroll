import 'package:flutter/material.dart';

class AppColors {
  static const Color red = Colors.red;
  static const Color white = Colors.white;
  static const Color blue = Colors.blue;
  static const Color black = Colors.black;
  static const Color primary = Color(0XFF5D70F9);
  static const Color grey = Color(0XFFD0D5DD);
  static const Color lightGrey = Color(0xffECECEC);
  static const Color textGrey = Color(0xFF9E9595);
  static const Color textFormColor = Color(0x3FD0D4EB);
  static const Color searchTextGrey = Color(0xff667085);

  static const Color deepPrimary = Color(0xff1732F7);
  static const Color backgroundGrey = Color(0xffF5F5F5);
  static const Color green = Colors.green;
  static const Color iconGrey = Color(0xffD0D4EB);
  static const Color subtitleColors = Color(0xff6B6B6B);

  static OutlineInputBorder errorBorder = const OutlineInputBorder(
      borderSide: BorderSide(
        color: red,
      ),
      borderRadius: BorderRadius.all(Radius.circular(5)));
  static OutlineInputBorder normalBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.grey),
      borderRadius: BorderRadius.all(Radius.circular(5)));

  static OutlineInputBorder emptyBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.grey),
      borderRadius: BorderRadius.all(Radius.circular(5)));
}

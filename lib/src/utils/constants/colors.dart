import 'package:flutter/material.dart';

class AppColors {
  static const Color red = Colors.red;
  static const Color white = Colors.white;
  static const Color blue = Colors.blue;
  static const Color black = Colors.black;
  static const Color primary = Color(0XFF5D70F9);
  static const Color grey = Color(0XFFD0D5DD);
  static const Color searchTextGrey = Color(0xff667085);
  static const Color lightGrey = Color(0xffD9D9D9);
  static const Color deepPrimary = Color(0xff1732F7);
  static const Color backgroundGrey = Color(0xffF5F5F5);
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

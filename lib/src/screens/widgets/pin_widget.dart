import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../utils/constants/colors.dart';

class PinView extends StatelessWidget {
  final Function(String) onChanged;

  final TextEditingController? controller;
  const PinView({
    super.key,
    required this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      onChanged: onChanged,
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
      enableIMEPersonalizedLearning: true,
      animationCurve: Curves.easeIn,
      animationDuration: const Duration(milliseconds: 100),
      defaultPinTheme: PinTheme(
          textStyle: const TextStyle(fontSize: 16),
          height: 57,
          width: 65,
          decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.grey.withOpacity(.3)),
              borderRadius: BorderRadius.circular(9))),
      focusedPinTheme: PinTheme(
          height: 57,
          width: 65,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey),
              borderRadius: BorderRadius.circular(9))),
    );
  }
}

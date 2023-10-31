import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class RowTextGestureView extends StatelessWidget {
  final String? leftText;
  final String? rightText;
  final Function()? function;

  const RowTextGestureView(
      {super.key, this.leftText, this.rightText, this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        customText(
          text: leftText.toString(),
          fontSize: 16,
          textColor: AppColors.black,
          fontWeight: FontWeight.w700,
        ),
        GestureDetector(
          onTap: function,
          child: customText(
            text: rightText ?? "See all",
            fontSize: 12,
            textColor: AppColors.deepPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ]),
    );
  }
}

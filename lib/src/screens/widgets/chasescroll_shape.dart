import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/helpers/extract_first_letter.dart';
import 'package:flutter/material.dart';

import 'custom_fonts.dart';

class ChaseScrollContainer extends StatelessWidget {
  final String name;
  final String? imageUrl;
  const ChaseScrollContainer({super.key, required this.name, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary, width: 2),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(0),
            )),
        child: Center(
          child: customText(
              text: extractFirstLetters(name),
              fontSize: 10,
              textColor: AppColors.primary),
        ));
  }
}

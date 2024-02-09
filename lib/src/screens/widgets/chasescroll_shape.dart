import 'package:cached_network_image/cached_network_image.dart';
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
          color: AppColors.white,
          border: Border.all(color: AppColors.primary, width: 1),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            topRight: Radius.circular(0),
          )),
      child: imageUrl == null
          ? Center(
              child: customText(
                  text: extractFirstLetters(name),
                  fontSize: 10,
                  textColor: AppColors.primary),
            )
          : ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
                topLeft: Radius.circular(50),
                topRight: Radius.circular(0),
              ),
              child: CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Center(
                  child: customText(
                      text: extractFirstLetters(name),
                      fontSize: 10,
                      textColor: AppColors.primary),
                ),
              ),
            ),
    );
  }
}

import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';

import '../../../widgets/custom_fonts.dart';

class AddEventExtendedTextLeft extends StatelessWidget {
  final Function()? function;
  final String? title;
  final Alignment? alignment;
  const AddEventExtendedTextLeft({
    super.key,
    required this.function,
    required this.title,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        child: Align(
          alignment: alignment ?? Alignment.centerLeft,
          child: customText(
              text: title!,
              fontSize: 14,
              textColor: AppColors.black,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

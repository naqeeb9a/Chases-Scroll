import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChasescrollButton extends StatelessWidget {
  final Function()? onTap;
  final Color color;
  final Color? textColor;
  final String? buttonText;
  final bool hasIcon;
  final Widget? iconWidget;

  final bool isButtonEnabled;
  final bool hasBorder;
  final double? height;
  final Color? borderColor;
  const ChasescrollButton(
      {Key? key,
      this.onTap,
      this.color = AppColors.primary,
      this.textColor,
      this.buttonText,
      this.hasIcon = false,
      this.iconWidget,
      this.isButtonEnabled = true,
      this.hasBorder = false,
      this.height = 50,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapDown: (_) => HapticFeedback.lightImpact(),
      onTap: isButtonEnabled ? onTap : null,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: !hasBorder ? color : null,
          borderRadius: BorderRadius.circular(40),
          border: hasBorder
              ? Border.all(color: borderColor!)
              : Border.all(width: 0, color: color),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hasIcon ? iconWidget! : const SizedBox.shrink(),
            hasIcon
                ? const SizedBox(
                    width: 15,
                  )
                : const SizedBox.shrink(),
            Center(
              child: Text(
                buttonText!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: textColor ?? AppColors.white),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

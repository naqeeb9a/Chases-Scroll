import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants/colors.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final bool hasPrefixConstraint;
  final bool isAddress;
  final String? label;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final bool? isNewPassword;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String? error;
  final ValueChanged<String>? onChanged;
  final Function(String)? onSubmitted;
  final TextInputType keyboardType;
  final int? maxLines;
  final bool? isEnabled;
  final int? maxLength;
  final String? initialValue;
  final bool? showPasswordRequirementContainer;
  const AppTextFormField({
    super.key,
    this.hasPrefixConstraint = true,
    this.isAddress = false,
    this.isNewPassword,
    this.suffixIcon,
    this.maxLength,
    this.label,
    this.inputFormatters,
    this.onChanged,
    this.hintText,
    this.error,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.textEditingController,
    this.isPassword = false,
    this.maxLines,
    this.isEnabled,
    this.validator,
    this.onSubmitted,
    this.showPasswordRequirementContainer,
    this.initialValue,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool isPasswordShow = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          customText(
              text: '${widget.label}',
              fontSize: 14,
              textColor: AppColors.black),
        heightSpace(1),
        TextFormField(
          maxLines: widget.maxLines ?? 1,
          inputFormatters: widget.inputFormatters,
          cursorWidth: 0.9,
          maxLength: widget.maxLength,
          enabled: widget.isEnabled,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          keyboardType: widget.keyboardType,
          controller: widget.textEditingController,
          obscureText: isPasswordShow ? false : widget.isPassword,
          validator: widget.validator,
          style: const TextStyle(fontSize: 14),
          initialValue: widget.initialValue,
          decoration: InputDecoration(
              prefixIconConstraints: const BoxConstraints(
                minWidth: 10,
              ),
              disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              errorText: widget.error,
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              contentPadding: widget.maxLines == null
                  ? const EdgeInsets.only(left: 10)
                  : const EdgeInsets.all(10),
              errorStyle: const TextStyle(fontSize: 14),
              // suffixIcon:  showPasswordIcon(widget.isPassword),

              suffixIcon: (() {
                if (widget.isPassword) {
                  return showPasswordIcon(widget.isPassword);
                }

                if (widget.suffixIcon != null) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: widget.suffixIcon,
                  );
                }
              }()),
              hintText: widget.hintText,
              hintStyle: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      color: AppColors.black.withOpacity(.5),
                      fontWeight: FontWeight.w500,
                      fontSize: 12.dp)),
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.all(15),
                      child: widget.prefixIcon,
                    )
                  : null,
              // suffix: widget.suffixIcon,
              fillColor: AppColors.white,
              filled: true,
              enabledBorder: AppColors.normalBorder,
              errorBorder: AppColors.errorBorder,
              focusedBorder: AppColors.normalBorder,
              focusedErrorBorder: AppColors.normalBorder),
        ),
      ],
    );
  }

  showPasswordIcon(bool isPassword) {
    if (isPassword) {
      if (isPasswordShow) {
        return IconButton(
          icon: const Icon(
            Icons.visibility,
            color: AppColors.grey,
          ),
          onPressed: () => setState(() {
            isPasswordShow = !isPasswordShow;
          }),
        );
      }
      return IconButton(
        icon: const Icon(
          Icons.visibility_off,
          size: 18,
          color: AppColors.grey,
        ),
        onPressed: () => setState(() {
          isPasswordShow = !isPasswordShow;
        }),
      );
    }
  }
}

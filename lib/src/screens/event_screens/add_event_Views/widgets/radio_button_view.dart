import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class RadioButtonView extends StatefulWidget {
  final String? radioGoLiveValue;
  final ValueChanged<String?>? onChanged;
  final String? title;
  final String? value;
  const RadioButtonView(
      {super.key,
      this.radioGoLiveValue,
      this.title,
      this.value,
      required this.onChanged});

  @override
  State<RadioButtonView> createState() => _RadioButtonViewState();
}

class _RadioButtonViewState extends State<RadioButtonView> {
  @override
  Widget build(BuildContext context) {
    return RadioListTile<String?>(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      controlAffinity: ListTileControlAffinity.trailing,
      title: customText(
        text: widget.title.toString(),
        fontSize: 13,
        textColor: AppColors.black,
        fontWeight: FontWeight.w400,
      ),
      value: widget.title,
      groupValue: widget.radioGoLiveValue,
      onChanged: widget.onChanged,
    );
  }
}

import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_fonts.dart';

class CheckBoxWidgetView extends StatefulWidget {
  final ValueChanged<bool?>? onChanged;
  final String? title;
  final bool? kind;
  const CheckBoxWidgetView({super.key, this.onChanged, this.kind, this.title});
  @override
  State<CheckBoxWidgetView> createState() => _CheckBoxWidgetViewState();
}

class _CheckBoxWidgetViewState extends State<CheckBoxWidgetView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      child: CheckboxListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
        controlAffinity: ListTileControlAffinity.trailing,
        activeColor: AppColors.deepPrimary,
        value: widget.kind,
        title: customText(
          text: widget.title.toString(),
          fontSize: 14,
          textColor: AppColors.searchTextGrey,
          textAlignment: TextAlign.left,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}

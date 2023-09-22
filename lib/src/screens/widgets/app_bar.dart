import 'dart:io';

import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/constants/colors.dart';

final _router = locator<GoRouter>();
appBar({
  final Widget? appBarActionWidget,
  final String? title,
}) =>
    AppBar(
      leading: GestureDetector(
        onTap: () => _router.pop(),
        child: Icon(
          Platform.isAndroid
              ? Icons.arrow_back_rounded
              : Icons.arrow_back_ios_new_rounded,
        ),
      ),
      centerTitle: true,
      title: title != null
          ? customText(
              text: title.toString(),
              fontSize: 14,
              textColor: AppColors.black,
              fontWeight: FontWeight.w600)
          : null,
      actions: [
        SizedBox(
          child: appBarActionWidget,
        ),
        widthSpace(2),
      ],
    );

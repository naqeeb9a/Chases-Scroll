import 'dart:io';

import 'package:chases_scroll/src/config/locator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _router = locator<GoRouter>();
appBar() => AppBar(
        leading: GestureDetector(
      onTap: () => _router.pop(),
      child: Icon(
        Platform.isAndroid
            ? Icons.arrow_back_rounded
            : Icons.arrow_back_ios_new_rounded,
      ),
    ));

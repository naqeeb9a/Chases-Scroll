import 'dart:io';

import 'package:chases_scroll/src/screens/profile_view/widgets/icon_row_profile.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';

class SettingsPaymentScreenView extends StatefulWidget {
  const SettingsPaymentScreenView({Key? key}) : super(key: key);

  @override
  State<SettingsPaymentScreenView> createState() =>
      _SettingsPaymentScreenViewState();
}

class _SettingsPaymentScreenViewState extends State<SettingsPaymentScreenView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Platform.isAndroid
                ? Icons.arrow_back_rounded
                : Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: customText(
          text: "Payment",
          fontSize: 14,
          textColor: AppColors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          color: Colors.white,
          child: Padding(
            padding: PAD_ALL_20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gestureTextContiner(
                  width,
                  "Wallet",
                  () {},
                ),
                heightSpace(1),
                gestureTextContiner(
                  width,
                  "Transfer History",
                  () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/drop_down_widget_view.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';

class RequestEnhancementScreenView extends StatefulWidget {
  int? currentIndex;

  RequestEnhancementScreenView({Key? key, this.currentIndex = 0})
      : super(key: key);

  @override
  _RequestEnhancementScreenViewState createState() =>
      _RequestEnhancementScreenViewState();
}

class _RequestEnhancementScreenViewState
    extends State<RequestEnhancementScreenView> {
  final _searchController = TextEditingController();

  //int currentIndex = 0;

  String? myListDaysValue = "Select option";
  final bool _isBlueContainerVisible = true;

  List<String> myListDays = [
    "Update ",
    "New Feature",
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(),
      appBar: AppBar(
        centerTitle: true,
        title: customText(
          text: "Suggested feature title",
          fontSize: 14,
          textColor: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Platform.isIOS
                ? Icons.arrow_back_ios_new_rounded
                : Icons.arrow_back_rounded,
            size: 20,
            color: Colors.black87,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: PAD_ALL_15,
          child: Column(
            children: [
              DropDownListViewString(
                typeValue: myListDaysValue,
                typeList: myListDays,
                onChanged: (value) {
                  setState(() {
                    myListDaysValue = value;
                  });
                },
                onSaved: (value) => myListDaysValue = value,
              ),
              AppTextFormField(
                textEditingController: _searchController,
                label: "",
                hintText: "Write your suggestion here . . .",
                maxLines: 10,
                maxLength: 300,
              ),
              heightSpace(3),
              ChasescrollButton(
                buttonText: "Submit Suggestion",
                onTap: () {
                  if (_searchController.text.isNotEmpty) {
                    ToastResp.toastMsgSuccess(
                        resp: "Report submitted successfully");
                  } else if (myListDaysValue!.isEmpty) {
                    ToastResp.toastMsgError(
                        resp: "Please select value from dropdown list");
                  } else {
                    ToastResp.toastMsgError(
                        resp: "Write feature details please");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

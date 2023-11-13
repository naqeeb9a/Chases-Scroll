import 'dart:io';

import 'package:chases_scroll/src/repositories/profile_repository.dart';
import 'package:chases_scroll/src/screens/event_screens/add_event_Views/widgets/drop_down_widget_view.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';

class ReportBugScreenView extends StatefulWidget {
  int? currentIndex;

  ReportBugScreenView({Key? key, this.currentIndex = 0}) : super(key: key);

  @override
  _ReportBugScreenViewState createState() => _ReportBugScreenViewState();
}

class _ReportBugScreenViewState extends State<ReportBugScreenView> {
  final _searchController = TextEditingController();

  final ProfileRepository _profileRepository = ProfileRepository();

  //int currentIndex = 0;

  String? myListDaysValue = "";
  final bool _isBlueContainerVisible = true;

  List<String> myListDays = [
    "Critical",
    "Technical",
    "Wrong Purpose",
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
          text: "Report a bug",
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
                typeValue: myListDaysValue!.isNotEmpty
                    ? myListDaysValue
                    : "Select Option",
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
                hintText: "Write your report in details here . . .",
                maxLines: 10,
                maxLength: 300,
              ),
              heightSpace(3),
              ChasescrollButton(
                buttonText: "Submit Suggestion",
                onTap: () async {
                  if (_searchController.text.isEmpty) {
                    ToastResp.toastMsgError(resp: "Report with description");
                  } else if (myListDaysValue!.isEmpty) {
                    ToastResp.toastMsgError(
                        resp: "Please select value from dropdown list");
                  } else {
                    final result = await _profileRepository.reportBug(
                      title: myListDaysValue,
                      description: _searchController.text,
                    );

                    if (result) {
                      ToastResp.toastMsgSuccess(
                          resp: "Report Bug Went Successfully");

                      _searchController.clear();
                    } else {
                      ToastResp.toastMsgError(
                          resp: "Reporting bugs not available now. Try later");
                    }
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

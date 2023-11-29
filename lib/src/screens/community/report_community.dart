import 'dart:developer';

import 'package:chases_scroll/src/repositories/community_repo.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ReportCommunity extends HookWidget {
  static final CommunityRepo _communityRepository = CommunityRepo();
  static final description = TextEditingController();
  final String typeId;
  const ReportCommunity({super.key, required this.typeId});

  @override
  Widget build(BuildContext context) {
    final reason = useState<String>("");

    reportCommunity() async {
      if (description.text.isEmpty) {
        ToastResp.toastMsgError(resp: "Description can't be empty");
        return;
      }

      if (reason.value.isEmpty) {
        ToastResp.toastMsgError(resp: "Select a reason");
        return;
      }
      bool result = await _communityRepository.reportCommunity(
          typeId: typeId,
          title: reason.value,
          description: description.text,
          reportType: "REPORT_COMMUNITY");

      if (result) {
        ToastResp.toastMsgSuccess(resp: "Successful");
      }
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
          title: customText(
              text: "Report Community",
              fontSize: 17,
              textColor: AppColors.black)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            heightSpace(2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFD0D4EB)),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                          text: "Spam",
                          fontSize: 14,
                          textColor: AppColors.textGrey),
                      Radio(
                        value: 'Spam',
                        groupValue: reason.value,
                        onChanged: (val) {
                          log(val.toString());
                          reason.value = val.toString();
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    color: AppColors.grey,
                  ),
                  heightSpace(1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                          text: "Pornography",
                          fontSize: 14,
                          textColor: AppColors.textGrey),
                      Radio(
                        value: 'Pornography',
                        groupValue: reason.value,
                        onChanged: (val) {
                          log(val.toString());
                          reason.value = val.toString();
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    color: AppColors.grey,
                  ),
                  heightSpace(1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                          text: "Personal Details",
                          fontSize: 14,
                          textColor: AppColors.textGrey),
                      Radio(
                        value: 'Personal Details',
                        groupValue: reason.value,
                        onChanged: (val) {
                          log(val.toString());
                          reason.value = val.toString();
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    color: AppColors.grey,
                  ),
                  heightSpace(1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                          text: "Others",
                          fontSize: 14,
                          textColor: AppColors.textGrey),
                      Radio(
                        value: 'Others',
                        groupValue: reason.value,
                        onChanged: (val) {
                          log(val.toString());
                          reason.value = val.toString();
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    color: AppColors.grey,
                  )
                ],
              ),
            ),
            heightSpace(2),
            AppTextFormField(
              textEditingController: description,
              hintText: "Brief Description",
              maxLength: 300,
              maxLines: 8,
            ),
            heightSpace(2),
            ChasescrollButton(
              onTap: reportCommunity,
              buttonText: "Submit",
            )
          ]),
        ),
      ),
    );
  }
}

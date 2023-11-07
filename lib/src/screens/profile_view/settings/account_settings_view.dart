import 'dart:io';

import 'package:chases_scroll/src/models/user_model.dart';
import 'package:chases_scroll/src/repositories/profile_repository.dart';
import 'package:chases_scroll/src/screens/profile_view/widgets/icon_row_profile.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class AccountSettingView extends HookWidget {
  static ProfileRepository profileRepository = ProfileRepository();

  const AccountSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final usersLoading = useState<bool>(true);
    final usersModel = useState<UserModel>(UserModel());

    void getUsersProfile() {
      profileRepository.getUserProfile().then((value) {
        usersLoading.value = false;
        usersModel.value = value!;
      });
    }

    //Radio button for _radioProfilePublic
    String radioProfilePrivate =
        usersModel.value.publicProfile == true ? 'public' : 'private';

    bool isLoading = false;

    void resetPassword() async {
      bool result = await profileRepository.accountSetting(
        publicProfile: radioProfilePrivate != "private" ? true : false,
      );
      if (result) {
        ToastResp.toastMsgSuccess(resp: "Account Setting updated successfuly");
        if (context.mounted) {
          context.pop();
        }
      } else {
        ToastResp.toastMsgError(resp: "Account Setting not updated");
      }
    }

    useEffect(
      () {
        getUsersProfile();
        return null;
      },
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: customText(
          text: "Account Settings",
          fontSize: 14,
          textColor: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
        toolbarHeight: 50,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Platform.isIOS
                ? Icons.arrow_back_ios_new_rounded
                : Icons.arrow_back_rounded,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: PAD_ALL_15,
          child: Column(
            children: [
              Container(
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45, width: 0.2),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: RadioListTile(
                                      dense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 0.0),
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      title: iconTextRowContiner(
                                        width,
                                        "Public",
                                        AppImages.public,
                                        () {},
                                      ),
                                      activeColor: AppColors.deepPrimary,
                                      value: 'public',
                                      groupValue: radioProfilePrivate,
                                      onChanged: (value) {
                                        radioProfilePrivate = value!;

                                        resetPassword();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          heightSpace(0.5),
                          const Divider(),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: RadioListTile(
                                      dense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 0.0),
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      title: iconTextRowContiner(
                                        width,
                                        "Private",
                                        AppImages.shield,
                                        () {},
                                      ),
                                      activeColor: AppColors.deepPrimary,
                                      value: 'private',
                                      groupValue: radioProfilePrivate,
                                      onChanged: (value) {
                                        radioProfilePrivate = value!;

                                        resetPassword();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          heightSpace(0.5),
                          const Divider(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

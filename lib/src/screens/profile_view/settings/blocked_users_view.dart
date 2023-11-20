import 'package:chases_scroll/src/models/blockedUser_model.dart';
import 'package:chases_scroll/src/repositories/profile_repository.dart';
import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class BlockedUsersView extends HookWidget {
  static final ProfileRepository _profileRepository = ProfileRepository();
  const BlockedUsersView({super.key});

  @override
  Widget build(BuildContext context) {
    //getting user details
    final blockedProfileloading = useState<bool>(true);
    final blockedProfileModel = useState<List<BlockedModel>>([]);

    void getBlockedProfile() {
      _profileRepository.getblockedUsers().then((value) {
        blockedProfileloading.value = false;
        blockedProfileModel.value = value;
      });
    }

    void refreshSuggestedUsers() {
      blockedProfileloading.value = false; // Set loading state back to true
      getBlockedProfile(); // Trigger the API call again
    }

    useEffect(() {
      getBlockedProfile();
      return null;
    }, []);

    return Scaffold(
      appBar: appBar(title: "Block Users View"),
      body: SafeArea(
        child: Padding(
          padding: PAD_ALL_15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                text: "Blocked Users",
                fontSize: 14,
                textColor: AppColors.black,
              ),
              heightSpace(2),
              blockedProfileloading.value
                  ? Expanded(
                      child: Center(
                        child: customText(
                          text: "No blocked user available",
                          fontSize: 14,
                          textColor: AppColors.black,
                        ),
                      ),
                    )
                  : Expanded(
                      child: SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: blockedProfileModel.value.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            BlockedModel? content =
                                blockedProfileModel.value[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              padding: PAD_ALL_5,
                              color: AppColors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(40),
                                              bottomRight: Radius.circular(40),
                                              topLeft: Radius.circular(40),
                                              topRight: Radius.circular(0),
                                            ),
                                            border: Border.all(
                                                width: 4,
                                                color: Colors.grey.shade300),
                                            color: Colors.grey,
                                          ),
                                          child: Center(
                                            child: customText(
                                                text: content.blockObject!
                                                            .firstName ==
                                                        null
                                                    ? ""
                                                    : "${content.blockObject!.firstName![0]}${content.blockObject!.lastName![0]}"
                                                        .toUpperCase(),
                                                fontSize: 12,
                                                textColor: AppColors.black,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                        widthSpace(2),
                                        SizedBox(
                                          width: 45.w,
                                          //color: Colors.amber,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              customText(
                                                  text: content.blockObject!
                                                              .firstName ==
                                                          null
                                                      ? ""
                                                      : "${content.blockObject!.firstName!} ${content.blockObject!.lastName!}",
                                                  fontSize: 12,
                                                  lines: 2,
                                                  textColor: AppColors.black,
                                                  fontWeight: FontWeight.w700),
                                              customText(
                                                  text:
                                                      "${content.blockObject!.email}",
                                                  fontSize: 12,
                                                  lines: 2,
                                                  textColor: AppColors.black
                                                      .withOpacity(0.5),
                                                  fontWeight: FontWeight.w400),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          final result =
                                              await _profileRepository
                                                  .unblockUser(
                                                      userID: content.id);
                                          if (result) {
                                            ToastResp.toastMsgSuccess(
                                                resp:
                                                    "User has been unblocked");

                                            refreshSuggestedUsers();
                                          } else {
                                            ToastResp.toastMsgError(
                                                resp:
                                                    "unblocking user was not successfull");
                                          }
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColors.white,
                                            ),
                                            color: AppColors.grey,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: customText(
                                                text: "Unblock",
                                                fontSize: 12,
                                                textColor: AppColors.black),
                                          ),
                                        ),
                                      ),
                                      widthSpace(1),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
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

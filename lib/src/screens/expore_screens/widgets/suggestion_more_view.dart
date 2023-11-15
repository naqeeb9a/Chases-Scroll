import 'dart:developer';

import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/repositories/explore_repository.dart';
import 'package:chases_scroll/src/screens/profile_view/widgets/icon_row_profile.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/shimmer_.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';

import '../../../models/event_model.dart';
import '../../widgets/app_bar.dart';

class SuggestionFriendMore extends HookWidget {
  static final ExploreRepository _exploreRepository = ExploreRepository();
  const SuggestionFriendMore({super.key});

  @override
  Widget build(BuildContext context) {
    final usersModel = useState<List<ContentUser>>([]);
    final usersLoading = useState<bool>(true);

    getSuggestedUsers() {
      _exploreRepository.getSuggestedUsers().then((value) {
        usersLoading.value = false;
        usersModel.value = value;
      });
    }

    void refreshSuggestedUsers() {
      usersLoading.value = false; // Set loading state back to true
      getSuggestedUsers(); // Trigger the API call again
    }

    connectFriend(String friendID) async {
      final result =
          await _exploreRepository.connectWithFriend(friendID: friendID);
      if (result['updated'] == true) {
        ToastResp.toastMsgSuccess(resp: result['message']);
        log(result.toString());
        refreshSuggestedUsers();
      } else {
        ToastResp.toastMsgError(resp: result['message']);
      }
    }

    disconnectFriend(String friendID) async {
      final result =
          await _exploreRepository.disconnectWithFriend(friendID: friendID);
      if (result['updated'] == true) {
        ToastResp.toastMsgSuccess(resp: result['message']);
        log(friendID.toString());
        log(result.toString());
        refreshSuggestedUsers();
      } else {
        log(friendID.toString());
        log(result.toString());
        ToastResp.toastMsgError(resp: result['message']);
      }
    }

    useEffect(() {
      getSuggestedUsers();
      return null;
    }, []);
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: appBar(
        title: "Suggestions",
      ),
      body: SafeArea(
        child: Padding(
          padding: PAD_ALL_GENERAL,
          child: Column(
            children: [
              usersLoading.value
                  ? usersHoriShimmerWithlength(
                      count: 6,
                    )
                  : Expanded(
                      child: SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: usersModel.value.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            ContentUser? content = usersModel.value[index];
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
                                    child: GestureDetector(
                                      onTap: () {
                                        context.push(
                                            AppRoutes.otherUsersProfile,
                                            extra: content.userId);
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(40),
                                                bottomRight:
                                                    Radius.circular(40),
                                                topLeft: Radius.circular(40),
                                                topRight: Radius.circular(0),
                                              ),
                                              color: Colors.grey.shade300,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${content.data!.imgMain!.value.toString()}"),
                                              ),
                                            ),
                                            child: Center(
                                              child: customText(
                                                  text: content.data!.imgMain!
                                                              .objectPublic ==
                                                          false
                                                      ? content.firstName!
                                                              .isEmpty
                                                          ? ""
                                                          : "${content.firstName![0]}${content.lastName![0]}"
                                                              .toUpperCase()
                                                      : "",
                                                  fontSize: 12,
                                                  textColor:
                                                      AppColors.deepPrimary,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          widthSpace(2),
                                          SizedBox(
                                            width: 40.w,
                                            //color: Colors.amber,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                customText(
                                                    text:
                                                        "${content.firstName} ${content.lastName}",
                                                    fontSize: 11,
                                                    textColor: AppColors.black,
                                                    fontWeight:
                                                        FontWeight.w700),
                                                customText(
                                                    text: "Shared Affilations",
                                                    fontSize: 11,
                                                    textColor: AppColors
                                                        .searchTextGrey,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          if (content.joinStatus !=
                                              "FRIEND_REQUEST_SENT") {
                                            connectFriend(content.userId!);
                                          } else {
                                            disconnectFriend(content.userId!);
                                          }
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: content.joinStatus ==
                                                      "NOT_CONNECTED"
                                                  ? AppColors.primary
                                                  : AppColors.white,
                                            ),
                                            color: content.joinStatus ==
                                                    "FRIEND_REQUEST_SENT"
                                                ? AppColors.btnOrange
                                                    .withOpacity(0.3)
                                                : content.joinStatus ==
                                                        "CONNECTED"
                                                    ? AppColors.primary
                                                    : AppColors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: customText(
                                              text: content.joinStatus ==
                                                      "CONNECTED"
                                                  ? "Connected"
                                                  : content.joinStatus ==
                                                          "NOT_CONNECTED"
                                                      ? "Connect"
                                                      : content.joinStatus ==
                                                              "FRIEND_REQUEST_SENT"
                                                          ? "Pending"
                                                          : "",
                                              fontSize: 12,
                                              textColor: content.joinStatus ==
                                                      "FRIEND_REQUEST_SENT"
                                                  ? AppColors.btnOrange
                                                  : AppColors.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                      widthSpace(1),
                                      PopupMenuButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        position: PopupMenuPosition.under,
                                        color: Colors.white,
                                        child: Container(
                                          child: const Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: Icon(
                                                  Icons.more_vert_outlined)),
                                        ),
                                        itemBuilder: (ctx) => [
                                          buildPopupMenuItem2(
                                              'Block User', AppColors.black,
                                              function: () async {
                                            final result =
                                                await _exploreRepository
                                                    .blockFriend(
                                                        friendID:
                                                            content.userId);
                                            if (result['updated'] == true) {
                                              ToastResp.toastMsgSuccess(
                                                  resp: result['message']);

                                              log(result.toString());
                                              refreshSuggestedUsers();
                                            } else {
                                              log(result.toString());
                                              ToastResp.toastMsgError(
                                                  resp: result['message']);
                                            }
                                          }),
                                        ],
                                      ),
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

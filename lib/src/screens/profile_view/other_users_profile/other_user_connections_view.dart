import 'dart:developer';
import 'dart:io';

import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/repositories/explore_repository.dart';
import 'package:chases_scroll/src/repositories/profile_repository.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/shimmer_.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class SeeOtherUsersConnectionsView extends HookWidget {
  static final ProfileRepository _profileRepository = ProfileRepository();
  static final ExploreRepository _exploreRepository = ExploreRepository();
  final String? userId;
  const SeeOtherUsersConnectionsView({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    //-------------------This is for Users -----------------------------------//
    final usersLoading = useState<bool>(true);
    final usersModel = useState<List<ContentUser>>([]);
    final allUsers = useState<List<ContentUser>>([]);
    final foundUsers = useState<List<ContentUser>>([]);

    getUsersConnection() {
      _profileRepository.getOtherUsersConnections(userID: userId).then((value) {
        usersLoading.value = false;
        usersModel.value = value;
        allUsers.value = value;
        foundUsers.value = value;
      });

      foundUsers.value.sort((a, b) {
        // First, compare by first name
        int firstNameComparison = a.firstName!.compareTo(b.firstName!);
        if (firstNameComparison != 0) {
          return firstNameComparison;
        }

        // If first names are the same, compare by last name
        return a.lastName!.compareTo(b.lastName!);
      });
    }

    refreshConnection() {
      usersLoading.value = false;
      getUsersConnection();
    }

    //for events filtered list
    void _runUsersFilter(String enteredKeyword) {
      log(enteredKeyword);
      if (enteredKeyword.isEmpty) {
        foundUsers.value = allUsers.value;
      } else {
        final found = allUsers.value
            .where((event) => event.firstName!
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();

        foundUsers.value = found;
      }
    }

    connectFriend(String friendID) async {
      final result =
          await _exploreRepository.connectWithFriend(friendID: friendID);
      if (result['updated'] == true) {
        ToastResp.toastMsgSuccess(resp: result['message']);
        log(result.toString());
        refreshConnection();
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
        refreshConnection();
      } else {
        log(friendID.toString());
        log(result.toString());
        ToastResp.toastMsgError(resp: result['message']);
      }
    }

    useEffect(() {
      getUsersConnection();
      return null;
    }, []);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        title: customText(
          text: "See More Users",
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
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 0, left: 15, right: 15),
            child: AppTextFormField(
              //textEditingController: searchController,
              //label: "",
              hintText: "Search for users, event or...",
              onChanged: (value) {
                //_runUsersFilter(value);

                _runUsersFilter(value);
              },
            ),
          ),
          heightSpace(2),
          Expanded(
            child: Container(
              child: usersLoading.value
                  ? usersHoriShimmerWithlength(
                      count: 6,
                    )
                  : SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: foundUsers.value.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          ContentUser? content = foundUsers.value[index];
                          return Container(
                            margin: const EdgeInsets.only(
                                bottom: 15, left: 15, right: 15),
                            padding: PAD_ALL_5,
                            color: AppColors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(40),
                                            bottomRight: Radius.circular(40),
                                            topLeft: Radius.circular(40),
                                            topRight: Radius.circular(0),
                                          ),
                                          color: Colors.grey.shade300,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            scale: 1.0,
                                            image: NetworkImage(
                                                "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${content.data!.imgMain!.value}"),
                                          ),
                                        ),
                                        child: Center(
                                          child: customText(
                                              text: content.data!.imgMain!
                                                          .value ==
                                                      null
                                                  ? content.firstName!.isEmpty
                                                      ? ""
                                                      : "${content.firstName![0]}${content.lastName![0]}"
                                                          .toUpperCase()
                                                  : "",
                                              fontSize: 12,
                                              textColor: AppColors.deepPrimary,
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
                                                fontWeight: FontWeight.w700),
                                            customText(
                                                text: "Shared Affilations",
                                                fontSize: 11,
                                                textColor:
                                                    AppColors.searchTextGrey,
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
                                        final result = await _exploreRepository
                                            .disconnectWithFriend(
                                                friendID: content.userId);
                                        if (result['updated'] == true) {
                                          ToastResp.toastMsgSuccess(
                                              resp: result['message']);
                                          refreshConnection();
                                          log(result.toString());
                                        } else {
                                          log(content.userId.toString());
                                          log(result.toString());
                                          ToastResp.toastMsgError(
                                              resp: result['message']);
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color:
                                              content.joinStatus == "CONNECTED"
                                                  ? AppColors.red
                                                  : AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: customText(
                                            text: content.joinStatus ==
                                                    "CONNECTED"
                                                ? "Disconnect"
                                                : content.joinStatus ==
                                                        "NOT_CONNECTED"
                                                    ? "Connect"
                                                    : content.joinStatus ==
                                                            "FRIEND_REQUEST_SENT"
                                                        ? "Pending"
                                                        : "",
                                            fontSize: 12,
                                            textColor: AppColors.white,
                                          ),
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
          )
        ],
      )),
    );
  }
}

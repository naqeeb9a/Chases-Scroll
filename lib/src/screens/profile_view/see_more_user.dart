import 'dart:developer';
import 'dart:io';

import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/repositories/explore_repository.dart';
import 'package:chases_scroll/src/repositories/profile_repository.dart';
import 'package:chases_scroll/src/screens/profile_view/widgets/icon_row_profile.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/shimmer_.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';

class SeeMoreUserView extends HookWidget {
  static final ProfileRepository _profileRepository = ProfileRepository();
  static final ExploreRepository _exploreRepository = ExploreRepository();
  const SeeMoreUserView({super.key});

  @override
  Widget build(BuildContext context) {
    //-------------------This is for Users -----------------------------------//
    final usersLoading = useState<bool>(true);
    final userRequestLoading = useState<bool>(true);
    final usersModel = useState<List<ContentUser>>([]);
    final allUsers = useState<List<ContentUser>>([]);
    final foundUsers = useState<List<ContentUser>>([]);

    //user connection request

    final userRequestModel = useState<List<dynamic>>([]);
    final allUsersRequest = useState<List<dynamic>>([]);
    final foundUsersRequest = useState<List<dynamic>>([]);

    getUsersConnectionRequests() {
      _profileRepository.getConnectionRequest("10").then((value) {
        usersLoading.value = false;
        userRequestModel.value = value;
        allUsersRequest.value = value;
        foundUsersRequest.value = value;
      });
    }

    getUsersConnection() {
      _profileRepository.getUserConnections().then((value) {
        usersLoading.value = false;
        usersModel.value = value;
        allUsers.value = value;
        foundUsers.value = value;
      });
    }

    refreshConnection() {
      usersLoading.value = false;
      getUsersConnection();
      getUsersConnectionRequests();
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

    //for _runUsersConnectionFilter filtered list
    void _runUsersConnectionFilter(String enteredKeyword) {
      log(enteredKeyword);
      if (enteredKeyword.isEmpty) {
        foundUsersRequest.value = allUsersRequest.value;
      } else {
        final found = allUsersRequest.value
            .where((event) => event['firstName']!
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();

        foundUsersRequest.value = found;
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
          child: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
                    _runUsersConnectionFilter(value);
                  },
                ),
              ),
              heightSpace(2),
              Container(
                padding: PAD_ALL_5,
                margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                height: 5.h,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: AppColors.subtitleColors,
                  tabs: const [
                    Tab(
                      text: 'Connects',
                    ),
                    Tab(
                      text: 'Requests',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: TabBarView(
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
                                  itemCount: foundUsers.value.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    ContentUser? content =
                                        foundUsers.value[index];
                                    return Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 15, left: 15, right: 15),
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
                                                      bottomLeft:
                                                          Radius.circular(40),
                                                      bottomRight:
                                                          Radius.circular(40),
                                                      topLeft:
                                                          Radius.circular(40),
                                                      topRight:
                                                          Radius.circular(0),
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
                                                        text: content
                                                                    .data!
                                                                    .imgMain!
                                                                    .value ==
                                                                null
                                                            ? content.firstName!
                                                                    .isEmpty
                                                                ? ""
                                                                : "${content.firstName![0]}${content.lastName![0]}"
                                                                    .toUpperCase()
                                                            : "",
                                                        fontSize: 12,
                                                        textColor: AppColors
                                                            .deepPrimary,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                widthSpace(2),
                                                SizedBox(
                                                  width: 40.w,
                                                  //color: Colors.amber,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      customText(
                                                          text:
                                                              "${content.firstName} ${content.lastName}",
                                                          fontSize: 11,
                                                          textColor:
                                                              AppColors.black,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                      customText(
                                                          text:
                                                              "Shared Affilations",
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
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  disconnectFriend(
                                                      content.userId!);
                                                  // if (content.joinStatus !=
                                                  //     "FRIEND_REQUEST_SENT") {
                                                  //   connectFriend(
                                                  //       content.userId!);
                                                  // } else {
                                                  //   disconnectFriend(
                                                  //       content.userId!);
                                                  // }
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: content.joinStatus ==
                                                            "CONNECTED"
                                                        ? AppColors.red
                                                        : AppColors.primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Center(
                                                    child: customText(
                                                      text: content
                                                                  .joinStatus ==
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
                                                      textColor:
                                                          AppColors.white,
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
                      userRequestLoading.value
                          ? usersHoriShimmerWithlength(
                              count: 6,
                            )
                          : Expanded(
                              child: SizedBox(
                                height: double.infinity,
                                width: double.infinity,
                                child: ListView.builder(
                                  itemCount: foundUsersRequest.value.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final content =
                                        foundUsersRequest.value[index];
                                    return Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 15, left: 15, right: 15),
                                      padding: PAD_ALL_5,
                                      color: AppColors.white,
                                      child: Column(
                                        children: [
                                          Row(
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
                                                            const BorderRadius
                                                                .only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  40),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  40),
                                                          topLeft:
                                                              Radius.circular(
                                                                  40),
                                                          topRight:
                                                              Radius.circular(
                                                                  0),
                                                        ),
                                                        color: Colors
                                                            .grey.shade300,
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${content['fromUserID']['data']['imgMain']['value'].toString()}"),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: customText(
                                                            text: content['fromUserID']
                                                                                ['data']
                                                                            [
                                                                            'imgMain']
                                                                        [
                                                                        'objectPublic'] ==
                                                                    false
                                                                ? content['fromUserID']
                                                                            [
                                                                            'firstName']!
                                                                        .isEmpty
                                                                    ? ""
                                                                    : "${content['fromUserID']['firstName'][0]}${content['fromUserID']['lastName'][0]}"
                                                                        .toUpperCase()
                                                                : "",
                                                            fontSize: 12,
                                                            textColor: AppColors
                                                                .deepPrimary,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    widthSpace(2),
                                                    SizedBox(
                                                      width: 40.w,
                                                      //color: Colors.amber,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          customText(
                                                              text:
                                                                  "${content['fromUserID']['firstName']} ${content['fromUserID']['lastName']}",
                                                              fontSize: 11,
                                                              textColor:
                                                                  AppColors
                                                                      .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                          customText(
                                                              text:
                                                                  "@${content['fromUserID']['username']} ",
                                                              fontSize: 11,
                                                              textColor: AppColors
                                                                  .searchTextGrey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: PAD_ALL_15,
                                                decoration: BoxDecoration(
                                                  color: AppColors.primary,
                                                  borderRadius:
                                                      BorderRadius.circular(45),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {
                                                        final result = await _exploreRepository
                                                            .acceptFriendRequest(
                                                                friendID: content[
                                                                        'fromUserID']
                                                                    ['userId']);
                                                        if (result['updated'] ==
                                                            true) {
                                                          ToastResp
                                                              .toastMsgSuccess(
                                                                  resp: result[
                                                                      'message']);

                                                          log(result
                                                              .toString());
                                                          refreshConnection();
                                                        } else {
                                                          log(result
                                                              .toString());
                                                          ToastResp.toastMsgError(
                                                              resp: result[
                                                                  'message']);
                                                        }
                                                      },
                                                      child: SvgPicture.asset(
                                                        AppImages.addOrganizer,
                                                        color: content['fromUserID']
                                                                    [
                                                                    'joinStatus'] ==
                                                                "FRIEND_REQUEST_RECIEVED"
                                                            ? AppColors.white
                                                            : AppColors.white,
                                                      ),
                                                    ),
                                                    widthSpace(2),
                                                    PopupMenuButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      position:
                                                          PopupMenuPosition
                                                              .under,
                                                      color: Colors.white,
                                                      child: Container(
                                                        child: const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2.0),
                                                            child: Icon(
                                                              Icons
                                                                  .more_vert_outlined,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                      ),
                                                      itemBuilder: (ctx) => [
                                                        buildPopupMenuItem2(
                                                          'Disconnect',
                                                          AppColors.black,
                                                          function: () async {
                                                            final result = await _exploreRepository
                                                                .rejectFriendRequest(
                                                                    friendID: content[
                                                                            'fromUserID']
                                                                        [
                                                                        'userId']);
                                                            if (result[
                                                                    'updated'] ==
                                                                true) {
                                                              ToastResp.toastMsgSuccess(
                                                                  resp: result[
                                                                      'message']);

                                                              log(result
                                                                  .toString());
                                                              refreshConnection();
                                                            } else {
                                                              log(result
                                                                  .toString());
                                                              ToastResp.toastMsgError(
                                                                  resp: result[
                                                                      'message']);
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          heightSpace(0.2),
                                          const Divider(
                                            thickness: 0.5,
                                            color: AppColors.iconGrey,
                                          )
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
              )
            ],
          ),
        ),
      )),
    );
  }
}

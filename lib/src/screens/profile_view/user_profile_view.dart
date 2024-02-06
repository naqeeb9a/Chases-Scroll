import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/models/community_model.dart';
import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/models/post_model.dart';
import 'package:chases_scroll/src/models/user_model.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/repositories/explore_repository.dart';
import 'package:chases_scroll/src/repositories/profile_repository.dart';
import 'package:chases_scroll/src/screens/community/model/group_model.dart';
import 'package:chases_scroll/src/screens/event_screens/widgets/event_small_card_title.dart';
import 'package:chases_scroll/src/screens/profile_view/widgets/icon_row_profile.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/helpers/change_millepoch.dart';
import 'package:chases_scroll/src/utils/constants/helpers/extract_first_letter.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class UserMainProfileView extends HookWidget {
  static final EventRepository _eventRepository = EventRepository();
  static final ProfileRepository _profileRepository = ProfileRepository();
  static final ExploreRepository _exploreRepository = ExploreRepository();
  const UserMainProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    PageController pageController = PageController(viewportFraction: 1);
    final currentPageValue = useValueNotifier(0);

    void animateTo(int page) {
      pageController.animateToPage(
        page, // convert int to double
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }

    //this is for events -----------------------------------------------
    final myEventLoading = useState<bool>(true);
    final myEventModel = useState<List<EventContent>>([]);
    final allEvents = useState<List<EventContent>>([]);
    final foundEvents = useState<List<EventContent>>([]);

    getMyEvents() {
      _eventRepository.getMyEvents().then((value) {
        myEventLoading.value = false;
        myEventModel.value = value;
        foundEvents.value = value;
        allEvents.value = value;
      });
    }

    //for events filtered list
    void _runEventFilter(String enteredKeyword) {
      log(enteredKeyword);
      if (enteredKeyword.isEmpty) {
        foundEvents.value = allEvents.value;
      } else {
        final found = allEvents.value
            .where((event) => event.eventName!
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();

        foundEvents.value = found;
      }
    }

    //-------------------This is for Users -----------------------------------//
    final usersLoading = useState<bool>(true);
    final usersModel = useState<List<ContentUser>>([]);
    final allUsers = useState<List<ContentUser>>([]);
    final foundUsers = useState<List<ContentUser>>([]);

    final userRequestLoading = useState<bool>(true);
    final userRequestModel = useState<List<dynamic>>([]);
    final allUsersRequest = useState<List<dynamic>>([]);
    final foundUsersRequest = useState<List<dynamic>>([]);

    getUsersConnectionRequests() {
      _profileRepository.getConnectionRequest("0").then((value) {
        userRequestLoading.value = false;
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
      userRequestLoading.value = false;
      getUsersConnection();
      getUsersConnectionRequests();
    }

    //for _runUsersFilter filtered list
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

    //-------------------This is for Community -----------------------------------//
    final communityLoading = useState<bool>(true);
    final communityModel = useState<List<CommContent>>([]);
    final allCommunity = useState<List<CommContent>>([]);
    final foundCommunity = useState<List<CommContent>>([]);

    getAllCommunities() {
      _profileRepository.getJoinedCommunity().then((value) {
        communityLoading.value = false;
        communityModel.value = value;
        allCommunity.value = value;
        foundCommunity.value = value;
      });
    }

    //for events filtered list
    void _runCommunityFilter(String enteredKeyword) {
      log(enteredKeyword);
      if (enteredKeyword.isEmpty) {
        foundCommunity.value = allCommunity.value;
      } else {
        final found = allCommunity.value
            .where((event) => event.data!.name!
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();

        foundCommunity.value = found;
      }
    }

    //getting user details
    final userProfileLoading = useState<bool>(true);
    final userProfileModel = useState<UserModel>(UserModel());

    void getUsersProfile() {
      _profileRepository.getUserProfile().then((value) {
        userProfileLoading.value = false;
        userProfileModel.value = value!;
      });
    }

    //get post
    final postLoading = useState<bool>(true);
    final postModel = useState<List<Content>>([]);
    void getUsersPost() {
      _profileRepository.getUserPosts(page: "0").then((value) {
        postLoading.value = false;
        postModel.value = value;
      });
    }

    useEffect(() {
      getUsersPost();
      getUsersConnection();
      getUsersConnectionRequests();
      getMyEvents();
      getAllCommunities();
      getUsersProfile();

      return null;
    }, []);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${userProfileModel.value.data?.imgMain?.value}",
                    ),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      right: 10,
                      child: PopupMenuButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        position: PopupMenuPosition.under,
                        color: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.primary,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                        itemBuilder: (ctx) => [
                          buildPopupMenuItem('Settings', AppColors.black,
                              function: () {
                            context.push(AppRoutes.settings);
                          }),
                          buildPopupMenuItem(
                            'Edit Profile',
                            AppColors.black,
                            function: () => context.push(AppRoutes.editProfile),
                          ),
                          buildPopupMenuItem(
                            'Cancel',
                            AppColors.red,
                            function: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ),
                    userProfileLoading.value
                        ? Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            bottom: 0,
                            child: Container(
                              height: height,
                              width: width,
                              color: Colors.transparent,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          )
                        : Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: height / 7,
                              width: double.infinity,
                              color: AppColors.black.withOpacity(0.6),
                              padding: PAD_ALL_13,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText(
                                    text:
                                        "${userProfileModel.value.firstName} ${userProfileModel.value.lastName}",
                                    fontSize: 18,
                                    textColor: AppColors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  // heightSpace(0.3),
                                  // customText(
                                  //   text:
                                  //       userProfileModel.value.data!.work!.value ?? "",
                                  //   fontSize: 12,
                                  //   textColor: AppColors.white,
                                  //   fontWeight: FontWeight.w500,
                                  // ),
                                  heightSpace(0.3),
                                  customText(
                                    text: "@${userProfileModel.value.username}",
                                    fontSize: 13,
                                    textColor: AppColors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  customText(
                                    text: userProfileModel
                                            .value.data!.about!.value ??
                                        "Bio - NONE",
                                    fontSize: 12,
                                    textColor: AppColors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  customText(
                                    text: userProfileModel.value.data!
                                                .webAddress!.value ==
                                            null
                                        ? "Website - NONE"
                                        : userProfileModel
                                            .value.data!.about!.value,
                                    fontSize: 12,
                                    textColor: AppColors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              animateTo(0);
                              //log(currentPageValue.value.toString());
                            },
                            child: ValueListenableBuilder<int>(
                              valueListenable: currentPageValue,
                              builder: (BuildContext context, int value,
                                  Widget? child) {
                                return Column(
                                  children: [
                                    customText(
                                      text:
                                          "${postModel.value.where((ticket) => ticket.type == "WITH_IMAGE").length}",
                                      fontSize: 12,
                                      textColor: value == 0
                                          ? AppColors.deepPrimary
                                          : AppColors.profileIconGrey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    heightSpace(0.5),
                                    SvgPicture.asset(
                                      AppImages.post,
                                      color: value == 0
                                          ? AppColors.deepPrimary
                                          : AppColors.profileIconGrey,
                                    ),
                                    heightSpace(0.5),
                                    customText(
                                      text: "Post",
                                      fontSize: 12,
                                      textColor: value == 0
                                          ? AppColors.deepPrimary
                                          : AppColors.profileIconGrey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    heightSpace(0.5),
                                    Container(
                                      height: 4,
                                      width: 70,
                                      color: value == 0
                                          ? AppColors.deepPrimary
                                          : AppColors.white,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              animateTo(1);
                              //log(currentPageValue.value.toString());
                            },
                            child: ValueListenableBuilder<int>(
                              valueListenable: currentPageValue,
                              builder: (BuildContext context, int value,
                                  Widget? child) {
                                return Column(
                                  children: [
                                    customText(
                                      text: "${foundUsers.value.length}",
                                      fontSize: 12,
                                      textColor: value == 1
                                          ? AppColors.deepPrimary
                                          : AppColors.profileIconGrey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    heightSpace(0.5),
                                    SvgPicture.asset(
                                      AppImages.network,
                                      color: value == 1
                                          ? AppColors.deepPrimary
                                          : AppColors.profileIconGrey,
                                    ),
                                    heightSpace(0.5),
                                    customText(
                                      text: "Network",
                                      fontSize: 12,
                                      textColor: value == 1
                                          ? AppColors.deepPrimary
                                          : AppColors.profileIconGrey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    heightSpace(0.5),
                                    Container(
                                      height: 4,
                                      width: 70,
                                      color: value == 1
                                          ? AppColors.deepPrimary
                                          : AppColors.white,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              animateTo(2);
                              //log(currentPageValue.value.toString());
                            },
                            child: ValueListenableBuilder<int>(
                              valueListenable: currentPageValue,
                              builder: (BuildContext context, int value,
                                  Widget? child) {
                                return Column(
                                  children: [
                                    customText(
                                      text: "${myEventModel.value.length}",
                                      fontSize: 12,
                                      textColor: value == 2
                                          ? AppColors.deepPrimary
                                          : AppColors.profileIconGrey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    heightSpace(0.5),
                                    SvgPicture.asset(
                                      AppImages.event,
                                      color: value == 2
                                          ? AppColors.deepPrimary
                                          : AppColors.profileIconGrey,
                                    ),
                                    heightSpace(0.5),
                                    customText(
                                      text: "Events",
                                      fontSize: 12,
                                      textColor: value == 2
                                          ? AppColors.deepPrimary
                                          : AppColors.profileIconGrey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    heightSpace(0.5),
                                    Container(
                                      height: 4,
                                      width: 70,
                                      color: value == 2
                                          ? AppColors.deepPrimary
                                          : AppColors.white,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              animateTo(3);
                              //log(currentPageValue.value.toString());
                            },
                            child: ValueListenableBuilder<int>(
                              valueListenable: currentPageValue,
                              builder: (BuildContext context, int value,
                                  Widget? child) {
                                return Column(
                                  children: [
                                    customText(
                                      text: "${foundCommunity.value.length}",
                                      fontSize: 12,
                                      textColor: value == 3
                                          ? AppColors.deepPrimary
                                          : AppColors.profileIconGrey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    heightSpace(0.5),
                                    SvgPicture.asset(
                                      AppImages.joinedCommunity,
                                      color: value == 3
                                          ? AppColors.deepPrimary
                                          : AppColors.profileIconGrey,
                                    ),
                                    heightSpace(0.5),
                                    customText(
                                      text: "Communities",
                                      fontSize: 12,
                                      textColor: value == 3
                                          ? AppColors.deepPrimary
                                          : AppColors.profileIconGrey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    heightSpace(0.5),
                                    Container(
                                      height: 4,
                                      width: 70,
                                      color: value == 3
                                          ? AppColors.deepPrimary
                                          : AppColors.white,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        controller: pageController,
                        onPageChanged: (index) {
                          currentPageValue.value = index;
                          log("currentPageValue.value-======> ${currentPageValue.value.toString()}");
                        },
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          GridView.builder(
                            itemCount: postModel.value
                                .where(
                                    (ticket) => ticket.type == "WITH_IMAGE")
                                .length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              Content contentPost = postModel.value[index];
                              //print(contentPost);
                              return GestureDetector(
                                onTap: () {
                                  context.push(AppRoutes.seeMoreUserPost,
                                      extra: userProfileModel.value.userId);
                                },
                                child: Card(
                                  color: Colors.grey.shade200,
                                  shadowColor: Colors.transparent,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(13.0),
                                      bottomRight: Radius.circular(13.0),
                                      bottomLeft: Radius.circular(13.0),
                                      topRight: Radius.circular(0.0),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(13.0),
                                      bottomRight: Radius.circular(13.0),
                                      bottomLeft: Radius.circular(13.0),
                                      topRight: Radius.circular(0.0),
                                    ),
                                    child: contentPost.mediaRef == null
                                        ? const SizedBox(
                                            child: ColoredBox(
                                                color: Colors.transparent),
                                          )
                                        : CachedNetworkImage(
                                            imageUrl:
                                                "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${contentPost.mediaRef.toString()}",
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              );
                            },
                          ),
                          DefaultTabController(
                            length: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 0, left: 5, right: 5),
                                          child: AppTextFormField(
                                            //textEditingController: searchController,
                                            //label: "",
                                            hintText:
                                                "Search for users, event or...",
                                            onChanged: (value) {
                                              _runUsersFilter(value);
                                            },
                                          ),
                                        ),
                                      ),
                                      widthSpace(2),
                                      GestureDetector(
                                        onTap: () => context
                                            .push(AppRoutes.profileUsersMore),
                                        child: customText(
                                          text: "See all",
                                          fontSize: 14,
                                          textColor: AppColors.deepPrimary,
                                        ),
                                      ),
                                      widthSpace(2),
                                    ],
                                  ),
                                  heightSpace(1),
                                  Container(
                                    padding: PAD_ALL_5,
                                    margin: const EdgeInsets.fromLTRB(
                                        5, 0, 5, 10),
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TabBar(
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      indicator: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius:
                                            BorderRadius.circular(5),
                                      ),
                                      labelColor: Colors.white,
                                      unselectedLabelColor:
                                          AppColors.subtitleColors,
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
                                    child: TabBarView(
                                      children: [
                                        Container(
                                          //color: Colors.cyan,
                                          child:
                                              usersLoading.value ||
                                                      foundUsers.value.isEmpty
                                                  ? Center(
                                                      child: customText(
                                                        text:
                                                            "No Connections Available",
                                                        fontSize: 14,
                                                        textColor: AppColors
                                                            .deepPrimary,
                                                      ),
                                                    )
                                                  : SizedBox(
                                                      height: double.infinity,
                                                      width: double.infinity,
                                                      child: ListView.builder(
                                                        itemCount: foundUsers
                                                            .value.length,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          ContentUser?
                                                              content =
                                                              foundUsers
                                                                      .value[
                                                                  index];
                                                          return GestureDetector(
                                                            onTap: () =>
                                                                context.push(
                                                              AppRoutes
                                                                  .otherUsersProfile,
                                                              extra: content
                                                                  .userId,
                                                            ),
                                                            child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          15,
                                                                      left:
                                                                          15,
                                                                      right:
                                                                          15),
                                                              padding:
                                                                  PAD_ALL_5,
                                                              color: AppColors
                                                                  .white,
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Expanded(
                                                                        flex:
                                                                            2,
                                                                        child:
                                                                            Row(
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
                                                                                  image: NetworkImage(content.data!.imgMain!.value.toString()),
                                                                                ),
                                                                              ),
                                                                              child: Center(
                                                                                child: customText(
                                                                                    text: content.data!.imgMain!.value == null
                                                                                        ? content.firstName!.isEmpty
                                                                                            ? ""
                                                                                            : "${content.firstName![0]}${content.lastName![0]}".toUpperCase()
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
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  customText(text: "${content.firstName} ${content.lastName}", fontSize: 11, textColor: AppColors.black, fontWeight: FontWeight.w700),
                                                                                  customText(text: "Shared Affilations", fontSize: 11, textColor: AppColors.searchTextGrey, fontWeight: FontWeight.w400),
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
                                                                              final result = await _exploreRepository.disconnectWithFriend(friendID: content.userId);
                                                                              if (result['updated'] == true) {
                                                                                ToastResp.toastMsgSuccess(resp: result['message']);
                                                                                refreshConnection();
                                                                                log(result.toString());
                                                                              } else {
                                                                                log(content.userId.toString());
                                                                                log(result.toString());
                                                                                ToastResp.toastMsgError(resp: result['message']);
                                                                              }
                                                                            },
                                                                            child: Container(
                                                                              height: 40,
                                                                              width: 90,
                                                                              decoration: BoxDecoration(
                                                                                color: content.joinStatus == "CONNECTED" ? AppColors.red : AppColors.primary,
                                                                                borderRadius: BorderRadius.circular(10),
                                                                              ),
                                                                              child: Center(
                                                                                child: customText(
                                                                                  text: content.joinStatus == "CONNECTED"
                                                                                      ? "Disconnect"
                                                                                      : content.joinStatus == "NOT_CONNECTED"
                                                                                          ? "Connect"
                                                                                          : content.joinStatus == "FRIEND_REQUEST_SENT"
                                                                                              ? "Pending"
                                                                                              : "",
                                                                                  fontSize: 12,
                                                                                  textColor: AppColors.white,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  heightSpace(
                                                                      0.2),
                                                                  const Divider(
                                                                    thickness:
                                                                        0.5,
                                                                    color: AppColors
                                                                        .iconGrey,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                        ),
                                        Container(
                                          //color: Colors.indigo,
                                          child:
                                              userRequestLoading.value ||
                                                      foundUsersRequest
                                                          .value.isEmpty
                                                  ? Center(
                                                      child: customText(
                                                        text:
                                                            "No Connection Request Available",
                                                        fontSize: 14,
                                                        textColor: AppColors
                                                            .deepPrimary,
                                                      ),
                                                    )
                                                  : SizedBox(
                                                      height: double.infinity,
                                                      width: double.infinity,
                                                      child: ListView.builder(
                                                        itemCount:
                                                            foundUsersRequest
                                                                .value.length,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          final content =
                                                              foundUsersRequest
                                                                      .value[
                                                                  index];
                                                          return GestureDetector(
                                                            onTap: () => context.push(
                                                                AppRoutes
                                                                    .otherUsersProfile,
                                                                extra: content[
                                                                        'fromUserID']
                                                                    [
                                                                    'userId']),
                                                            child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 5,
                                                                      bottom:
                                                                          5,
                                                                      left: 5,
                                                                      right:
                                                                          5),
                                                              padding:
                                                                  PAD_ALL_5,
                                                              color: AppColors
                                                                  .white,
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Expanded(
                                                                        flex:
                                                                            2,
                                                                        child:
                                                                            Row(
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
                                                                                border: Border.all(width: 3.5, color: Colors.grey.shade400),
                                                                                color: Colors.grey.shade300,
                                                                                image: DecorationImage(
                                                                                  fit: BoxFit.cover,
                                                                                  image: NetworkImage("http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${content['fromUserID']['data']['imgMain']['value'].toString()}"),
                                                                                ),
                                                                              ),
                                                                              child: Center(
                                                                                child: customText(
                                                                                    text: content['fromUserID']['data']['imgMain']['value'] == null
                                                                                        ? content['fromUserID']['firstName']!.isEmpty
                                                                                            ? ""
                                                                                            : "${content['fromUserID']['firstName'][0]}${content['fromUserID']['lastName'][0]}".toUpperCase()
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
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  customText(text: "${content['fromUserID']['firstName']} ${content['fromUserID']['lastName']}", fontSize: 11, textColor: AppColors.black, fontWeight: FontWeight.w700),
                                                                                  customText(text: "@${content['fromUserID']['username']} ", fontSize: 11, textColor: AppColors.searchTextGrey, fontWeight: FontWeight.w400),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        padding:
                                                                            PAD_ALL_10,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              AppColors.primary,
                                                                          borderRadius:
                                                                              BorderRadius.circular(30),
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                final result = await _exploreRepository.acceptFriendRequest(friendID: content['fromUserID']['userId']);
                                                                                if (result['updated'] == true) {
                                                                                  ToastResp.toastMsgSuccess(resp: result['message']);

                                                                                  log(result.toString());
                                                                                  refreshConnection();
                                                                                } else {
                                                                                  log(result.toString());
                                                                                  ToastResp.toastMsgError(resp: result['message']);
                                                                                }
                                                                              },
                                                                              child: SvgPicture.asset(
                                                                                AppImages.addOrganizer,
                                                                                color: content['fromUserID']['joinStatus'] == "FRIEND_REQUEST_RECIEVED" ? AppColors.white : AppColors.white,
                                                                              ),
                                                                            ),
                                                                            widthSpace(2),
                                                                            PopupMenuButton(
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(15),
                                                                              ),
                                                                              position: PopupMenuPosition.under,
                                                                              color: Colors.white,
                                                                              child: Container(
                                                                                child: const Padding(
                                                                                    padding: EdgeInsets.all(2.0),
                                                                                    child: Icon(
                                                                                      Icons.more_vert_outlined,
                                                                                      color: Colors.white,
                                                                                    )),
                                                                              ),
                                                                              itemBuilder: (ctx) => [
                                                                                buildPopupMenuItem2(
                                                                                  'Disconnect',
                                                                                  AppColors.black,
                                                                                  function: () async {
                                                                                    final result = await _exploreRepository.rejectFriendRequest(friendID: content['fromUserID']['userId']);
                                                                                    if (result['updated'] == true) {
                                                                                      ToastResp.toastMsgSuccess(resp: result['message']);

                                                                                      log(result.toString());
                                                                                      refreshConnection();
                                                                                    } else {
                                                                                      log(result.toString());
                                                                                      ToastResp.toastMsgError(resp: result['message']);
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
                                                                  heightSpace(
                                                                      0.2),
                                                                  const Divider(
                                                                    thickness:
                                                                        0.5,
                                                                    color: AppColors
                                                                        .iconGrey,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: AppTextFormField(
                                        //textEditingController: searchController,
                                        //label: "",
                                        hintText: "Search for Events ...",
                                        onChanged: (value) {
                                          _runEventFilter(value);
                                        },
                                      ),
                                    ),
                                    widthSpace(4),
                                    GestureDetector(
                                      onTap: () => context
                                          .push(AppRoutes.profileEventMore),
                                      child: customText(
                                        text: "See all",
                                        fontSize: 14,
                                        textColor: AppColors.deepPrimary,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              foundEvents.value.isEmpty
                                  ? Expanded(
                                      child: SizedBox(
                                        height: 30.h,
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 5.h,
                                              backgroundColor: AppColors
                                                  .deepPrimary
                                                  .withOpacity(0.1),
                                              child: SvgPicture.asset(
                                                AppImages.calendarAdd,
                                                color: AppColors.deepPrimary,
                                                height: 5.h,
                                              ),
                                            ),
                                            heightSpace(2),
                                            customText(
                                              text:
                                                  "You have no created or attending event",
                                              fontSize: 12,
                                              textColor: AppColors.primary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: ListView.builder(
                                        itemCount: foundEvents.value.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (BuildContext context,
                                            int index) {
                                          EventContent myEvent =
                                              foundEvents.value[index];
                                          //for formatted time
                                          int startTimeInMillis =
                                              myEvent.startTime!;
                                          DateTime startTime = DateTimeUtils
                                              .convertMillisecondsToDateTime(
                                                  startTimeInMillis);
                                          String formattedDate =
                                              DateUtilss.formatDateTime(
                                                  startTime);
                                          String eventTypeString = myEvent
                                              .eventType!
                                              .replaceAll("_", " ");
                                          return Padding(
                                            padding:
                                                const EdgeInsets.fromLTRB(
                                                    10, 5, 10, 5),
                                            child: EventSmallTitleCard(
                                              eventName: myEvent.eventName,
                                              date: formattedDate,
                                              location:
                                                  myEvent.location!.address,
                                              image: myEvent.currentPicUrl,
                                              price: myEvent.minPrice,
                                              eventDetails: myEvent,
                                              category: eventTypeString,
                                              isOrganser: myEvent.isOrganizer,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: AppTextFormField(
                                        //textEditingController: searchController,
                                        //label: "",
                                        hintText: "Search for Community ...",
                                        onChanged: (value) {
                                          _runCommunityFilter(value);
                                        },
                                      ),
                                    ),
                                    widthSpace(4),
                                    GestureDetector(
                                      onTap: () => context.push(
                                          AppRoutes.profileCommmunityMore),
                                      child: customText(
                                        text: "See all",
                                        fontSize: 14,
                                        textColor: AppColors.deepPrimary,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              heightSpace(1.5),
                              Expanded(
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  width: double.infinity,
                                  child: ListView.builder(
                                    itemCount: foundCommunity.value.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      CommContent comm =
                                          foundCommunity.value[index];
                                      log("comunity ID ==> ${comm.joinStatus}");

                                      return GestureDetector(
                                        onTap: () {
                                          context.push(
                                            AppRoutes.communityInfo,
                                            extra: CommunityInfoModel(
                                              description:
                                                  comm.data!.description ??
                                                      "",
                                              groupId: comm.id,
                                              name: comm.data!.name ?? "",
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 10),
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 55,
                                                    width: 55,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 0,
                                                          child: Container(
                                                            width: 35,
                                                            height: 35,
                                                            decoration:
                                                                const BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      bottomLeft:
                                                                          Radius.circular(20),
                                                                      bottomRight:
                                                                          Radius.circular(20),
                                                                      topLeft:
                                                                          Radius.circular(20),
                                                                      topRight:
                                                                          Radius.circular(0),
                                                                    ),
                                                                    color: AppColors
                                                                        .deepPrimary),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 5,
                                                          child: Container(
                                                            width: 35,
                                                            height: 35,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 1),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        20),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0),
                                                              ),
                                                              color: AppColors
                                                                  .deepPrimary,
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 10,
                                                          child: Container(
                                                            width: 35,
                                                            height: 35,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 1),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        20),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        0),
                                                              ),
                                                              color: Colors
                                                                  .grey
                                                                  .shade200,
                                                              image:
                                                                  DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(
                                                                    "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${comm.data!.imgSrc}"),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child:
                                                                  customText(
                                                                text: comm.data!.imgSrc ==
                                                                            null ||
                                                                        comm
                                                                            .data!
                                                                            .imgSrc!
                                                                            .isEmpty
                                                                    ? extractFirstLetters(
                                                                        "${comm.data!.name}"
                                                                            .toUpperCase())
                                                                    : "",
                                                                fontSize: 10,
                                                                textColor:
                                                                    AppColors
                                                                        .deepPrimary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  widthSpace(1),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        customText(
                                                            text:
                                                                comm.data!.name ==
                                                                        null
                                                                    ? ""
                                                                    : comm
                                                                        .data!
                                                                        .name!,
                                                            fontSize: 14,
                                                            textColor:
                                                                AppColors
                                                                    .black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        customText(
                                                            text: comm.data!
                                                                .description
                                                                .toString(),
                                                            fontSize: 12,
                                                            textColor: AppColors
                                                                .searchTextGrey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                            lines: 3),
                                                        heightSpace(1),
                                                        Row(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                customText(
                                                                    text: comm
                                                                        .data!
                                                                        .memberCount
                                                                        .toString(),
                                                                    fontSize:
                                                                        10,
                                                                    textColor:
                                                                        AppColors
                                                                            .deepPrimary,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                widthSpace(1),
                                                                customText(
                                                                    text: comm.data!.memberCount ==
                                                                            1
                                                                        ? "Member"
                                                                        : "Members",
                                                                    fontSize:
                                                                        10,
                                                                    textColor:
                                                                        AppColors
                                                                            .searchTextGrey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ],
                                                            ),
                                                            widthSpace(10),
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color(
                                                                    0xffD0D4EB),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        3.0),
                                                                child: customText(
                                                                    text: comm.data!.isPublic ==
                                                                            true
                                                                        ? "Public"
                                                                        : "Private",
                                                                    fontSize:
                                                                        8,
                                                                    textColor:
                                                                        AppColors
                                                                            .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Divider(),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

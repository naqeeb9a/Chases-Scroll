import 'dart:developer';

import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/models/community_model.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/repositories/explore_repository.dart';
import 'package:chases_scroll/src/screens/expore_screens/widgets/search_event_widget.dart';
import 'package:chases_scroll/src/screens/expore_screens/widgets/search_people_info_widget.dart';
import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/screens/widgets/shimmer_.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/helpers/change_millepoch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../models/event_model.dart';
import '../../../utils/constants/spacer.dart';
import '../../widgets/custom_fonts.dart';
import '../../widgets/textform_field.dart';

class SearchExploreView extends HookWidget {
  static final ExploreRepository _exploreRepository = ExploreRepository();
  static final EventRepository _eventRepository = EventRepository();

  const SearchExploreView({super.key});
  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    PageController pageController = PageController(viewportFraction: 0.95);

    void animateTo(int page) {
      pageController.animateToPage(
        page, // convert int to double
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }

    //------------------------------------------------------------------------//
    //-------------------This is for Events -----------------------------------//
    final allEventLoading = useState<bool>(true);
    final allEventModel = useState<List<Content>>([]);
    //final currentPageValue = useState<double>(0);
    final allEvents = useState<List<Content>>([]);
    final foundEvents = useState<List<Content>>([]);
    final currentPageValue = useValueNotifier(0);

    getAllEvents() {
      _exploreRepository.getAllEvents().then((value) {
        allEventLoading.value = false;
        allEventModel.value = value;
        foundEvents.value = value;
        allEvents.value = value;
      });
    }

    //for event data changes
    void refreshEventData() {
      allEventLoading.value = false; // Set loading state back to true
      getAllEvents(); // Trigger the API call again
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

    //------------------------------------------------------------------------//
    //-------------------This is for Users -----------------------------------//
    final usersLoading = useState<bool>(true);
    final usersModel = useState<List<ContentUser>>([]);
    final allUsers = useState<List<ContentUser>>([]);
    final foundUsers = useState<List<ContentUser>>([]);

    getSuggestedUsers() {
      _exploreRepository.getSuggestedUsers().then((value) {
        usersLoading.value = false;
        usersModel.value = value;
        allUsers.value = value;
        foundUsers.value = value;
      });
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

    //------------------------------------------------------------------------//
    //----------------------This is for community-----------------------------//
    final communityLoading = useState<bool>(true);
    final communityModel = useState<List<CommContent>>([]);
    final allCommunity = useState<List<CommContent>>([]);
    final foundCommunity = useState<List<CommContent>>([]);

    getAllCommunities() {
      _exploreRepository.getAllCommunity().then((value) {
        communityLoading.value = false;
        communityModel.value = value;
        allCommunity.value = value;
        foundCommunity.value = value;
      });
    }

    void refreshCommunity() {
      communityLoading.value = false; // Set loading state back to true
      getAllCommunities(); // Trigger the API call again
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

    String userId =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);

    //join community
    joinCommunity(CommContent comm) async {
      final result = await _eventRepository.joinCommunity(groupID: comm.id);
      log(comm.joinStatus.toString());
      if (result['updated'] == true) {
        ToastResp.toastMsgSuccess(resp: result['message']);
        refreshCommunity();
      } else {
        ToastResp.toastMsgError(resp: result['message']);
      }
    }

    //leave group
    leaveCommunity(CommContent comm) async {
      final result = await _eventRepository.leaveCommunity(groupID: comm.id);
      log(comm.joinStatus.toString());
      if (result['updated'] == true) {
        ToastResp.toastMsgSuccess(resp: result['message']);
        refreshCommunity();
      } else {
        ToastResp.toastMsgError(resp: result['message']);
      }
    }

    useEffect(() {
      getAllEvents();
      getSuggestedUsers();
      getAllCommunities();
      return null;
    }, []);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: appBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 0, left: 15, right: 15),
              child: AppTextFormField(
                //textEditingController: searchController,
                //label: "",
                hintText: "Search for users, event or...",
                onChanged: (value) {
                  //_runUsersFilter(value);
                  if (currentPageValue.value == 0) {
                    _runUsersFilter(value);
                  } else if (currentPageValue.value == 1) {
                    _runEventFilter(value);
                  } else {
                    _runCommunityFilter(value);
                  }
                },
              ),
            ),
            heightSpace(1),
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
                      builder:
                          (BuildContext context, int value, Widget? child) {
                        return customText(
                          text: "People",
                          fontSize: 14,
                          textColor: value == 0
                              ? AppColors.deepPrimary
                              : AppColors.searchTextGrey,
                          fontWeight: FontWeight.w700,
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
                      builder:
                          (BuildContext context, int value, Widget? child) {
                        return customText(
                          text: "Events",
                          fontSize: 14,
                          textColor: value == 1
                              ? AppColors.deepPrimary
                              : AppColors.searchTextGrey,
                          fontWeight: FontWeight.w700,
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
                      builder:
                          (BuildContext context, int value, Widget? child) {
                        return customText(
                          text: "Communities",
                          fontSize: 14,
                          textColor: value == 2
                              ? AppColors.deepPrimary
                              : AppColors.searchTextGrey,
                          fontWeight: FontWeight.w700,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            heightSpace(1),
            Expanded(
              child: SizedBox(
                //color: Colors.amber,
                width: double.infinity,
                child: Container(
                  margin: EdgeInsets.zero, // Set margin to zero
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: pageController,
                    onPageChanged: (index) {
                      currentPageValue.value = index;
                      log("currentPageValue.value-======> ${currentPageValue.value.toString()}");
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      //----------first page view ------------------
                      Expanded(
                        child: Column(
                          children: [
                            usersLoading.value
                                ? searchUsersShimmerWithlength(
                                    count: 6,
                                  )
                                : Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          15, 0, 15, 0),
                                      width: double.infinity,
                                      child: ListView.builder(
                                        itemCount: foundUsers.value.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          ContentUser user =
                                              foundUsers.value[index];
                                          return SearchPeopleWidget(
                                            user: user,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),

                      //----------second page view ------------------
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: foundEvents.value.length,
                          itemBuilder: (BuildContext context, int index) {
                            Content event = foundEvents.value[index];

                            //for formatted time
                            int startTimeInMillis = event.startTime!;
                            DateTime startTime =
                                DateTimeUtils.convertMillisecondsToDateTime(
                                    startTimeInMillis);
                            String formattedDate =
                                DateUtilss.formatDateTime(startTime);
                            return SearchEventWidget(
                              eventName: event.eventName,
                              date: formattedDate,
                              location: event.location!.address,
                              image: event.currentPicUrl,
                              price: event.minPrice,
                              isSaved: event.isSaved!,
                              onSave: () async {
                                final result = await _eventRepository.saveEvent(
                                  eventID: event.id,
                                  userID: userId,
                                );
                                log(userId);
                                if (result['message'] == true) {
                                  // Trigger a refresh of the events data
                                  refreshEventData();
                                  ToastResp.toastMsgSuccess(
                                      resp: result['message']);
                                } else {
                                  ToastResp.toastMsgError(
                                      resp: result['message']);
                                }
                              },
                            );
                          },
                        ),
                      ),

                      //----------Community page view ------------------
                      Container(
                        margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: foundCommunity.value.length,
                          itemBuilder: (BuildContext context, int index) {
                            CommContent comm = foundCommunity.value[index];
                            log("comunity ID ==> ${comm.joinStatus}");
                            // String n = comm.data!.name.toString();
                            // List<String> words = n.split(' ');
                            // String initials =
                            //     words.map((word) => word[0]).join('');
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(20),
                                                      bottomRight:
                                                          Radius.circular(20),
                                                      topLeft:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(0),
                                                    ),
                                                    color:
                                                        AppColors.deepPrimary),
                                              ),
                                            ),
                                            Positioned(
                                              left: 5,
                                              child: Container(
                                                width: 35,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 1),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20),
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(0),
                                                  ),
                                                  color: AppColors.deepPrimary,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 10,
                                              child: Container(
                                                width: 35,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 1),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20),
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(0),
                                                  ),
                                                  color: Colors.grey.shade200,
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${comm.data!.imgSrc}"),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: customText(
                                                      text: comm.data!.imgSrc!
                                                              .isEmpty
                                                          ? comm.data!.name ==
                                                                  null
                                                              ? ""
                                                              : "initials"
                                                          : "",
                                                      fontSize: 10,
                                                      textColor:
                                                          AppColors.deepPrimary,
                                                      fontWeight:
                                                          FontWeight.w500),
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
                                              CrossAxisAlignment.start,
                                          children: [
                                            customText(
                                                text: comm.data!.name == null
                                                    ? ""
                                                    : comm.data!.name!,
                                                fontSize: 14,
                                                textColor: AppColors.black,
                                                fontWeight: FontWeight.w500),
                                            customText(
                                                text: comm.data!.description
                                                    .toString(),
                                                fontSize: 12,
                                                textColor:
                                                    AppColors.searchTextGrey,
                                                fontWeight: FontWeight.w500,
                                                lines: 3),
                                            heightSpace(1),
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    customText(
                                                        text: comm
                                                            .data!.memberCount
                                                            .toString(),
                                                        fontSize: 10,
                                                        textColor: AppColors
                                                            .deepPrimary,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    widthSpace(1),
                                                    customText(
                                                        text: comm.data!
                                                                    .memberCount ==
                                                                1
                                                            ? "Member"
                                                            : "Members",
                                                        fontSize: 10,
                                                        textColor: AppColors
                                                            .searchTextGrey,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ],
                                                ),
                                                widthSpace(10),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffD0D4EB),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: customText(
                                                        text: comm.data!
                                                                    .isPublic ==
                                                                true
                                                            ? "Public"
                                                            : "Private",
                                                        fontSize: 8,
                                                        textColor:
                                                            AppColors.red,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      widthSpace(5),
                                      GestureDetector(
                                        onTap: () async {
                                          log("comunity ID ==> ${comm.joinStatus}");
                                          comm.joinStatus == "NOT_CONNECTED"
                                              ? joinCommunity(comm)
                                              : leaveCommunity(comm);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  comm.joinStatus == "CONNECTED"
                                                      ? AppColors.green
                                                      : AppColors.primary,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          padding: const EdgeInsets.all(10),
                                          child: customText(
                                              text: comm.joinStatus ==
                                                      "CONNECTED"
                                                  ? "Joined"
                                                  : comm.joinStatus ==
                                                          "NOT_CONNECTED"
                                                      ? "Join"
                                                      : comm.joinStatus ==
                                                              "FRIEND_REQUEST_SENT"
                                                          ? "Pending"
                                                          : "",
                                              fontSize: 10,
                                              textColor: AppColors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

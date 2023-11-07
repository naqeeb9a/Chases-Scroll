import 'dart:developer';

import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/repositories/explore_repository.dart';
import 'package:chases_scroll/src/screens/expore_screens/widgets/event_container_tranform_view.dart';
import 'package:chases_scroll/src/screens/expore_screens/widgets/suggestions_view.dart';
import 'package:chases_scroll/src/screens/widgets/shimmer_.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../utils/constants/spacer.dart';
import '../widgets/custom_fonts.dart';

class ExploreMainView extends HookWidget {
  static final ExploreRepository _exploreRepository = ExploreRepository();

  const ExploreMainView({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(viewportFraction: 0.95);

    double currentPageValue0 = 0.0;
    const double scaleFactor = 0.8;

    final eventLoading = useState<bool>(true);
    final eventModel = useState<List<EventContent>>([]);
    final currentPageValue = useState<double>(currentPageValue0);

    getEvents() {
      _exploreRepository.getTopEvents().then((value) {
        eventLoading.value = false;
        eventModel.value = value;
      });
    }

    //------------------------------------------------------------------------//
    //------------------------------------------------------------------------//
    final usersLoading = useState<bool>(true);
    final usersModel = useState<List<ContentUser>>([]);

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
      getEvents();
      getSuggestedUsers();
      return null;
    }, []);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                  text: "Hello David",
                  fontSize: 20,
                  textColor: AppColors.black,
                  fontWeight: FontWeight.w700),
              heightSpace(1),
              GestureDetector(
                onTap: () => context.push(AppRoutes.searchExploreView),
                child: Container(
                  padding: PAD_ALL_13,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.1,
                      color: AppColors.primary,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/search-chase.svg',
                        height: 15,
                      ),
                      widthSpace(2),
                      customText(
                        text: "Search for users, event or...",
                        fontSize: 12,
                        textColor: AppColors.searchTextGrey,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
              heightSpace(2),
              customText(
                  text: "Top Events",
                  fontSize: 14,
                  textColor: AppColors.primary,
                  fontWeight: FontWeight.w700),
              heightSpace(2),
              Expanded(
                flex: 3,
                child: Container(
                  // color: Colors.indigo,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          //color: Colors.amber,
                          child: Column(
                            children: [
                              eventLoading.value
                                  ? topEventShimmerWithlength(
                                      count: 1,
                                      width: 90.w,
                                      height: 30.h,
                                    )
                                  : Expanded(
                                      child: Container(
                                        child: PageView.builder(
                                          controller: pageController,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: eventModel.value.length,
                                          onPageChanged: (int pageIndex) {
                                            currentPageValue.value =
                                                pageIndex.toDouble();
                                          },
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            EventContent event =
                                                eventModel.value[index];
                                            return EventContainerTransformView(
                                              index: index,
                                              currentPageValue:
                                                  currentPageValue.value,
                                              scaleFactor: scaleFactor,
                                              event: event,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        //color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            eventModel.value.length,
                            (index) => buildDot(
                                index, context, currentPageValue.value),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(
                      text: "People you may know",
                      fontSize: 14,
                      textColor: AppColors.black,
                      fontWeight: FontWeight.w700),
                  GestureDetector(
                    onTap: () => context.push(AppRoutes.suggestionFriendMore),
                    child: customText(
                        text: "See All",
                        fontSize: 12,
                        textColor: AppColors.deepPrimary,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    children: [
                      usersLoading.value
                          ? usersShimmerWithlength(
                              count: 2,
                            )
                          : Expanded(
                              child: SizedBox(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: usersModel.value.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    ContentUser? friend =
                                        usersModel.value[index];

                                    return usersLoading.value
                                        ? const Center(
                                            child: Icon(
                                              Icons.error,
                                              size: 60,
                                              color: Colors.red,
                                            ),
                                          )
                                        : SuggestionView(
                                            users: usersModel.value[index],
                                            function: () async {
                                              log(friend.userId!);
                                              if (friend.joinStatus !=
                                                  "FRIEND_REQUEST_SENT") {
                                                connectFriend(friend.userId!);
                                              } else {
                                                disconnectFriend(
                                                    friend.userId!);
                                              }
                                            },
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
      ),
    );
  }

  Container buildDot(int index, BuildContext context, double pa) {
    return Container(
      height: pa == index ? 13 : 7,
      width: pa == index ? 13 : 7,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: pa == index ? AppColors.deepPrimary : AppColors.lightGrey,
      ),
    );
  }
}

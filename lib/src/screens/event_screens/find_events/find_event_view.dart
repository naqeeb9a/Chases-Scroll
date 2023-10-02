import 'package:chases_scroll/src/screens/event_screens/find_events/college_event_view.dart';
import 'package:chases_scroll/src/screens/event_screens/find_events/community_event_view.dart';
import 'package:chases_scroll/src/screens/event_screens/find_events/corporate_event_view.dart';
import 'package:chases_scroll/src/screens/event_screens/find_events/festival_event_view.dart';
import 'package:chases_scroll/src/screens/event_screens/find_events/find_all_event.dart';
import 'package:chases_scroll/src/screens/event_screens/find_events/fundraising_event_view.dart';
import 'package:chases_scroll/src/screens/event_screens/find_events/pop_event_view.dart';
import 'package:chases_scroll/src/screens/event_screens/find_events/religious_event_view.dart';
import 'package:chases_scroll/src/screens/event_screens/find_events/social_event_view.dart';
import 'package:chases_scroll/src/screens/event_screens/find_events/trending_event.dart';
import 'package:chases_scroll/src/screens/event_screens/find_events/virtual_event_view.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/row_texts_widget.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/spacer.dart';

class FindEventsScreenView extends HookWidget {
  const FindEventsScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> listEventType = [
      "All",
      "Corporate Event",
      "Social Events",
      "College Events",
      "Virtual Events",
      "Religious Event",
      "Pop-up Event",
      "Fundraising Event",
      "Festival",
      "Community Event",
    ];

    final currentPageIndex = useState<int>(0);
    PageController pageController = PageController(viewportFraction: 1);

    return Container(
      child: Column(
        children: [
          GestureDetector(
            //onTap: () => context.push(AppRoutes.searchExploreView),
            child: Container(
              padding: PAD_ALL_13,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
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
                    text: "Search for Events",
                    fontSize: 12,
                    textColor: AppColors.searchTextGrey,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ),
          heightSpace(1),
          const RowTextGestureView(
            leftText: "Event Category",
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: SizedBox(
              height: 45,
              //color: Colors.redAccent,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listEventType.length,
                itemBuilder: (context, index) {
                  //print(popularProducts.popularProductList.length.toString());
                  return GestureDetector(
                    onTap: () {
                      pageController.animateToPage(
                        index, // convert int to double
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: index == currentPageIndex.value
                            ? Colors.black87
                            : const Color(0xff989292).withOpacity(0.15),
                      ),
                      child: Padding(
                        padding: PAD_ALL_10,
                        child: Center(
                          child: customText(
                            text: listEventType[index],
                            fontSize: 12,
                            textColor: index == currentPageIndex.value
                                ? Colors.white
                                : Colors.black87,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: PageView(
                controller: pageController,
                children: [
                  FindAllEventCardView(),
                  FindTrendingEvents(),
                  FindCorporateEventView(),
                  FindSocialEventsView(),
                  FindCollegeEvents(),
                  FindVirtualEvents(),
                  FindReligiousEvents(),
                  FindPopupEventView(),
                  FindFundraisingEventView(),
                  FindFestivalEventView(),
                  FindCommunityEventView(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

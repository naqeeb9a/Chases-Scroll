import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/screens/expore_screens/widgets/event_container_tranform_view.dart';
import 'package:chases_scroll/src/screens/expore_screens/widgets/search_community_widget.dart';
import 'package:chases_scroll/src/screens/expore_screens/widgets/search_event_widget.dart';
import 'package:chases_scroll/src/screens/expore_screens/widgets/search_people_info_widget.dart';
import 'package:chases_scroll/src/screens/expore_screens/widgets/suggestions_view.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/constants/spacer.dart';
import '../../widgets/custom_fonts.dart';
import '../../widgets/textform_field.dart';

class SearchExploreView extends StatefulWidget {
  const SearchExploreView({super.key});

  @override
  State<SearchExploreView> createState() => _SearchExploreViewState();
}

class _SearchExploreViewState extends State<SearchExploreView>
    with TickerProviderStateMixin {
  final searchController = TextEditingController();

  PageController pageController = PageController(viewportFraction: 0.95);
  int currentIndex = 0;
  PageController? _controller;

  double _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  double height = 200;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  void animateTo(int page) {
    pageController.animateToPage(
      page, // convert int to double
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 0, left: 15, right: 15),
              child: AppTextFormField(
                textEditingController: searchController,
                //label: "",
                hintText: "Search for users, event or...",
              ),
            ),
            heightSpace(1),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => animateTo(0),
                    child: customText(
                        text: "People",
                        fontSize: 14,
                        textColor: AppColors.primary,
                        fontWeight: FontWeight.w700),
                  ),
                  GestureDetector(
                    onTap: () => animateTo(1),
                    child: customText(
                        text: "Events",
                        fontSize: 14,
                        textColor: AppColors.primary,
                        fontWeight: FontWeight.w700),
                  ),
                  GestureDetector(
                    onTap: () => animateTo(2),
                    child: customText(
                        text: "Communities",
                        fontSize: 14,
                        textColor: AppColors.primary,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            heightSpace(1),
            Expanded(
              child: Container(
                //color: Colors.amber,
                width: double.infinity,
                child: Container(
                  margin: EdgeInsets.zero, // Set margin to zero
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      //----------first page view ------------------
                      // ... Your code for the first page view ...
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return SearchPeopleWidget(
                              fullName: "BOB Wheeler",
                              username: "@bobwheeler",
                            );
                          },
                        ),
                      ),

                      //----------second page view ------------------
                      // ... Your code for the second page view ...
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return SearchEventWidget();
                          },
                        ),
                      ),

                      //----------third page view ------------------
                      // ... Your code for the third page view ...
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return SearchCommunityWidget();
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

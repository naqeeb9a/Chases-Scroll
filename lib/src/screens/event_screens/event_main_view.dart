import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/screens/event_screens/find_events/find_event_view.dart';
import 'package:chases_scroll/src/screens/event_screens/my_events/my_event_view.dart';
import 'package:chases_scroll/src/screens/event_screens/past_events/past_events_view.dart';
import 'package:chases_scroll/src/screens/event_screens/saved_events/saved_events_view.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../utils/constants/images.dart';

class EventMainView extends HookWidget {
  const EventMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> pageTitles = [
      'Find Event',
      'My Event',
      'Saved Event',
      'Past Event',
    ];

    final currentPage = useState<int>(0);
    final currentPageIndex = useState<int>(0);
    PageController pageController = PageController(viewportFraction: 1);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton(
                    items: pageTitles.map((title) {
                      return DropdownMenuItem(
                        value: pageTitles.indexOf(title),
                        child: customText(
                          text: title,
                          fontSize: 14,
                          textColor: AppColors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    }).toList(),
                    value: currentPage.value,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(0),
                    ),
                    underline: Container(
                      height: 0,
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 20,
                      color: Colors.black87,
                    ),
                    onChanged: (value) {
                      currentPage.value = value!;
                      pageController.animateToPage(
                        currentPage.value, // convert int to double
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () => context.push(AppRoutes.addEventView),
                    child: SvgPicture.asset(
                      AppImages.addEvents,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ],
              ),
            ),
            heightSpace(1),
            Expanded(
              child: PageView(
                onPageChanged: (index) {
                  currentPage.value = index;
                },
                controller: pageController,
                //physics: const NeverScrollableScrollPhysics(),
                children: [
                  const FindEventsScreenView(),
                  MyEventView(),
                  SavedEventsView(),
                  PastEventView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WideEventCards extends StatelessWidget {
  final String? image;

  final String? name;
  final double? price;
  final String? location;
  final int? users;
  const WideEventCards({
    super.key,
    this.image,
    this.name,
    this.price,
    this.location,
    this.users,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PAD_ALL_10,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      decoration: BoxDecoration(
        border: Border.all(width: 0.2, color: Colors.grey.shade200),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
          topLeft: Radius.circular(35),
          topRight: Radius.circular(0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6.0,
            spreadRadius: 0.2,
            offset: const Offset(0.7, 0.7),
          )
        ],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20.h,
            width: 100.w,
            decoration: BoxDecoration(
              border: Border.all(width: 0.3, color: Colors.grey.shade300),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
                topLeft: Radius.circular(40),
                topRight: Radius.circular(0),
              ),
              color: Colors.grey.shade200,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/$image"),
              ),
            ),
          ),
          heightSpace(0.7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  //color: Colors.cyan,
                  child: customText(
                      text: name!,
                      fontSize: 14,
                      textColor: AppColors.black,
                      fontWeight: FontWeight.w700,
                      lines: 1),
                ),
              ),
              widthSpace(1.5),
              customText(
                text: price.toString(),
                fontSize: 14,
                textColor: AppColors.deepPrimary,
                fontWeight: FontWeight.w500,
              ),
              // Text(
              //   event['currency'] == "USD"
              //       ? "\$${event['minPrice'].toString()}"
              //       : "₦${event['minPrice'].toString()}",
              //   style: GoogleFonts.montserrat(
              //     color: Colors.black,
              //     fontSize: 14,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
            ],
          ),
          heightSpace(1),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.place_rounded,
                size: 15,
                color: Colors.grey.shade400,
              ),
              widthSpace(1),
              Flexible(
                child: customText(
                  text: location!,
                  fontSize: 12,
                  textColor: AppColors.searchTextGrey,
                  fontWeight: FontWeight.w400,
                  lines: 1,
                ),
              ),
            ],
          ),
          heightSpace(1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                    width: 100,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            width: 6.w,
                            height: 3.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          child: Container(
                            width: 6.w,
                            height: 3.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 40,
                          child: Container(
                            width: 6.w,
                            height: 3.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 60,
                          child: Container(
                            width: 6.w,
                            height: 3.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppColors.deepPrimary,
                            ),
                            child: Center(
                              child: customText(
                                text: "+${users!}",
                                fontSize: 5,
                                textColor: AppColors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: customText(
                      text: "Interested",
                      fontSize: 12,
                      textColor: AppColors.deepPrimary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  //onTap: widget.onSave,
                  child: Container(
                    child: SvgPicture.asset(
                      AppImages.bookmark,
                      height: 2.4.h,
                      width: 2.4.w,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'dart:developer';

import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/models/user_model.dart';
import 'package:chases_scroll/src/repositories/profile_repository.dart';
import 'package:chases_scroll/src/screens/event_screens/draft_event_views/draft_event_views.dart';
import 'package:chases_scroll/src/screens/event_screens/find_events/find_event_view.dart';
import 'package:chases_scroll/src/screens/event_screens/my_events/my_event_view.dart';
import 'package:chases_scroll/src/screens/event_screens/past_events/past_events_view.dart';
import 'package:chases_scroll/src/screens/event_screens/saved_events/saved_events_view.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
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
  static final ProfileRepository _profileRepository = ProfileRepository();

  const EventMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> pageTitles = [
      'Find Event',
      'My Event',
      'Saved Event',
      'Past Event',
      'Draft',
    ];

    final currentPage = useState<int>(0);
    final currentPageIndex = useState<int>(0);
    PageController pageController = PageController(viewportFraction: 1);

    String userId =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);

    log("see result here o ===>$userId");

    //getting user details
    final userProfileLoading = useState<bool>(true);
    final userProfileModel = useState<UserModel>(UserModel());

    void getUsersProfile() {
      _profileRepository.getUserProfile().then((value) {
        userProfileLoading.value = false;
        userProfileModel.value = value!;
      });
    }

    useEffect(() {
      getUsersProfile();

      return null;
    }, []);
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
                      child: Container(
                        padding: PAD_ALL_8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: AppColors.deepPrimary, width: 1.3),
                          color: AppColors.white,
                        ),
                        child: customText(
                          text: "Create Event",
                          fontSize: 12,
                          textColor: AppColors.deepPrimary,
                        ),
                      )),
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
                  MyDraftEventView()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WideEventCards extends StatefulWidget {
  final String? image;
  final EventContent? eventDetails;
  final String? name;
  final double? price;
  final String? location;
  final int? users;
  final bool isSaved;
  final Function()? onSave;

  const WideEventCards({
    super.key,
    this.image,
    this.name,
    this.price,
    this.location,
    this.users,
    required this.isSaved,
    this.onSave,
    this.eventDetails,
  });

  @override
  State<WideEventCards> createState() => _WideEventCardsState();
}

class _WideEventCardsState extends State<WideEventCards> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.eventDetailMainView, extra: widget.eventDetails);
      },
      child: Container(
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
                      "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${widget.image}"),
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
                        text: widget.name!,
                        fontSize: 14,
                        textColor: AppColors.black,
                        fontWeight: FontWeight.w700,
                        lines: 1),
                  ),
                ),
                widthSpace(1.5),
                customText(
                  text: widget.price.toString(),
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
                    text: widget.location.toString(),
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
                    Expanded(
                      flex: widget.eventDetails!.interestedUsers!.length < 2
                          ? 1
                          : widget.eventDetails!.interestedUsers!.length < 2
                              ? 2
                              : 3,
                      child: SizedBox(
                        // color: Colors.amber,
                        height: 35,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              widget.eventDetails!.interestedUsers!.length < 3
                                  ? widget.eventDetails!.interestedUsers!.length
                                  : 3, // Replace with your actual item count
                          itemBuilder: (context, index) {
                            InterestedUsers indiv =
                                widget.eventDetails!.interestedUsers![index];
                            // Replace this with your actual list item widget
                            return Container(
                              width: 8.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.primary.withOpacity(0.5),
                                image: DecorationImage(
                                  scale: 1.0,
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${indiv.data!.imgMain!.value}"),
                                ),
                              ),
                              child: Visibility(
                                  child: Center(
                                child: Text(
                                    "${indiv.firstName![0]}${indiv.lastName![0]}"
                                        .toUpperCase()),
                              )),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        child: customText(
                          text: "Interested",
                          fontSize: 12,
                          textColor: AppColors.deepPrimary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: widget.onSave,
                    child: Container(
                      child: widget.isSaved == true
                          ? SvgPicture.asset(
                              AppImages.bookmarkFilled,
                              height: 2.4.h,
                              width: 2.4.w,
                            )
                          : SvgPicture.asset(
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
      ),
    );
  }
}

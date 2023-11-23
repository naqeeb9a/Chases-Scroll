import 'dart:developer';

import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/helpers/strings.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/constants/colors.dart';

class FindAllEventsView extends HookWidget {
  static final EventRepository _eventRepository = EventRepository();
  final bool isSaved = false;

  const FindAllEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    final allEventlLoading = useState<bool>(true);
    final allEventModel = useState<List<EventContent>>([]);
    final allEvents = useState<List<EventContent>>([]);
    final foundEvents = useState<List<EventContent>>([]);

    getAllMyEvents() {
      _eventRepository.getAllEvents().then((value) {
        allEventlLoading.value = false;
        allEventModel.value = value;
        foundEvents.value = value;
        allEvents.value = value;
      });
    }

    //for events filtered list
    // void _runEventFilter(String enteredKeyword) {
    //   log(enteredKeyword);
    //   if (enteredKeyword.isEmpty) {
    //     foundEvents.value = allEvents.value;
    //   } else {
    //     final found = allEvents.value
    //         .where((event) => event.eventName!
    //             .toLowerCase()
    //             .contains(enteredKeyword.toLowerCase()))
    //         .toList();

    //     foundEvents.value = found;
    //   }
    // }

    void _runEventFilter(String enteredKeyword) {
      print("Entered Keyword: $enteredKeyword");

      if (enteredKeyword.isEmpty) {
        foundEvents.value = allEvents.value;
      } else {
        final found = allEvents.value.where((event) {
          final eventNameMatch = event.eventName
                  ?.toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ??
              false;
          final addressMatch = event.location?.address
                  ?.toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ??
              false;
          final eventTypeMatch = event.eventType
                  ?.toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ??
              false;

          // Log statements for debugging
          print(
              "Event Name: ${event.eventName}, Location: ${event.location?.address}, Type: ${event.eventType}");
          print(
              "Keyword Match: Name: $eventNameMatch, Address: $addressMatch, Type: $eventTypeMatch");

          return eventNameMatch || addressMatch || eventTypeMatch;
        }).toList();

        foundEvents.value = List.from(found);
      }
    }

    //for event data changes
    void refreshEventData() {
      allEventlLoading.value = false; // Set loading state back to true
      getAllMyEvents(); // Trigger the API call again
    }

    //value for userID
    String userId =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);

    saveEvent(String eventId) async {
      final result = await _eventRepository.saveEvent(
        eventID: eventId,
        userID: userId,
      );
      log(userId);
      if (result['message'] == true) {
        // Trigger a refresh of the events data
        refreshEventData();
        ToastResp.toastMsgSuccess(resp: result['message']);
      } else {
        ToastResp.toastMsgError(resp: result['message']);
      }
    }

    unSaveEvent(String eventId) async {
      final result = await _eventRepository.unSaveEvent(
        eventID: eventId,
        userID: userId,
      );
      log(userId);
      if (result['message'] == true) {
        // Trigger a refresh of the events data
        refreshEventData();
        ToastResp.toastMsgSuccess(resp: result['message']);
      } else {
        ToastResp.toastMsgError(resp: result['message']);
      }
    }

    useEffect(() {
      getAllMyEvents();
      return null;
    }, []);
    return Scaffold(
      appBar: appBar(title: "All Event"),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: PAD_ALL_10,
          child: Column(
            children: [
              AppTextFormField(
                prefixIcon: SvgPicture.asset(
                  AppImages.searchIcon,
                  height: 20,
                  width: 20,
                  color: AppColors.deepPrimary,
                ),
                hintText: "Search for users, event or...",
                onChanged: (value) {
                  _runEventFilter(value);
                },
              ),
              allEventModel.value.isEmpty
                  ? SizedBox(
                      height: 50.h,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 10.h,
                            backgroundColor:
                                AppColors.deepPrimary.withOpacity(0.1),
                            child: SvgPicture.asset(
                              AppImages.calendarAdd,
                              color: AppColors.deepPrimary,
                              height: 10.h,
                            ),
                          ),
                          heightSpace(2),
                          customText(
                            text: "No event available",
                            fontSize: 12,
                            textColor: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: foundEvents.value.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          EventContent event = foundEvents.value[index];

                          //return const Text("data");

                          return GestureDetector(
                            onTap: () {
                              context.push(AppRoutes.eventDetailMainView,
                                  extra: event);
                            },
                            child: Container(
                              padding: PAD_ALL_10,
                              margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.2, color: Colors.grey.shade200),
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
                                      border: Border.all(
                                          width: 0.3,
                                          color: Colors.grey.shade300),
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
                                            "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${event.currentPicUrl}"),
                                      ),
                                    ),
                                  ),
                                  heightSpace(0.7),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          //color: Colors.cyan,
                                          child: customText(
                                              text: event.eventName.toString(),
                                              fontSize: 14,
                                              textColor: AppColors.black,
                                              fontWeight: FontWeight.w700,
                                              lines: 1),
                                        ),
                                      ),
                                      widthSpace(1.5),

                                      event.currency == "USD"
                                          ? customText(
                                              text:
                                                  "\$${event.maxPrice.toString()}",
                                              fontSize: 13,
                                              textColor: AppColors.deepPrimary,
                                              fontWeight: FontWeight.w500,
                                            )
                                          : Text(
                                              "$naira${event.maxPrice.toString()}",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 13,
                                                color: AppColors.deepPrimary,
                                                fontWeight: FontWeight.w600,
                                              ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.place_rounded,
                                        size: 15,
                                        color: Colors.grey.shade400,
                                      ),
                                      widthSpace(1),
                                      Flexible(
                                        child: customText(
                                          text: event.location!.address
                                              .toString(),
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
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            //color: Colors.amber,
                                            width:
                                                event.interestedUsers!.length <
                                                        2
                                                    ? 40
                                                    : event.interestedUsers!
                                                                .length <
                                                            3
                                                        ? 68
                                                        : 68,
                                            height: 35,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: event.interestedUsers!
                                                          .length <
                                                      2
                                                  ? event
                                                      .interestedUsers!.length
                                                  : 2, //
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                InterestedUsers indiv = event
                                                    .interestedUsers![index];
                                                // Replace this with your actual list item widget
                                                return Container(
                                                  width: 8.w,
                                                  height: 6.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color: AppColors.primary
                                                        .withOpacity(0.5),
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
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () => context.push(
                                          AppRoutes.eventAttendeesView,
                                          extra: event.id,
                                        ),
                                        child: Container(
                                          width: 8.w,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: AppColors.deepPrimary,
                                          ),
                                          child: Center(
                                            child: customText(
                                              text:
                                                  "+${event.memberCount.toString()}",
                                              fontSize: 10,
                                              textColor: AppColors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      widthSpace(1),
                                      customText(
                                        text: "Interested",
                                        fontSize: 12,
                                        textColor: AppColors.deepPrimary,
                                        fontWeight: FontWeight.w600,
                                        lines: 1,
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                String text =
                                                    "https://chasescroll-new.netlify.app/events/${event.id}";

                                                await Share.share(
                                                  text,
                                                  subject:
                                                      'Check out this user profile from Chasescroll',
                                                  sharePositionOrigin:
                                                      Rect.fromCenter(
                                                    center: const Offset(0, 0),
                                                    width: 100,
                                                    height: 100,
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                child: SvgPicture.asset(
                                                  AppImages.share,
                                                  height: 2.9.h,
                                                  width: 2.9.w,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                            widthSpace(3),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  event.isSaved != true
                                                      ? saveEvent(
                                                          event.id.toString())
                                                      : unSaveEvent(
                                                          event.id.toString(),
                                                        );
                                                },
                                                child: Container(
                                                  child: event.isSaved == true
                                                      ? SvgPicture.asset(
                                                          AppImages
                                                              .bookmarkFilled,
                                                          height: 2.7.h,
                                                          width: 2.7.w,
                                                        )
                                                      : SvgPicture.asset(
                                                          AppImages.bookmark,
                                                          height: 2.7.h,
                                                          width: 2.7.w,
                                                        ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

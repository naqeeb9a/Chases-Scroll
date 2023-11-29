import 'dart:developer';

import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/screens/profile_view/settings/eventDasboard/event_dasboard_data_view.dart';
import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/helpers/change_millepoch.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyEventByIDView extends HookWidget {
  static final EventRepository _eventRepository = EventRepository();

  const MyEventByIDView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final myEventLoading = useState<bool>(true);
    final myEventModel = useState<List<EventContent>>([]);
    final allEvents = useState<List<EventContent>>([]);
    final foundEvents = useState<List<EventContent>>([]);

    getMyEvents() {
      _eventRepository.getEventsByID().then((value) {
        myEventLoading.value = false;
        myEventModel.value = value;
        foundEvents.value = value;
        allEvents.value = value;
      });
    }

    void refreshEvent() {
      myEventLoading.value = false; // Set loading state back to true
      getMyEvents(); // Trigger the API call again
    }

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

    useEffect(() {
      getMyEvents();
      return null;
    }, []);

    return Scaffold(
      appBar: appBar(title: "My Events"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              AppTextFormField(
                prefixIcon: SvgPicture.asset(
                  AppImages.searchIcon,
                  height: 20,
                  width: 20,
                  color: AppColors.deepPrimary,
                ),
                hintText: "Search for event or ...",
                onChanged: (value) {
                  //_runUsersFilter(value);
                },
              ),
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    children: [
                      myEventModel.value.isEmpty
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
                                    text: "You have no created event",
                                    fontSize: 12,
                                    textColor: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            )
                          : Expanded(
                              child: Container(
                                child: ListView.builder(
                                  itemCount: myEventModel.value.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    EventContent myEvent =
                                        myEventModel.value[index];
                                    //for formatted time
                                    int startTimeInMillis = myEvent.startTime!;
                                    DateTime startTime = DateTimeUtils
                                        .convertMillisecondsToDateTime(
                                            startTimeInMillis);
                                    String formattedDate =
                                        DateUtilss.formatDateTime(startTime);
                                    String eventTypeString =
                                        myEvent.eventType!.replaceAll("_", " ");
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OrganizerAnalyticsScreenView(
                                              eventId: myEvent.id!,
                                              eventName: myEvent.eventName!,
                                              currency: myEvent.currency!,
                                              date: formattedDate,
                                              location: myEvent
                                                  .location!.address
                                                  .toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: PAD_ALL_10,
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 105,
                                                  width: 125,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(24),
                                                      bottomRight:
                                                          Radius.circular(24),
                                                      topLeft:
                                                          Radius.circular(24),
                                                      topRight:
                                                          Radius.circular(0),
                                                    ),
                                                    color: Colors.grey.shade200,
                                                    image: DecorationImage(
                                                      scale: 1.0,
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(
                                                          "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${myEvent.currentPicUrl}"),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 5, 5, 0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Flexible(
                                                              child: customText(
                                                                  text: myEvent
                                                                      .eventName
                                                                      .toString(),
                                                                  fontSize: 14,
                                                                  textColor:
                                                                      AppColors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  lines: 1),
                                                            ),
                                                            widthSpace(1),
                                                            customText(
                                                                text: myEvent
                                                                    .minPrice
                                                                    .toString(),
                                                                fontSize: 14,
                                                                textColor:
                                                                    AppColors
                                                                        .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ],
                                                        ),
                                                        heightSpace(1),
                                                        Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              AppImages
                                                                  .calendarIcon,
                                                              height: 15,
                                                              width: 15,
                                                            ),
                                                            widthSpace(1),
                                                            customText(
                                                                text:
                                                                    formattedDate,
                                                                fontSize: 12,
                                                                textColor: AppColors
                                                                    .searchTextGrey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ],
                                                        ),
                                                        heightSpace(0.5),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .place_rounded,
                                                              size: 15,
                                                              color: AppColors
                                                                  .deepPrimary,
                                                            ),
                                                            widthSpace(1),
                                                            Flexible(
                                                              child: customText(
                                                                text: myEvent
                                                                    .location!
                                                                    .address
                                                                    .toString(),
                                                                fontSize: 12,
                                                                textColor: AppColors
                                                                    .deepPrimary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                lines: 1,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        heightSpace(0.5),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Expanded(
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  customText(
                                                                      text:
                                                                          "Category: ",
                                                                      fontSize:
                                                                          11,
                                                                      textColor:
                                                                          AppColors
                                                                              .searchTextGrey,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                  Expanded(
                                                                    child: customText(
                                                                        text: eventTypeString
                                                                            .toString(),
                                                                        fontSize:
                                                                            11,
                                                                        textColor:
                                                                            AppColors
                                                                                .deepPrimary,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            widthSpace(1.3),
                                                            Container(
                                                              padding:
                                                                  PAD_ALL_8,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4),
                                                                  color: AppColors
                                                                      .backgroundGrey),
                                                              child: customText(
                                                                  text: myEvent
                                                                              .isOrganizer ==
                                                                          true
                                                                      ? "Organizer"
                                                                      : "Attending",
                                                                  fontSize: 10,
                                                                  textColor:
                                                                      AppColors
                                                                          .deepPrimary,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

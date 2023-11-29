import 'dart:developer';

import 'package:chases_scroll/src/models/attendee_model.dart';
import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/repositories/explore_repository.dart';
import 'package:chases_scroll/src/screens/profile_view/settings/eventDasboard/refund_reason_screen.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/shimmer_.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class RefundUserEventView extends HookWidget {
  final String? eventId;

  final EventRepository _eventRepository = EventRepository();
  final ExploreRepository _exploreRepository = ExploreRepository();

  RefundUserEventView({
    super.key,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    //------------------------------------------------------------------------//
    //-------------------This is for Users -----------------------------------//
    final usersLoading = useState<bool>(true);
    final usersModel = useState<List<EventAttendeesModel>>([]);
    final allUsers = useState<List<EventAttendeesModel>>([]);
    final foundUsers = useState<List<EventAttendeesModel>>([]);

    getEventUsers() {
      _eventRepository.getEventAttendes(eventId: eventId).then((value) {
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
            .where((event) => event.user!.firstName!
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();

        foundUsers.value = found;
      }
    }

    void refreshSuggestedUsers() {
      usersLoading.value = false; // Set loading state back to true
      getEventUsers(); // Trigger the API call again
    }

    useEffect(() {
      getEventUsers();
      return null;
    }, []);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(
                      Icons.close,
                      size: 22,
                      color: AppColors.deepPrimary,
                    ),
                  ),
                  customText(
                      text: "Event Attendees",
                      fontSize: 14,
                      textColor: AppColors.deepPrimary,
                      fontWeight: FontWeight.w700,
                      lines: 2),
                  GestureDetector(
                    child: const Icon(
                      Icons.close,
                      size: 22,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0, left: 20, right: 20),
              child: AppTextFormField(
                //textEditingController: searchController,
                //label: "",
                hintText: "Search for users attending event ...",
                onChanged: (value) {
                  _runUsersFilter(value);
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    usersLoading.value
                        ? searchUsersShimmerWithlength(
                            count: 6,
                          )
                        : Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: ListView.builder(
                                itemCount: foundUsers.value.length,
                                itemBuilder: (BuildContext context, int index) {
                                  ContentUser attendee =
                                      foundUsers.value[index].user!;

                                  log("my attendee => ${attendee.toString()}");

                                  return GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 8),
                                      margin: const EdgeInsets.only(
                                          right: 15, bottom: 5),

                                      ///color: AppColors.blue,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        bottomLeft:
                                                            Radius.circular(40),
                                                        bottomRight:
                                                            Radius.circular(40),
                                                        topLeft:
                                                            Radius.circular(40),
                                                        topRight:
                                                            Radius.circular(0),
                                                      ),
                                                      color:
                                                          Colors.grey.shade100,
                                                      border: Border.all(
                                                          color:
                                                              AppColors.primary,
                                                          width: 1.5),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${attendee.data!.imgMain!.value}"),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Visibility(
                                                        visible: attendee
                                                                    .data!
                                                                    .imgMain!
                                                                    .value ==
                                                                null
                                                            ? true
                                                            : false,
                                                        child: customText(
                                                            text: attendee
                                                                    .firstName!
                                                                    .isEmpty
                                                                ? ""
                                                                : "${attendee.firstName![0]}${attendee.lastName![0]}"
                                                                    .toUpperCase(),
                                                            fontSize: 14,
                                                            textColor: AppColors
                                                                .deepPrimary,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                  widthSpace(2),
                                                  Container(
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
                                                                "${attendee.firstName} ${attendee.lastName}",
                                                            fontSize: 12,
                                                            textColor:
                                                                AppColors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                        SizedBox(
                                                          width: 130,
                                                          child: customText(
                                                              text: attendee
                                                                  .username!,
                                                              fontSize: 11,
                                                              textColor: AppColors
                                                                  .searchTextGrey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          RefundTicketOptionScreenView(
                                                        title:
                                                            "Refund?\nyou are refunding payment to all Attendees for the ${attendee.firstName} ${attendee.firstName}, are\nyou sure you want to preceed?",
                                                        refundNumber: 1,
                                                        eventId: eventId!,
                                                        userId:
                                                            attendee.userId!,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: customText(
                                                    text: "Refund User",
                                                    fontSize: 11,
                                                    textColor:
                                                        AppColors.deepPrimary,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                          heightSpace(0.2),
                                          const Divider(
                                            thickness: 0.5,
                                            color: AppColors.iconGrey,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

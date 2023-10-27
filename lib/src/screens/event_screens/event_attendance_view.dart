import 'dart:developer';

import 'package:chases_scroll/src/models/attendee_model.dart';
import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/shimmer_.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';

class EventAttendeesView extends HookWidget {
  final Content eventDetails;

  final EventRepository _eventRepository = EventRepository();

  EventAttendeesView({
    super.key,
    required this.eventDetails,
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
      _eventRepository.getEventAttendes(eventId: eventDetails.id).then((value) {
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

    useEffect(() {
      getEventUsers();
      return null;
    }, []);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: PAD_ALL_20,
          child: Column(
            children: [
              Row(
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
                      text: eventDetails.eventName!,
                      fontSize: 16,
                      textColor: AppColors.deepPrimary,
                      fontWeight: FontWeight.w700,
                      lines: 2),
                  const Icon(
                    Icons.close,
                    size: 22,
                    color: AppColors.white,
                  ),
                ],
              ),
              heightSpace(2),
              SizedBox(
                height: 40,
                width: 100,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: 8.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      child: Container(
                        width: 8.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 40,
                      child: Container(
                        width: 8.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 60,
                      child: Container(
                        width: 8.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.deepPrimary,
                        ),
                        child: Center(
                          child: customText(
                            text: "+${eventDetails.memberCount.toString()}",
                            fontSize: 10,
                            textColor: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              heightSpace(2),
              Padding(
                padding: const EdgeInsets.only(bottom: 0, left: 5, right: 5),
                child: AppTextFormField(
                  //textEditingController: searchController,
                  //label: "",
                  hintText: "Search for users attending event ...",
                  onChanged: (value) {
                    _runUsersFilter(value);
                  },
                ),
              ),
              heightSpace(3),
              Expanded(
                child: Column(
                  children: [
                    usersLoading.value
                        ? searchUsersShimmerWithlength(
                            count: 6,
                          )
                        : Expanded(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              width: double.infinity,
                              child: ListView.builder(
                                itemCount: foundUsers.value.length,
                                itemBuilder: (BuildContext context, int index) {
                                  User attendee = foundUsers.value[index].user!;

                                  log(attendee.toString());

                                  return Text(foundUsers
                                      .value[index].users!.firstName!);

                                  // return SearchPeopleWidget(
                                  //   fullName:
                                  //       "${attendee.firstName} ${attendee.lastName}",
                                  //   username: "${attendee.username}",
                                  //   image: attendee
                                  //               .data?.imgMain?.objectPublic ==
                                  //           false
                                  //       ? ""
                                  //       : (attendee.data?.imgMain?.value ?? "")
                                  //           .toString(),
                                  // );
                                },
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

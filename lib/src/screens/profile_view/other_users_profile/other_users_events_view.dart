import 'dart:developer';
import 'dart:io';

import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/repositories/profile_repository.dart';
import 'package:chases_scroll/src/screens/event_screens/widgets/event_small_card_title.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/helpers/change_millepoch.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';

class SeeOtherUsersEventsView extends HookWidget {
  static final ProfileRepository _profileRepository = ProfileRepository();
  static final EventRepository _eventRepository = EventRepository();
  final String? userId;
  const SeeOtherUsersEventsView({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    //this is for events -----------------------------------------------
    final myEventLoading = useState<bool>(true);
    final myEventModel = useState<List<EventContent>>([]);
    final allEvents = useState<List<EventContent>>([]);
    final foundEvents = useState<List<EventContent>>([]);

    getMyEvents() {
      _eventRepository.getOtherUsersEvents(userID: userId).then((value) {
        myEventLoading.value = false;
        myEventModel.value = value;
        foundEvents.value = value;
        allEvents.value = value;
      });
    }

    refreshConnection() {
      myEventLoading.value = false;
      getMyEvents();
    }

    //for events filtered list
    void _runUsersFilter(String enteredKeyword) {
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
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        title: customText(
          text: "See More Users",
          fontSize: 14,
          textColor: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Platform.isIOS
                ? Icons.arrow_back_ios_new_rounded
                : Icons.arrow_back_rounded,
            size: 20,
            color: Colors.black87,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: AppTextFormField(
                      //textEditingController: searchController,
                      //label: "",
                      hintText: "Search for Events ...",
                      onChanged: (value) {
                        _runUsersFilter(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            foundEvents.value.isEmpty
                ? SizedBox(
                    height: 20.h,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 5.h,
                          backgroundColor:
                              AppColors.deepPrimary.withOpacity(0.1),
                          child: SvgPicture.asset(
                            AppImages.calendarAdd,
                            color: AppColors.deepPrimary,
                            height: 5.h,
                          ),
                        ),
                        heightSpace(1),
                        customText(
                          text: "You have no created or attending event",
                          fontSize: 12,
                          textColor: AppColors.deepPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: foundEvents.value.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        EventContent myEvent = foundEvents.value[index];
                        //for formatted time
                        int startTimeInMillis = myEvent.startTime!;
                        DateTime startTime =
                            DateTimeUtils.convertMillisecondsToDateTime(
                                startTimeInMillis);
                        String formattedDate =
                            DateUtilss.formatDateTime(startTime);
                        String eventTypeString =
                            myEvent.eventType!.replaceAll("_", " ");
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: EventSmallTitleCard(
                            eventName: myEvent.eventName,
                            date: formattedDate,
                            location: myEvent.location!.address,
                            image: myEvent.currentPicUrl,
                            price: myEvent.minPrice,
                            eventDetails: myEvent,
                            category: eventTypeString,
                            isOrganser: myEvent.isOrganizer,
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

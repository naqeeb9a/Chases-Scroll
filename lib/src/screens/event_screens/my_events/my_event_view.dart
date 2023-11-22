import 'dart:developer';

import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/screens/event_screens/widgets/event_small_card_title.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/utils/constants/helpers/change_millepoch.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../repositories/event_repository.dart';
import '../../../utils/constants/colors.dart';

class MyEventView extends HookWidget {
  static final EventRepository _eventRepository = EventRepository();
  bool isSaved = false;

  MyEventView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final myEventLoading = useState<bool>(true);
    final myEventModel = useState<List<EventContent>>([]);
    final allEvents = useState<List<EventContent>>([]);
    final foundEvents = useState<List<EventContent>>([]);

    getMyEvents() {
      _eventRepository.getMyEvents().then((value) {
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

    void runEventFilter(String enteredKeyword) {
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

    return Padding(
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
              runEventFilter(value);
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
                                text: "You have no created or attending event",
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
                                return EventSmallTitleCard(
                                  eventName: myEvent.eventName,
                                  date: formattedDate,
                                  location: myEvent.location!.address,
                                  image: myEvent.currentPicUrl,
                                  price: myEvent.minPrice,
                                  eventDetails: myEvent,
                                  category: eventTypeString,
                                  isOrganser: myEvent.isOrganizer,
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
    );
  }
}

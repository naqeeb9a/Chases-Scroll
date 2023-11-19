import 'dart:developer';

import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/screens/event_screens/widgets/event_small_card.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/helpers/change_millepoch.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/spacer.dart';

class SavedEventsView extends HookWidget {
  static final EventRepository _eventRepository = EventRepository();
  bool isSaved = false;

  SavedEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    final mySaveEventLoading = useState<bool>(true);
    final mySaveEventModel = useState<List<EventContent>>([]);
    final allEvents = useState<List<EventContent>>([]);
    final foundEvents = useState<List<EventContent>>([]);

    getSaveMyEvents() {
      _eventRepository.getSavedEvents().then((value) {
        mySaveEventLoading.value = false;
        mySaveEventModel.value = value;
        foundEvents.value = value;
        allEvents.value = value;
      });
    }

    void refreshEvent() {
      mySaveEventLoading.value = false; // Set loading state back to true
      getSaveMyEvents(); // Trigger the API call again
    }

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
        refreshEvent();
        ToastResp.toastMsgSuccess(
            resp: "${result['message']}, swipe down to refresh");
      } else {
        ToastResp.toastMsgError(
            resp: "${result['message']}, swipe down to refresh");
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
        refreshEvent();
        ToastResp.toastMsgSuccess(
            resp: "${result['message']}, swipe down to refresh");
      } else {
        ToastResp.toastMsgError(
            resp: "${result['message']}, swipe down to refresh");
      }
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
      getSaveMyEvents();
      refreshEvent();
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
            hintText: "Search for users, event or...",
            onChanged: (value) {
              _runEventFilter(value);
            },
          ),
          Expanded(
            flex: 4,
            child: RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async {
                refreshEvent();
              },
              child: Container(
                child: Column(
                  children: [
                    mySaveEventModel.value.isEmpty
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
                                  text:
                                      "You have no created or attending event",
                                  fontSize: 12,
                                  textColor: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: ListView.builder(
                                itemCount: foundEvents.value.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  EventContent mySavedEvent =
                                      foundEvents.value[index];
                                  //for formatted time
                                  int startTimeInMillis =
                                      mySavedEvent.startTime!;
                                  DateTime startTime = DateTimeUtils
                                      .convertMillisecondsToDateTime(
                                          startTimeInMillis);
                                  String formattedDate =
                                      DateUtilss.formatDateTime(startTime);
                                  String eventTypeString = mySavedEvent
                                      .eventType!
                                      .replaceAll("_", " ");
                                  return EventSmallCard(
                                    eventName: mySavedEvent.eventName,
                                    date: formattedDate,
                                    location: mySavedEvent.location!.address,
                                    image: mySavedEvent.currentPicUrl,
                                    price: mySavedEvent.minPrice,
                                    eventDetails: mySavedEvent,
                                    isSaved: mySavedEvent.isSaved,
                                    onSave: () {
                                      mySavedEvent.isSaved == false
                                          ? saveEvent(mySavedEvent.id!)
                                          : unSaveEvent(mySavedEvent.id!);
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

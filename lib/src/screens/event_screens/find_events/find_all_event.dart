import 'dart:developer';

import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/screens/event_screens/widgets/event_big_card.dart';
import 'package:chases_scroll/src/screens/event_screens/widgets/event_small_card.dart';
import 'package:chases_scroll/src/screens/widgets/row_texts_widget.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/helpers/change_millepoch.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';

class FindAllEventCardView extends HookWidget {
  static final EventRepository _eventRepository = EventRepository();
  bool isSaved = false;

  FindAllEventCardView({super.key});

  @override
  Widget build(BuildContext context) {
    final allEventLoading = useState<bool>(true);
    final allEventModel = useState<List<Content>>([]);
    final topEventLoading = useState<bool>(true);
    final topEventModel = useState<List<Content>>([]);
    final currentPageValue = useValueNotifier(0);

    getAllEvents() {
      _eventRepository.getAllEvents().then((value) {
        allEventLoading.value = false;
        allEventModel.value = value;
      });
    }

    getTopEvents() {
      _eventRepository.getTopEvents().then((value) {
        topEventLoading.value = false;
        topEventModel.value = value;
      });
    }

    //for event data changes
    void refreshEventData() {
      allEventLoading.value = false;
      getAllEvents();
    }

    void refreshEvent() {
      topEventLoading.value = false; // Set loading state back to true
      getTopEvents(); // Trigger the API call again
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
      if (result['updated'] == true) {
        refreshEvent();
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
      if (result['updated'] == true) {
        refreshEvent();
        ToastResp.toastMsgSuccess(resp: result['message']);
      } else {
        ToastResp.toastMsgError(resp: result['message']);
      }
    }

    useEffect(() {
      getAllEvents();
      getTopEvents();
      return null;
    }, []);

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightSpace(1),
          Expanded(
            flex: 6,
            child: Container(
              child: ListView.builder(
                itemCount: allEventModel.value.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  Content allEvent = allEventModel.value[index];
                  //for formatted time
                  int? startTimeInMillis = allEvent.startTime;
                  DateTime startTime =
                      DateTimeUtils.convertMillisecondsToDateTime(
                          startTimeInMillis!);
                  String formattedDate = DateUtilss.formatDateTime(startTime);
                  return EventBigCard(
                    80.w,
                    eventDetails: allEvent,
                    eventName: allEvent.eventName,
                    date: formattedDate,
                    location: allEvent.location!.address,
                    image: allEvent.currentPicUrl,
                    price: allEvent.minPrice,
                  );
                },
              ),
            ),
          ),
          RowTextGestureView(
            leftText: "Trending Event 🔥",
            function: () => context.push(AppRoutes.findTrendingEvent),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: ListView.builder(
                itemCount: topEventModel.value.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  Content topEvent = topEventModel.value[index];
                  //for formatted time
                  int startTimeInMillis = topEvent.startTime!;
                  DateTime startTime =
                      DateTimeUtils.convertMillisecondsToDateTime(
                          startTimeInMillis);
                  String formattedDate = DateUtilss.formatDateTime(startTime);

                  return EventSmallCard(
                    eventName: topEvent.eventName,
                    date: formattedDate,
                    location: topEvent.location!.address,
                    image: topEvent.currentPicUrl,
                    price: topEvent.minPrice,
                    isSaved: topEvent.isSaved!,
                    eventDetails: topEvent,
                    onSave: () {
                      topEvent.isSaved == false
                          ? saveEvent(topEvent.id!)
                          : unSaveEvent(topEvent.id!);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

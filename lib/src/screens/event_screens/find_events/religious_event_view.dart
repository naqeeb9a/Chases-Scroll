import 'dart:developer';

import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/screens/event_screens/event_main_view.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';

class FindReligiousEvents extends HookWidget {
  static final EventRepository _eventRepository = EventRepository();
  bool isSaved = false;

  FindReligiousEvents({super.key});

  @override
  Widget build(BuildContext context) {
    final myReligiousLoading = useState<bool>(true);
    final myReligiouslModel = useState<List<EventContent>>([]);

    getMyEvents() {
      _eventRepository.getReligiousEvents().then((value) {
        myReligiousLoading.value = false;
        myReligiouslModel.value = value;
      });
    }

    //for event data changes
    void refreshEventData() {
      myReligiousLoading.value = false; // Set loading state back to true
      getMyEvents(); // Trigger the API call again
    }

    //value for userID
    String userId =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);

    useEffect(() {
      getMyEvents();
      return null;
    }, []);
    return Column(
      children: [
        myReligiouslModel.value.isEmpty
            ? SizedBox(
                height: 50.h,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 10.h,
                      backgroundColor: AppColors.deepPrimary.withOpacity(0.1),
                      child: SvgPicture.asset(
                        AppImages.calendarAdd,
                        color: AppColors.deepPrimary,
                        height: 10.h,
                      ),
                    ),
                    heightSpace(2),
                    customText(
                      text: "No event available for this category",
                      fontSize: 12,
                      textColor: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              )
            : Expanded(
                flex: 4,
                child: Container(
                  child: ListView.builder(
                    itemCount: myReligiouslModel.value.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      EventContent event = myReligiouslModel.value[index];
                      return WideEventCards(
                        eventDetails: event,
                        image: event.currentPicUrl,
                        location: event.location!.address,
                        name: event.eventName,
                        price: event.minPrice,
                        users: event.memberCount,
                        isSaved: event.isSaved!,
                        onSave: () async {
                          final result = await _eventRepository.saveEvent(
                            eventID: event.id,
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
                        },
                      );
                    },
                  ),
                ),
              ),
      ],
    );
  }
}

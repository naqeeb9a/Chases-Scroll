import 'dart:developer';

import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/screens/event_screens/event_main_view.dart';
import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';

class FindTrendingEvents extends HookWidget {
  static final EventRepository _eventRepository = EventRepository();
  const FindTrendingEvents({super.key});

  @override
  Widget build(BuildContext context) {
    final topEventLoading = useState<bool>(true);

    final topEventModel = useState<List<EventContent>>([]);
    final allEvents = useState<List<EventContent>>([]);
    final foundEvents = useState<List<EventContent>>([]);
    //value for userID
    String userId =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.userId);

    getTopEvents() {
      _eventRepository.getTopEvents().then((value) {
        topEventLoading.value = false;
        topEventModel.value = value;
        foundEvents.value = value;
        allEvents.value = value;
      });
    }

    void refreshEvent() {
      topEventLoading.value = false; // Set loading state back to true
      getTopEvents(); // Trigger the API call again
    }

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

    //for events filtered list
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
      getTopEvents();
      return null;
    }, []);

    return Scaffold(
      appBar: appBar(title: "All Trending Events"),
      body: SafeArea(
        child: Padding(
          padding: PAD_ALL_10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightSpace(2),
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
              topEventModel.value.isEmpty
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
                      flex: 4,
                      child: Container(
                        child: ListView.builder(
                          itemCount: foundEvents.value.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            EventContent event = foundEvents.value[index];
                            return WideEventCards(
                              eventDetails: event,
                              image: event.currentPicUrl ?? "",
                              location: event.location!.address ?? "",
                              name: event.eventName ?? "",
                              price: event.minPrice ?? 0.0,
                              users: event.memberCount ?? 0,
                              isSaved: event.isSaved!,
                              onSave: () async {
                                event.isSaved == false
                                    ? saveEvent(event.id!)
                                    : unSaveEvent(event.id!);
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
    );
  }
}

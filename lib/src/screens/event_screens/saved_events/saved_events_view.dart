import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/screens/event_screens/widgets/event_small_card.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
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
    final mySaveEventModel = useState<List<Content>>([]);

    getSaveMyEvents() {
      _eventRepository.getSavedEvents().then((value) {
        mySaveEventLoading.value = false;
        mySaveEventModel.value = value;
      });
    }

    useEffect(() {
      getSaveMyEvents();
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
              //_runUsersFilter(value);
            },
          ),
          Expanded(
            flex: 4,
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
                            margin: const EdgeInsets.only(top: 15),
                            child: ListView.builder(
                              itemCount: mySaveEventModel.value.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                Content mySavedEvent =
                                    mySaveEventModel.value[index];
                                //for formatted time
                                int startTimeInMillis = mySavedEvent.startTime!;
                                DateTime startTime =
                                    DateTimeUtils.convertMillisecondsToDateTime(
                                        startTimeInMillis);
                                String formattedDate =
                                    DateUtilss.formatDateTime(startTime);
                                String eventTypeString = mySavedEvent.eventType!
                                    .replaceAll("_", " ");
                                return EventSmallCard(
                                  eventName: mySavedEvent.eventName,
                                  date: formattedDate,
                                  location: mySavedEvent.location!.address,
                                  image: mySavedEvent.currentPicUrl,
                                  price: mySavedEvent.minPrice,
                                  eventDetails: mySavedEvent,
                                  onSave: () {},
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

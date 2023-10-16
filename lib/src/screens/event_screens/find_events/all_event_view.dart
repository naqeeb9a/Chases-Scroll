import 'dart:developer';

import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/screens/event_screens/event_main_view.dart';
import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/colors.dart';

class FindAllEventsView extends HookWidget {
  static final EventRepository _eventRepository = EventRepository();
  final bool isSaved = false;

  const FindAllEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    final allEventlLoading = useState<bool>(true);
    final allEventModel = useState<List<Content>>([]);
    final allEvents = useState<List<Content>>([]);
    final foundEvents = useState<List<Content>>([]);

    getAllMyEvents() {
      _eventRepository.getAllEvents().then((value) {
        allEventlLoading.value = false;
        allEventModel.value = value;
        foundEvents.value = value;
        allEvents.value = value;
      });
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
      getAllMyEvents();
      return null;
    }, []);
    return Scaffold(
      appBar: appBar(title: "All Event"),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: PAD_ALL_10,
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
              allEventModel.value.isEmpty
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
                            Content event = foundEvents.value[index];
                            return WideEventCards(
                              name: event.eventName,
                              image: event.currentPicUrl,
                              location: event.location!.address,
                              price: event.minPrice,
                              users: event.memberCount,
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

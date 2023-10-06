import 'package:chases_scroll/src/screens/event_screens/event_main_view.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/event_model.dart';
import '../../../repositories/event_repository.dart';

class FindSocialEventsView extends HookWidget {
  static final EventRepository _eventRepository = EventRepository();
  bool isSaved = false;

  FindSocialEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    final mySocialLoading = useState<bool>(true);
    final mySocialModel = useState<List<ContentEvent>>([]);

    getMyEvents() {
      _eventRepository.getSocialEvents().then((value) {
        mySocialLoading.value = false;
        mySocialModel.value = value;
      });
    }

    useEffect(() {
      getMyEvents();
      return null;
    }, []);
    return Column(
      children: [
        mySocialModel.value.isEmpty
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
                    itemCount: mySocialModel.value.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return const WideEventCards();
                    },
                  ),
                ),
              ),
      ],
    );
  }
}

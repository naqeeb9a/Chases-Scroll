import 'package:chases_scroll/src/screens/event_screens/widgets/event_small_card_title.dart';
import 'package:chases_scroll/src/screens/widgets/textform_field.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/colors.dart';

class PastEventView extends HookWidget {
  bool isSaved = false;

  PastEventView({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return const EventSmallTitleCard();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

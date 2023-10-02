import 'package:chases_scroll/src/screens/event_screens/widgets/event_big_card.dart';
import 'package:chases_scroll/src/screens/event_screens/widgets/event_small_card.dart';
import 'package:chases_scroll/src/screens/widgets/row_texts_widget.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class FindAllEventCardView extends HookWidget {
  bool isSaved = false;

  FindAllEventCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightSpace(1),
          Expanded(
            flex: 5,
            child: Container(
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return EventBigCard(
                    80.w,
                  );
                },
              ),
            ),
          ),
          const RowTextGestureView(
            leftText: "Trending Event 🔥",
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return const EventSmallCard();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

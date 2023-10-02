import 'package:chases_scroll/src/screens/event_screens/event_main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FindReligiousEvents extends HookWidget {
  bool isSaved = false;

  FindReligiousEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            child: ListView.builder(
              itemCount: 4,
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

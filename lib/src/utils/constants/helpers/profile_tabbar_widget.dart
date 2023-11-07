import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class ChaseTabBar extends HookWidget {
  final int length;

  final List<String> titles;
  final List<Widget> body;
  const ChaseTabBar({
    Key? key,
    required this.length,
    required this.titles,
    required this.body,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = useTabController(initialLength: length);
    return DefaultTabController(
      length: length,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(56),
                color: const Color(0xfff5f5f5)),
            child: TabBar(
                labelColor: const Color(0xfff5f5f5),
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                controller: controller,
                tabs: titles
                    .map(
                      (e) => Tab(
                        height: 5.h,
                        child: SizedBox(
                            child: Text(
                          e,
                          style: const TextStyle(color: Colors.black87),
                        )),
                      ),
                    )
                    .toList()),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TabBarView(
              controller: controller,
              children: body,
            ),
          ))
        ],
      ),
    );
  }
}

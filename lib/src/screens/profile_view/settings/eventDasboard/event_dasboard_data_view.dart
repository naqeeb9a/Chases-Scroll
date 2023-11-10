import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EventDashboardByID extends StatefulHookWidget {
  const EventDashboardByID({super.key});

  @override
  State<EventDashboardByID> createState() => _EventDashboardByIDState();
}

class _EventDashboardByIDState extends State<EventDashboardByID> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [],
      ),
    );
  }
}

import 'dart:developer';

import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/models/event_model.dart';
import 'package:chases_scroll/src/models/ticket_summary_model.dart';
import 'package:chases_scroll/src/providers/event_statenotifier.dart';
import 'package:chases_scroll/src/screens/event_screens/widgets/event_detail_map_locationCard.dart';
import 'package:chases_scroll/src/screens/event_screens/widgets/event_details_iconText.dart';
import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/helpers/change_millepoch.dart';
import 'package:chases_scroll/src/utils/constants/helpers/luncher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/images.dart';
import '../../utils/constants/spacer.dart';

// final selectPriceIndexNotifier =
//     StateNotifierProvider<SelectPriceIndexNotifier, int>(
//   (_) => SelectPriceIndexNotifier(20),
// );

final selectPriceIndexNotifier =
    AutoDisposeStateNotifierProvider<SelectPriceIndexNotifier, int>((ref) {
  return SelectPriceIndexNotifier(20);
});

List<String> wrapTicketTypeList = [
  "Free \$0.0",
  "Regular \$200",
  "Big Mack \$500",
  "Superior \$1000",
];

class EventDetailsMainView extends ConsumerWidget {
  final Content eventDetails;

  const EventDetailsMainView({super.key, required this.eventDetails});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // ref.read(selectPriceIndexNotifier.notifier).resetState();

    final notifier = ref.read(ticketSummaryProvider.notifier);
    final selectedIndex = ref.watch(selectPriceIndexNotifier);
    log(selectedIndex.toString());

    dynamic sDate =
        DateTimeUtils.convertMillisecondsToDateTime(eventDetails.startDate!);
    String startDate = DateFormat('MMM d, y').format(sDate);
    dynamic eDate =
        DateTimeUtils.convertMillisecondsToDateTime(eventDetails.endDate!);
    String endDate = DateFormat('MMM d, y').format(eDate);

    DateTime startTime =
        DateTimeUtils.convertMillisecondsToDateTime(eventDetails.startTime!);
    String formattedStartTime = DateFormat('hh:mm a').format(startTime);

    DateTime endTime =
        DateTimeUtils.convertMillisecondsToDateTime(eventDetails.endTime!);
    String formattedEndTime = DateFormat('hh:mm a').format(startTime);
    return Scaffold(
      appBar: appBar(
        title: "Event Details",
        appBarActionWidget: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            //onTap: widget.onSave,
            child: Container(
              child: SvgPicture.asset(
                AppImages.bookmark,
                height: 2.4.h,
                width: 2.4.w,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: PAD_ALL_15,
            child: SizedBox(
              height: height,
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 30.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(0),
                        ),
                        color: Colors.grey.shade200,
                        image: DecorationImage(
                          scale: 1.0,
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${eventDetails.currentPicUrl}"),
                        ),
                      ),
                    ),
                    heightSpace(1.2),
                    customText(
                      text: eventDetails.eventName.toString(),
                      fontSize: 16,
                      textColor: AppColors.black,
                      lines: 1,
                    ),
                    heightSpace(0.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                          text:
                              "${eventDetails.minPrice.toString()} - ${eventDetails.maxPrice.toString()}",
                          fontSize: 12,
                          textColor: AppColors.black,
                          lines: 2,
                        ),
                        SizedBox(
                          height: 30,
                          width: 100,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  width: 6.w,
                                  height: 3.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                child: Container(
                                  width: 6.w,
                                  height: 3.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 40,
                                child: Container(
                                  width: 6.w,
                                  height: 3.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 60,
                                child: Container(
                                  width: 6.w,
                                  height: 3.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: AppColors.deepPrimary,
                                  ),
                                  child: Center(
                                    child: customText(
                                      text:
                                          "+${eventDetails.memberCount.toString()}",
                                      fontSize: 6,
                                      textColor: AppColors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    heightSpace(1.6),
                    EventDetailsIconText(
                      iconString: AppImages.calendarAdd,
                      title: "${startDate.toString()} - ${endDate.toString()}",
                      subTitle: "Time-In ${formattedStartTime.toString()}",
                      subTitle2: "Time-Out ${formattedEndTime.toString()}",
                    ),
                    heightSpace(1),
                    EventDetailsIconText(
                      iconString: AppImages.location,
                      title: "${eventDetails.location!.address}",
                      subTitle: "${eventDetails.location!.locationDetails}",
                    ),
                    heightSpace(2),
                    const EventDetailsIconText(
                      iconString: AppImages.ticket,
                      title: "Select ticket Type",
                    ),
                    heightSpace(2),
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        spacing: 12,
                        children: eventDetails.productTypeData!
                            .asMap()
                            .entries
                            .map((e) {
                          int index = e.key;
                          ProductTypeData ticket = e.value;

                          return GestureDetector(
                            onTap: () {
                              ref
                                  .read(selectPriceIndexNotifier.notifier)
                                  .updateIndex(index);
                              log(e.value.ticketType!);
                              log(e.value.ticketPrice.toString());

                              notifier.updateTicketSummary(
                                currency: eventDetails.currency,
                                eventId: eventDetails.id,
                                image: eventDetails.currentPicUrl,
                                location: eventDetails.location!.address,
                                name: eventDetails.eventName,
                                numberOfTickets: 0,
                                price: e.value.ticketPrice,
                                ticketType: e.value.ticketType,
                              );
                            },
                            child: IntrinsicWidth(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 7),
                                decoration: BoxDecoration(
                                  color: selectedIndex == index
                                      ? AppColors.primary
                                      : Colors.white,
                                  border: Border.all(
                                    width: 1.5,
                                    color: AppColors.primary,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: PAD_ALL_10,
                                    child: Row(
                                      children: [
                                        customText(
                                          text: ticket.ticketType.toString(),
                                          fontSize: 12,
                                          textColor: selectedIndex == index
                                              ? AppColors.white
                                              : AppColors.deepPrimary,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        widthSpace(0.5),
                                        customText(
                                          text: ticket.ticketPrice.toString(),
                                          fontSize: 12,
                                          textColor: selectedIndex == index
                                              ? AppColors.white
                                              : AppColors.deepPrimary,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    heightSpace(2),
                    customText(
                      text: "Event Description",
                      fontSize: 13,
                      textColor: AppColors.deepPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                    heightSpace(1),
                    customText(
                      text: eventDetails.eventDescription.toString(),
                      fontSize: 12,
                      textColor: AppColors.black,
                      fontWeight: FontWeight.w400,
                      lines: 4,
                    ),
                    heightSpace(1.5),
                    EventDetailMapLocation(
                      height: height,
                      width: width,
                      function: () {
                        MapUtils.launchMapOnAddress(
                          eventDetails.location!.address!,
                        );
                      },
                    ),
                    heightSpace(2),
                    ChasescrollButton(
                      buttonText: "Buy Ticket",
                      onTap: () {
                        ref
                            .read(selectPriceIndexNotifier.notifier)
                            .resetState();
                        //log(notifier.state.name.toString());
                        context.push(AppRoutes.eventTicketSummaryScreen);
                      },
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

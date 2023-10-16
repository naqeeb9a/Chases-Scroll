import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/models/ticket_summary_model.dart';
import 'package:chases_scroll/src/providers/event_statenotifier.dart';
import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';

final counterProvider =
    AutoDisposeStateNotifierProvider<PriceNumberNotifier, int>((ref) {
  return PriceNumberNotifier();
});

class EventTicketSummaryScreen extends ConsumerWidget {
  const EventTicketSummaryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final notifier = ref.read(ticketSummaryProvider.notifier);
    final state = notifier.state;

    return Scaffold(
        backgroundColor: AppColors.backgroundSummaryScreen,
        appBar: appBar(title: "Title Detail"),
        body: Consumer(
          builder: (context, ref, child) {
            //final data = ref.read(myDataProvider);
            return Padding(
              padding: PAD_ALL_15,
              child: Column(
                children: [
                  Container(
                    height: 15.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    padding: PAD_ALL_10,
                    child: Row(
                      children: [
                        Container(
                          width: 40.w,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(0),
                            ),
                            color: Colors.grey.shade200,
                            image: DecorationImage(
                              scale: 1.0,
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  //TODO: Add video just incase user upload video for event image or video
                                  "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${state.image}"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: customText(
                                      text: state.name!,
                                      fontSize: 15,
                                      textColor: AppColors.black,
                                      fontWeight: FontWeight.w700,
                                      lines: 2),
                                ),
                                heightSpace(0.5),
                                Flexible(
                                  child: customText(
                                      text: state.location ?? "",
                                      fontSize: 12,
                                      textColor: AppColors.black,
                                      fontWeight: FontWeight.w500,
                                      lines: 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  heightSpace(2),
                  Container(
                    width: 95.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      border: Border.all(
                          color: const Color(0xffD0D4EB), width: 1.3),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
                      child: Column(
                        children: [
                          heightSpace(2),
                          customText(
                              text: "Number of Tickets",
                              fontSize: 12,
                              textColor: AppColors.searchTextGrey,
                              fontWeight: FontWeight.w500,
                              lines: 2),
                          heightSpace(1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => ref
                                    .read(counterProvider.notifier)
                                    .decrementNumber(),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black87,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: customText(
                                        text: "-",
                                        fontSize: 16,
                                        textColor: AppColors.searchTextGrey,
                                        fontWeight: FontWeight.w500,
                                        lines: 2),
                                  ),
                                ),
                              ),
                              widthSpace(4),
                              customText(
                                  text: counter.toString(),
                                  fontSize: 18,
                                  textColor: AppColors.black,
                                  fontWeight: FontWeight.w500,
                                  lines: 2),
                              widthSpace(4),
                              GestureDetector(
                                onTap: () {
                                  ref
                                      .read(counterProvider.notifier)
                                      .incrementNumber();
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: customText(
                                        text: "+",
                                        fontSize: 16,
                                        textColor: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                        lines: 1),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  ChasescrollButton(
                    buttonText: "Pay Now",
                    color: counter == 0
                        ? AppColors.primary.withOpacity(0.2)
                        : AppColors.deepPrimary,
                    onTap: () {
                      notifier.updateTicketSummary(
                        currency: state.currency,
                        eventId: state.eventId,
                        image: state.image,
                        location: state.location,
                        name: state.name,
                        price: state.price,
                        ticketType: state.ticketType,
                        numberOfTickets: counter,
                      );
                      context.push(AppRoutes.eventTicketPrivacyPolicyScreen);
                    },
                  ),
                  heightSpace(4),
                ],
              ),
            );
          },
        ));
  }
}

import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/providers/event_statenotifier.dart';
import 'package:chases_scroll/src/providers/eventicket_provider.dart';
import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
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

  Row bottomTicketValueContainer(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        customText(
            text: title,
            fontSize: 12,
            textColor: AppColors.black,
            fontWeight: FontWeight.w500,
            lines: 2),
        customText(
            text: value,
            fontSize: 12,
            textColor: AppColors.primary,
            fontWeight: FontWeight.w500,
            lines: 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final notifier = ref.read(ticketSummaryProvider.notifier);
    final state = notifier.state;

    double ticketServiceFee = 1.77 * counter;
    double ticketServiceFeeMain =
        double.parse(ticketServiceFee.toStringAsFixed(2));
    double totalAmount = state.price! + ticketServiceFee;

    //Dollar
    double dPrice = state.price! * counter;
    double total = ((dPrice * 1.025) + 0.30) / (1 - 0.059);
    double totalRoundedNumber = double.parse(total.toStringAsFixed(2));

    double serviceFee = state.price! * 0.025;
    double processingFee = total - dPrice - serviceFee;
    double proRoundedNumber = double.parse(processingFee.toStringAsFixed(2));

    //Naira
    double nPrice = state.price! * counter;
    double nTotal = ((nPrice * 1.025) + 100) / (1 - 0.039);
    if (nTotal < 2500) {
      nTotal = (nPrice * 1.025) / (1 - 0.039);
    }
    double nTotalRoundedNumber = double.parse(nTotal.toStringAsFixed(2));

    double nServiceFee = nPrice * 0.025;
    double nProcessingFee = nTotal - nPrice - nServiceFee;
    double nProRoundedNumber = double.parse(nProcessingFee.toStringAsFixed(2));

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
                          width: 35.w,
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
                                      fontSize: 14,
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
                                onTap: () {
                                  if (counter == 1) {
                                    ToastResp.toastMsgError(
                                        resp:
                                            "Number of ticket to purchase an event is 1 and above");
                                  } else {
                                    ref
                                        .read(counterProvider.notifier)
                                        .decrementNumber();
                                  }
                                },
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
                  heightSpace(1),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Visibility(
                      visible: state.price != 0.0 ? true : false,
                      child: state.currency == "NGN"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                bottomTicketValueContainer(
                                    "Ticket Price", "₦$nPrice"),
                                heightSpace(2),
                                bottomTicketValueContainer(
                                    "Service Fee", "₦$nServiceFee"),
                                heightSpace(2),
                                bottomTicketValueContainer(
                                    "Processing Fee", "₦$nProRoundedNumber"),
                                heightSpace(2),
                                bottomTicketValueContainer(
                                    "Total", "₦$nTotalRoundedNumber"),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                bottomTicketValueContainer(
                                    "Ticket Price", "\$$dPrice"),
                                heightSpace(2),
                                bottomTicketValueContainer(
                                    "Service Fee", "\$$serviceFee"),
                                heightSpace(2),
                                bottomTicketValueContainer(
                                    "Processing Fee", "\$$proRoundedNumber"),
                                heightSpace(2),
                                bottomTicketValueContainer(
                                    "Total", "\$$totalRoundedNumber"),
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

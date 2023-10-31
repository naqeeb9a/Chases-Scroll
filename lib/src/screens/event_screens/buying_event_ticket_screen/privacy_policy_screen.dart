import 'dart:developer';

import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/providers/event_statenotifier.dart';
import 'package:chases_scroll/src/providers/eventicket_provider.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/success_screen.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';

import '../../../services/storage_service.dart';

final policyStateProvider =
    AutoDisposeStateNotifierProvider<SelectPolicyStateNotifier, bool>((ref) {
  return SelectPolicyStateNotifier();
});

class EventTicketPrivacyPolicyScreen extends ConsumerWidget {
  final EventRepository _eventRepository = EventRepository();

  EventTicketPrivacyPolicyScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final policyState = ref.watch(policyStateProvider);
    final notifier = ref.read(ticketSummaryProvider.notifier);
    final state = notifier.state;
    final storage = locator<LocalStorageService>();

    void onTapFreeSuccess() {
      context.push(
        AppRoutes.threeLoadingDotsScreen,
        extra: const EventSuccessScreenView(
          widgetScreenString: AppRoutes.refundBoughtDetailScreen,
        ),
      );
    }

    void onTapPaidSuccess() {
      context.push(
        AppRoutes.paymentMethodScreen,
      );
    }

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
                                      text: state.name.toString(),
                                      fontSize: 15,
                                      textColor: AppColors.black,
                                      fontWeight: FontWeight.w700,
                                      lines: 2),
                                ),
                                heightSpace(0.5),
                                Flexible(
                                  child: customText(
                                      text: state.location.toString(),
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
                  heightSpace(0.5),
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
                          EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
                      child: Column(
                        children: [
                          Center(
                            child: customText(
                              text: "Chasescroll Refund\nPolicy",
                              fontSize: 16,
                              textColor: AppColors.black,
                              fontWeight: FontWeight.w500,
                              lines: 2,
                              textAlignment: TextAlign.center,
                            ),
                          ),
                          heightSpace(2),
                          customText(
                            text:
                                "Payment has been debited from your account but would be credited to the Organizers account after a 3 days wait  period. You would have the Right to cancel payment/Ticket only within this wait period. Your barcode would be added to your ticket after the wait period.",
                            fontSize: 14,
                            textColor: AppColors.black.withOpacity(0.5),
                            fontWeight: FontWeight.w400,
                            lines: 15,
                            textAlignment: TextAlign.center,
                          ),
                          heightSpace(1.5),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (policyState == false) {
                                    ref
                                        .read(policyStateProvider.notifier)
                                        .changeTrue();
                                  } else {
                                    ref
                                        .read(policyStateProvider.notifier)
                                        .changeFalse();
                                  }
                                },
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      width: 1.3,
                                      color: policyState == true
                                          ? AppColors.deepPrimary
                                          : Colors.grey.shade400,
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.check,
                                      size: 15,
                                      color: policyState
                                          ? AppColors.deepPrimary
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),
                              widthSpace(1),
                              Expanded(
                                child: customText(
                                  text:
                                      "Accept By clicking Continue, you hereby accept the Chasescroll Refund policy",
                                  fontSize: 12,
                                  textColor: AppColors.searchTextGrey,
                                  fontWeight: FontWeight.w500,
                                  lines: 3,
                                  textAlignment: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  ChasescrollButton(
                    buttonText: "Pay Now",
                    color: policyState == false
                        ? AppColors.primary.withOpacity(0.2)
                        : AppColors.deepPrimary,
                    onTap: () async {
                      if (policyState == false) {
                        ToastResp.toastMsgError(
                            resp: "Accept Refend Policy agreement to proceed");
                      } else {
                        final result = await _eventRepository.createTicket(
                          eventID: state.eventId,
                          numberOfTickets: state.numberOfTickets,
                          ticketType: state.ticketType,
                        );

                        if (result['updated'] == true) {
                          //to get the ordercode &V orderID from resposnse
                          log("order code +++++++++++==> ${result['content']['orderCode']}");
                          storage.saveDataToDisk<String>(AppKeys.orderCode,
                              result['content']['orderCode']);
                          storage.saveDataToDisk<String>(
                              AppKeys.orderID, result['content']['orderId']);

                          if (state.price == 0.0 || state.price == 0) {
                            onTapFreeSuccess();
                          } else {
                            onTapPaidSuccess();
                          }
                        } else {
                          ToastResp.toastMsgError(
                              resp: result['Could not create ticket']);
                        }
                      }
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

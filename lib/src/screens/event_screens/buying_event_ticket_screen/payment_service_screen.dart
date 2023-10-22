import 'dart:developer';

import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/providers/eventicket_provider.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/helpers/strings.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CardCurrencyScreenView extends ConsumerWidget {
  static final EventRepository _eventRepository = EventRepository();
  const CardCurrencyScreenView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    void onTapCheckoutSuccessPS(String? checkout) {
      context.push(AppRoutes.webEventPayStack, extra: checkout);
    }

    void onTapCheckoutSuccessST(String? checkout) {
      context.push(AppRoutes.webEventStripe, extra: checkout);
    }

    final notifier = ref.read(ticketSummaryProvider.notifier);
    final state = notifier.state;
    return Scaffold(
      backgroundColor: const Color(0xffF1F2F9),
      body: SafeArea(
        child: Padding(
          padding: PAD_ALL_15,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Colors.black87,
                    ),
                  ),
                  customText(
                    text: "Card Payment Option",
                    fontSize: 14,
                    textColor: AppColors.black,
                  ),
                  const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Color(0xffF1F2F9),
                  ),
                ],
              ),
              heightSpace(3),
              state.currency == "USD"
                  ? cardPaymentContainerGesture(
                      "",
                      AppImages.stripe,
                      () async {
                        Map<String, dynamic> result =
                            await _eventRepository.createWebUrlPayStack();

                        if (result.isNotEmpty) {
                          log(result['checkout'].toString());
                          onTapCheckoutSuccessPS(result['checkout']);
                        } else {
                          ToastResp.toastMsgError(
                              resp: "Unable to create link for payment");
                        }
                      },
                      25,
                    )
                  : cardPaymentContainerGesture(
                      "",
                      AppImages.paystack,
                      () async {
                        Map<String, dynamic> result =
                            await _eventRepository.createWebUrlPayStack();

                        if (result.isNotEmpty) {
                          log(result['checkout'].toString());
                          onTapCheckoutSuccessST(result['checkout']);
                        } else {
                          ToastResp.toastMsgError(
                              resp: "Unable to create link for payment");
                        }
                      },
                      15,
                    ),
              heightSpace(4),
              GestureDetector(
                onTap: () {
                  context.push(AppRoutes.bottomNav);
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: PAD_ALL_10,
                    decoration: BoxDecoration(
                      color: AppColors.deepPrimary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: customText(
                      text: "--> Go Back To Event",
                      fontSize: 14,
                      textColor: AppColors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

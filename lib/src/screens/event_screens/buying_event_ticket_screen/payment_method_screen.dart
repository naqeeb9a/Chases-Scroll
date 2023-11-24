import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/providers/eventicket_provider.dart';
import 'package:chases_scroll/src/repositories/wallet_repository.dart';
import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/screens/widgets/success_screen.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/helpers/strings.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaymentMethodScreenView extends ConsumerWidget {
  final WalletRepository _walletRepository = WalletRepository();

  PaymentMethodScreenView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage = locator<LocalStorageService>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final notifier = ref.read(ticketSummaryProvider.notifier);

    final state = notifier.state;

    void onTapFreeSuccess() {
      context.push(
        AppRoutes.threeLoadingDotsScreen,
        extra: const EventSuccessScreenView(
          widgetScreenString: AppRoutes.refundBoughtDetailScreen,
        ),
      );
    }

    return Scaffold(
      appBar: appBar(title: "Payment Method"),
      backgroundColor: const Color(0xffF1F2F9),
      body: SafeArea(
        child: Padding(
          padding: PAD_ALL_15,
          child: Column(
            children: [
              payMethodContainerGesture(
                "Pay With Card",
                AppImages.card,
                () {
                  context.push(AppRoutes.currencyPaymentScreen);
                },
              ),
              heightSpace(3),
              payMethodContainerGesture(
                "Pay With Wallet",
                AppImages.wallet,
                () async {
                  final currencyUSD =
                      storage.getDataFromDisk(AppKeys.balanceUSD);
                  double amountUSD = double.parse(currencyUSD.toString());

                  final currencyNGN =
                      storage.getDataFromDisk(AppKeys.balanceNaira);
                  double amountNGN = double.parse(currencyNGN.toString());

                  if (state.currency == "USD") {
                    if (amountUSD < state.price!) {
                      ToastResp.toastMsgError(
                          resp:
                              "Amount in wallet wont get you this event ticket");
                    } else {
                      final result =
                          await _walletRepository.buyEventWithWallet();

                      if (result['status'] != "error") {
                        ToastResp.toastMsgSuccess(
                            resp: "Payment with wallet successful");

                        onTapFreeSuccess();
                      } else {
                        ToastResp.toastMsgError(
                            resp: "Payment with wallet not successful");
                      }
                    }
                  } else {
                    if (state.currency == "NGN") {
                      if (amountNGN < state.price!) {
                        ToastResp.toastMsgError(
                            resp:
                                "Amount in wallet wont get you this event ticket");
                      } else {
                        final result =
                            await _walletRepository.buyEventWithWallet();

                        if (result['status'] != "error") {
                          ToastResp.toastMsgSuccess(
                              resp: "Payment with wallet successful");

                          onTapFreeSuccess();
                        } else {
                          ToastResp.toastMsgError(
                              resp: "Payment with wallet not successful");
                        }
                      }
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

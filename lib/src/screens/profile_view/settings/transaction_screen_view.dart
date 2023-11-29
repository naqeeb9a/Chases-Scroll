import 'package:chases_scroll/src/models/transaction_model.dart';
import 'package:chases_scroll/src/repositories/profile_repository.dart';
import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class TransactionScreeView extends HookWidget {
  static final ProfileRepository _profileRepository = ProfileRepository();

  const TransactionScreeView({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionPageLoading = useState<bool>(true);
    final transactionHistory = useState<List<TransactionHistory>>([]);

    getTransactionHistory() {
      _profileRepository.getTransactionHistory().then((value) {
        transactionPageLoading.value = false;
        transactionHistory.value = value;
      });
    }

    useEffect(() {
      getTransactionHistory();
      return null;
    }, []);

    return Scaffold(
      appBar: appBar(title: "Transaction History"),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: PAD_ALL_15,
          child: transactionPageLoading.value
              ? Center(
                  child: customText(
                      text: "No Record Found",
                      fontSize: 12,
                      textColor: AppColors.black),
                )
              : ListView.builder(
                  itemCount: transactionHistory.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = transactionHistory.value[index];

                    double payAmount = item.payableAmount! / 100;

                    int timestampInSeconds = 1699607489;
                    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                        timestampInSeconds * 1000);

                    String formattedDateTime =
                        DateFormat('MMM d, y, hh:mm a').format(dateTime);
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: item.purpose == "FUND_WALLET"
                                      ? const Color(0xff12BC42)
                                      : item.purpose == "PAY_FOR_TICKET"
                                          ? const Color(0xff5856d6)
                                          : Colors.red,
                                  //? item['purpose'] == "SELLER_REFUND" ?Colors.red: item['purpose'] == "BUYER_REFUND"?Colors.green: Colors.red,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    item.purpose == "FUND_WALLET"
                                        ? AppImages.receipt
                                        : item.purpose == "PAY_FOR_TICKET"
                                            ? AppImages.profileEvent
                                            : AppImages.receipt,
                                    height: 25,
                                    width: 25,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText(
                                    text: item.purpose == "FUND_WALLET"
                                        ? "Fund Wallet"
                                        : item.purpose == "PAY_FOR_TICKET"
                                            ? "Ticket Purchase"
                                            : "Cash Out",
                                    fontSize: 14,
                                    textColor: AppColors.black,
                                  ),
                                  customText(
                                    text: formattedDateTime,
                                    fontSize: 10,
                                    textColor: AppColors.textGrey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  heightSpace(0.5),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  item.currency == "NGN"
                                      ? customText(
                                          text: "+₦$payAmount",
                                          fontSize: 12,
                                          textColor: AppColors.black,
                                        )
                                      : customText(
                                          text: "+\$${payAmount.toString()}",
                                          fontSize: 12,
                                          textColor: AppColors.black,
                                        ),
                                  heightSpace(0.5),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: item.status == "STARTED"
                                          ? Colors.orange.withOpacity(0.15)
                                          : item.status == "PAID"
                                              ? const Color(0xff12BC42)
                                                  .withOpacity(0.15)
                                              : Colors.red.withOpacity(0.15),
                                    ),
                                    child: customText(
                                      text: item.status!,
                                      fontSize: 10,
                                      textColor: AppColors.black,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/models/transaction_model.dart';
import 'package:chases_scroll/src/repositories/wallet_repository.dart';
import 'package:chases_scroll/src/screens/profile_view/settings/wallet/set_up_paystack_view.dart';
import 'package:chases_scroll/src/screens/profile_view/settings/wallet/wallet_webView.dart';
import 'package:chases_scroll/src/screens/widgets/chasescroll_button.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class WalletView extends StatefulHookWidget {
  final PageController pageController;

  final int pageIndex;
  const WalletView(
      {Key? key, required this.pageController, required this.pageIndex})
      : super(key: key);

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  String? myListDaysValue = "All";
  bool _isBlueContainerVisible = true;

  final WalletRepository _walletRepository = WalletRepository();

  List<String> myListDays = [
    "All",
    "Monthly",
    "Yearly",
  ];
  final PageController pagesController = PageController();

  final amountController = TextEditingController(text: "0.0");

  final amountController2 = TextEditingController(text: "0.0");

  void animateTo(int page) {
    pagesController.animateToPage(
      page, // convert int to double
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final currentPageIndex = useState<int>(0);
    // bool accountStatus = StorageUtil.getBool(key: 'accountStatus');
    // bool accountStatusPaystack =
    //     StorageUtil.getBool(key: 'accountStatusPaystack');

    void animateTo(int page) {
      pagesController.animateToPage(
        page, // convert int to double
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }

    final walletHistoryLoading = useState<bool>(true);
    final walletHistoryModel = useState<List<TransactionHistory>>([]);

    getWalletHistory() {
      _walletRepository.walletHistory().then((value) {
        walletHistoryLoading.value = false;
        walletHistoryModel.value = value;
      });
    }

    //fund wallet NGN
    void fundWalletNGN() async {
      final result = await _walletRepository.fundWalletPaystack(
        amount: int.parse(amountController.text),
      );
      if (result['checkout'] != null) {
        ToastResp.toastMsgSuccess(resp: "Fund Account initiated");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PaymentPaystackFundNGN(
                  url: result['checkout'],
                  urlTransactID: result['transactionID'],
                )));
      } else {
        ToastResp.toastMsgError(resp: "Fund Account not initiated");
      }
    }

    //fund wallet USD
    void fundWalletUSD() async {
      final result = await _walletRepository.fundWalletStripe(
        amount: int.parse(amountController.text),
      );
      if (result['checkout'] != null) {
        ToastResp.toastMsgSuccess(resp: "Fund Account initiated");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PaymentStripeFund(
                  url: result['checkout'],
                  urlTransactID: result['transactionID'],
                )));
      } else {
        ToastResp.toastMsgError(resp: "Fund Account not initiated");
      }
    }

    final paystackCheckAccount = useState<bool>(true);

    void checkPaystackAccount() async {
      final result = await _walletRepository.checkPaystackAccount();
      if (result) {
        setState(() {
          paystackCheckAccount.value = result;
          log("is it true or false ====> ${paystackCheckAccount.value.toString()}");
        });
      } else {
        setState(() {
          paystackCheckAccount.value = result;
        });
      }
    }

    final balance =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.balanceNaira);

    useEffect(() {
      getWalletHistory();
      checkPaystackAccount();
      return null;
    }, []);

    return Container(
      child: RefreshIndicator(
        onRefresh: () async {
          // reset start and page values to their initial values
          walletUSDBalance();
          walletNGNBalance();
          // trigger a rebuild of the screen
          setState(() {});
        },
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  width: width,
                  decoration: BoxDecoration(
                    color: AppColors.deepPrimary,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: Colors.white),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(15),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: customText(
                                  text: "Balance",
                                  fontSize: 14,
                                  textColor: AppColors.deepPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.pageController.animateToPage(
                                  1, // convert int to double
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(15),
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: customText(
                                    text: "Escrow >",
                                    fontSize: 14,
                                    textColor: AppColors.deepPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _isBlueContainerVisible
                                ? usdContainer()
                                : nairaContainer(),
                          ],
                        ),
                        heightSpace(1),
                        ///////------------------------toggle button
                        Row(
                          children: [
                            customText(
                              text: "NGN",
                              fontSize: 12,
                              textColor: AppColors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            widthSpace(0.5),
                            Switch(
                              activeColor: Colors.white,
                              inactiveTrackColor: Colors.white38,
                              value: _isBlueContainerVisible,
                              onChanged: (value) async {
                                setState(() {
                                  _isBlueContainerVisible = value;
                                  log("toggle ====> $_isBlueContainerVisible");
                                  // StorageUtil.putBool(
                                  //     key: "switch",
                                  //     value: _isBlueContainerVisible);
                                });
                                // await Provider.of<WalletProvider>(context,
                                //         listen: false)
                                //     .getWalletHistoryList();
                              },
                            ),
                            widthSpace(0.5),
                            customText(
                              text: "USD",
                              fontSize: 12,
                              textColor: AppColors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                heightSpace(1.5),
                Container(
                  height: height / 8.8,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.deepPrimary)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.push(AppRoutes.bottomNav);
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    //color: boxPrimaryColor,
                                    border: Border.all(
                                      width: 1.5,
                                      color: AppColors.deepPrimary,
                                    ),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AppImages.profileEvent,
                                      height: 25,
                                      width: 25,
                                      color: AppColors.deepPrimary,
                                    ),
                                  ),
                                ),
                              ),
                              heightSpace(0.5),
                              customText(
                                text: "Buy Ticket",
                                fontSize: 12,
                                textColor: AppColors.deepPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              animateTo(1);
                              //bool switchh = StorageUtil.getBool(key: "switch");
                              // if (_isBlueContainerVisible == false) {
                              //   if (paystackCheckAccount.value == false) {
                              //     Navigator.of(context).push(
                              //       MaterialPageRoute(
                              //         builder: (context) =>
                              //             const SetupAccountPaystackView(),
                              //       ),
                              //     );
                              //   } else {
                              //     // showModalBottomSheet(
                              //     //   context: context,
                              //     //   builder: (context) => StatefulBuilder(
                              //     //     builder: (BuildContext context,
                              //     //         StateSetter state) {
                              //     //       return WalletAmountWithdrawalScreenView(
                              //     //         walletBalanceUSD:
                              //     //             Prefs.getUSD().toString(),
                              //     //         walletBalanceNGN:
                              //     //             Prefs.getNGN().toString(),
                              //     //       );
                              //     //     },
                              //     //   ),
                              //     // );
                              //   }
                              // }
                              // } else {
                              //   print(accountStatus);
                              //   if (accountStatus == false) {
                              //     return registerStripe();
                              //   } else {
                              //     showModalBottomSheet(
                              //       context: context,
                              //       builder: (context) => StatefulBuilder(
                              //         builder: (BuildContext context,
                              //             StateSetter state) {
                              //           return WalletAmountWithdrawalScreenView(
                              //             walletBalanceUSD:
                              //                 Prefs.getUSD().toString(),
                              //             walletBalanceNGN:
                              //                 Prefs.getNGN().toString(),
                              //           );
                              //         },
                              //       ),
                              //     );
                              //   }
                              // }
                            },
                            child: Container(
                              padding: PAD_ALL_5,
                              decoration: BoxDecoration(
                                  color: currentPageIndex.value == 1
                                      ? AppColors.deepPrimary
                                      : AppColors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      //color: boxPrimaryColor,
                                      border: Border.all(
                                        width: 1.5,
                                        color: currentPageIndex.value == 1
                                            ? AppColors.white
                                            : AppColors.deepPrimary,
                                      ),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        AppImages.walletRemove,
                                        height: 25,
                                        width: 25,
                                        color: currentPageIndex.value == 1
                                            ? AppColors.white
                                            : AppColors.deepPrimary,
                                      ),
                                    ),
                                  ),
                                  heightSpace(0.5),
                                  customText(
                                    text: "Cash Out",
                                    fontSize: 12,
                                    textColor: currentPageIndex.value == 1
                                        ? AppColors.white
                                        : AppColors.deepPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              animateTo(2);
                              // showModalBottomSheet(
                              //   context: context,
                              //   builder: (context) => StatefulBuilder(
                              //     builder: (BuildContext context,
                              //         StateSetter state) {
                              //       return const WalletAmountFundScreenView();
                              //     },
                              //   ),
                              // );
                              _isBlueContainerVisible == false
                                  ? fundWalletNGN()
                                  : fundWalletUSD();
                            },
                            child: Container(
                              padding: PAD_ALL_5,
                              decoration: BoxDecoration(
                                  color: currentPageIndex.value == 2
                                      ? AppColors.deepPrimary
                                      : AppColors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        width: 1.5,
                                        color: currentPageIndex.value == 2
                                            ? AppColors.white
                                            : AppColors.deepPrimary,
                                      ),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        AppImages.walletAdd,
                                        height: 25,
                                        width: 25,
                                        color: currentPageIndex.value == 2
                                            ? AppColors.white
                                            : AppColors.deepPrimary,
                                      ),
                                    ),
                                  ),
                                  heightSpace(0.5),
                                  customText(
                                    text: "Fund Wallet",
                                    fontSize: 12,
                                    textColor: currentPageIndex.value == 2
                                        ? AppColors.white
                                        : AppColors.deepPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              animateTo(0);
                            },
                            child: Container(
                              padding: PAD_ALL_5,
                              decoration: BoxDecoration(
                                  color: currentPageIndex.value == 0
                                      ? AppColors.deepPrimary
                                      : AppColors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      //color: AppColors.deepPrimary,
                                      border: Border.all(
                                        width: 1.5,
                                        color: currentPageIndex.value == 0
                                            ? AppColors.white
                                            : AppColors.deepPrimary,
                                      ),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        AppImages.receipt,
                                        height: 25,
                                        width: 25,
                                        color: currentPageIndex.value == 0
                                            ? AppColors.white
                                            : AppColors.deepPrimary,
                                      ),
                                    ),
                                  ),
                                  heightSpace(0.5),
                                  customText(
                                    text: "History",
                                    fontSize: 12,
                                    textColor: currentPageIndex.value == 0
                                        ? AppColors.white
                                        : AppColors.deepPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            heightSpace(1.5),
            Expanded(
              child: PageView(
                onPageChanged: (index) {
                  currentPageIndex.value = index;
                },
                controller: pagesController,
                children: [
                  Container(
                    height: height,
                    width: width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: ListView.builder(
                                itemCount: walletHistoryModel.value.length,
                                itemBuilder: (context, index) {
                                  TransactionHistory item =
                                      walletHistoryModel.value[index];

                                  double payAmount = item.payableAmount! / 100;

                                  if (item.timestamp != null) {
                                    // List<int>? timestamp = item.timestamp;
                                    // DateTime dateTime = DateTime(22 // Year
                                    //     );
                                    // String formattedDateTime =
                                    //     DateFormat('MMM d, y, hh:mm a')
                                    //         .format(dateTime);

                                    int timestampInSeconds = item.timestamp!;
                                    DateTime dateTime =
                                        DateTime.fromMillisecondsSinceEpoch(
                                            timestampInSeconds * 1000);

                                    String formattedDateTime =
                                        DateFormat('MMM d, y, hh:mm a')
                                            .format(dateTime);

                                    //   // Build your UI for each item in the list
                                    //   double payAmount = item.value! / 100;

                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 3),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: item.purpose ==
                                                          "FUND_WALLET"
                                                      ? const Color(0xff12BC42)
                                                      : item.purpose ==
                                                              "PAY_FOR_TICKET"
                                                          ? const Color(
                                                              0xff5856d6)
                                                          : Colors.red,
                                                ),
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                    item.purpose ==
                                                            "FUND_WALLET"
                                                        ? AppImages.receipt
                                                        : item.purpose ==
                                                                "PAY_FOR_TICKET"
                                                            ? AppImages
                                                                .profileEvent
                                                            : AppImages.receipt,
                                                    height: 25,
                                                    width: 25,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  customText(
                                                    text: item.purpose ==
                                                            "FUND_WALLET"
                                                        ? "Fund Wallet"
                                                        : item.purpose ==
                                                                "PAY_FOR_TICKET"
                                                            ? "Ticket Purchase"
                                                            : "Cash Out",
                                                    fontSize: 14,
                                                    textColor: AppColors.black,
                                                  ),
                                                  customText(
                                                    text: formattedDateTime,
                                                    fontSize: 10,
                                                    textColor:
                                                        AppColors.textGrey,
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  item.currency == "NGN"
                                                      ? customText(
                                                          text: "+₦$payAmount",
                                                          fontSize: 12,
                                                          textColor:
                                                              AppColors.black,
                                                        )
                                                      : customText(
                                                          text: "+\$$payAmount",
                                                          fontSize: 12,
                                                          textColor:
                                                              AppColors.black,
                                                        ),
                                                  heightSpace(0.5),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: item.status ==
                                                              "STARTED"
                                                          ? Colors.orange
                                                              .withOpacity(0.15)
                                                          : item.status ==
                                                                  "PAID"
                                                              ? const Color(
                                                                      0xff12BC42)
                                                                  .withOpacity(
                                                                      0.15)
                                                              : Colors.red
                                                                  .withOpacity(
                                                                      0.15),
                                                    ),
                                                    child: customText(
                                                      text: item.status!,
                                                      fontSize: 10,
                                                      textColor:
                                                          AppColors.black,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        heightSpace(5),
                        customText(
                            text: "Enter Amount",
                            fontSize: 14,
                            textColor: AppColors.black),
                        heightSpace(2),
                        SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IntrinsicWidth(
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.sora(
                                      color: AppColors.primary,
                                      fontSize: height * 0.05,
                                      fontWeight: FontWeight.w700),
                                  controller: amountController,
                                  decoration: InputDecoration(
                                    prefixIcon: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.iconGrey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: PAD_ALL_15,
                                      child: SvgPicture.asset(
                                        _isBlueContainerVisible == false
                                            ? AppImages.niaraWallett
                                            : AppImages.dollerWallett,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        heightSpace(3),
                        ChasescrollButton(
                          buttonText: "Widthdraw",
                          onTap: () async {
                            log(amountController.text);
                            log(balance.toString());
                            double amount = double.parse(amountController.text);
                            if (_isBlueContainerVisible == false) {
                              if (paystackCheckAccount.value == false) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SetupAccountPaystackView(),
                                  ),
                                );
                              } else {
                                if ((balance / 100) < amount) {
                                  ToastResp.toastMsgError(
                                      resp: "Low Naira Balance");
                                } else {
                                  final result =
                                      await _walletRepository.withdrawWallet(
                                    amount: double.parse(amountController.text),
                                    currency: "NGN",
                                  );

                                  if (result) {
                                    ToastResp.toastMsgSuccess(
                                        resp:
                                            "Withdrawal from naira account successful");
                                  } else {
                                    ToastResp.toastMsgError(
                                        resp:
                                            "Withdrawal from naira account not successful");
                                  }
                                }
                              }
                            }
                            // bool result =
                            //     await _walletRepository.getAccountStatus();

                            // if (result) {
                            //   ToastResp.toastMsgError(
                            //       resp:
                            //           "you dont have an withdrawal account yet. kindly Setup when redirected");

                            // } else {
                            //   ToastResp.toastMsgSuccess(resp: "");
                            // }
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        heightSpace(5),
                        customText(
                            text: "Enter Amount",
                            fontSize: 14,
                            textColor: AppColors.black),
                        heightSpace(2),
                        SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IntrinsicWidth(
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.sora(
                                      color: AppColors.primary,
                                      fontSize: height * 0.05,
                                      fontWeight: FontWeight.w700),
                                  controller: amountController,
                                  decoration: InputDecoration(
                                    prefixIcon: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.iconGrey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: PAD_ALL_15,
                                      child: SvgPicture.asset(
                                        _isBlueContainerVisible == false
                                            ? AppImages.niaraWallett
                                            : AppImages.dollerWallett,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        heightSpace(3),
                        ChasescrollButton(
                          buttonText: "Fund Account",
                          onTap: () {
                            _isBlueContainerVisible == false
                                ? fundWalletNGN()
                                : fundWalletUSD();
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void checkAccountStatus() async {
  //   await _walletRepository.getNairaBalance();
  // }

  void checkAccountStatusPaystack() async {
    // await context.read<WalletProvider>().checkAccountStatusPayStack();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    walletUSDBalance();
    walletNGNBalance();
    checkAccountStatusPaystack();
  }

  Container nairaContainer() {
    final balance =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.balanceNaira);
    return Container(
      height: 80,
      width: 160,
      decoration: BoxDecoration(
        color: const Color(0xff061AAD),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customText(
            text: "Naira Wallet Balance",
            fontSize: 12,
            textColor: AppColors.white,
            fontWeight: FontWeight.w500,
          ),
          heightSpace(0.3),
          customText(
            text: "₦${(balance) / 100}",
            fontSize: 18,
            textColor: AppColors.white,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  void registerStripe() async {
    // final status = await context.read<WalletProvider>().registerpaymentStripe();
    // if (status['checkout'] != null) {
    //   Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (context) => OAuthWebview(webUrl: status['checkout']),
    //     ),
    //   );
    // }
  }

  Container usdContainer() {
    final balance =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.balanceUSD);
    return Container(
      height: 80,
      width: 160,
      decoration: BoxDecoration(
        color: const Color(0xff061AAD),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customText(
            text: "USD Wallet Balance",
            fontSize: 12,
            textColor: AppColors.white,
            fontWeight: FontWeight.w500,
          ),
          heightSpace(0.3),
          customText(
            text: "\$${(balance) / 100}",
            fontSize: 18,
            textColor: AppColors.white,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  void walletNGNBalance() async {
    await _walletRepository.getNairaBalance();
  }

  void walletUSDBalance() async {
    await _walletRepository.getUsdBalance();
  }
}

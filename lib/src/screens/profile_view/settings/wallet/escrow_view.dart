import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/models/escrow_model.dart';
import 'package:chases_scroll/src/repositories/wallet_repository.dart';
import 'package:chases_scroll/src/screens/widgets/custom_fonts.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class EscrowView extends StatefulHookWidget {
  final PageController pageController;

  final int pageIndex;
  const EscrowView({
    Key? key,
    required this.pageController,
    required this.pageIndex,
  }) : super(key: key);

  @override
  State<EscrowView> createState() => _EscrowViewState();
}

class PayableAmount {
  String? currency;
  int? amount;
  int? multiplier;

  PayableAmount({this.currency, this.amount, this.multiplier});

  PayableAmount.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    amount = json['amount'] as int?;
    multiplier = json['multiplier'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency'] = currency;
    data['amount'] = amount;
    data['multiplier'] = multiplier;
    return data;
  }

  @override
  String toString() {
    return 'PayableAmount { '
        'currency: $currency, '
        'amount: $amount, '
        'multiplier: $multiplier'
        ' }';
  }
}

class _EscrowViewState extends State<EscrowView> {
  bool _isBlueContainerVisible = true;

  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  List<String> myListDays = [
    "All",
  ];

  String myListDaysValue = 'All';

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   walletUSDBalance();
  //   walletNGNBalance();
  // }
  //for page controller and pageview
  bool sold = true;
  bool escrow = false;

  bool cancel = false;

  final WalletRepository _walletRepository = WalletRepository();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    //this is for inEscrow
    final inEscrowLoading = useState<bool>(true);
    final inEscrowModel = useState<List<EscrowModel>>([]);

    getInEscrow() {
      _walletRepository.getInEscrow().then((value) {
        inEscrowLoading.value = false;
        inEscrowModel.value = value;
      });
    }

    //this is for finilized
    final finalizedEscrowLoading = useState<bool>(true);
    final finalizedEscrowModel = useState<List<EscrowModel>>([]);

    getFinalizedEscrow() {
      _walletRepository.getInFinalized().then((value) {
        finalizedEscrowLoading.value = false;
        finalizedEscrowModel.value = value;
      });
    }

    //this is for completed
    final completedEscrowLoading = useState<bool>(true);
    final completedEscrowModel = useState<List<EscrowModel>>([]);

    getCompletedEscrow() {
      _walletRepository.getEscrowRefundCompleted().then((value) {
        completedEscrowLoading.value = false;
        completedEscrowModel.value = value;
      });
    }

    useEffect(() {
      getInEscrow();
      getFinalizedEscrow();
      getCompletedEscrow();
      return null;
    }, []);

    return Container(
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
                                textColor: AppColors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.pageController.animateToPage(
                                0, // convert int to double
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
                                  text: "< Wallet",
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
                            onChanged: (value) {
                              setState(() {
                                _isBlueContainerVisible = value;
                                print(_isBlueContainerVisible);
                              });
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
                height: height / 14,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: AppColors.deepPrimary,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            soldValue();
                            // animate the page controller to the selected page
                            _pageController.animateToPage(
                              0, // convert int to double
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color:
                                  sold ? AppColors.deepPrimary : Colors.white,
                            ),
                            child: Center(
                              child: customText(
                                text: "Sold",
                                fontSize: 12,
                                textColor:
                                    sold ? Colors.white : AppColors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      heightSpace(0.5),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            escrowValue();
                            // animate the page controller to the selected page
                            _pageController.animateToPage(
                              1, // convert int to double
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:
                                  escrow ? AppColors.deepPrimary : Colors.white,
                            ),
                            child: Center(
                              child: customText(
                                text: "In Escrow",
                                fontSize: 12,
                                textColor:
                                    escrow ? Colors.white : AppColors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      widthSpace(0.5),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            cancelValue();
                            // animate the page controller to the selected page
                            _pageController.animateToPage(
                              2, // convert int to double
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:
                                  cancel ? AppColors.deepPrimary : Colors.white,
                            ),
                            child: Center(
                              child: customText(
                                text: "cancelled",
                                fontSize: 14,
                                textColor:
                                    cancel ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.w700,
                              ),
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
          //pageview container
          Expanded(
            child: PageView(
              onPageChanged: (index) {
                // update the current page index when the page is changed
                setState(() {
                  _currentPageIndex = index;
                });
              },
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: PAD_ALL_10,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            height: height,
                            width: width,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35),
                              ),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: ListView.builder(
                                      itemCount:
                                          finalizedEscrowModel.value.length,
                                      itemBuilder: (context, index) {
                                        final item =
                                            finalizedEscrowModel.value[index];
                                        if (item.timeOfOrder != null) {
                                          dynamic timestamp = item.timeOfOrder;

                                          DateTime dateTime = DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  timestamp! * 1000);

                                          String formattedDateTime =
                                              DateFormat('MMM d, y, hh:mm a')
                                                  .format(dateTime);

                                          // Build your UI for each item in the list

                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 15, 0, 3),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 50,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: const Color(
                                                            0xff12BC42),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: SvgPicture.asset(
                                                          AppImages
                                                              .profileEvent,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 15,
                                                          width: width / 2,
                                                          child: customText(
                                                            text:
                                                                "${item.escrowStatus}",
                                                            fontSize: 12,
                                                            textColor:
                                                                AppColors.black,
                                                          ),
                                                        ),
                                                        heightSpace(0.5),
                                                        customText(
                                                            text:
                                                                formattedDateTime,
                                                            fontSize: 12,
                                                            textColor:
                                                                AppColors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        item.currency == "NGN"
                                                            ? customText(
                                                                text:
                                                                    "NGN${item.payableAmount!.amount}",
                                                                fontSize: 12,
                                                                textColor:
                                                                    AppColors
                                                                        .black,
                                                              )
                                                            : customText(
                                                                text:
                                                                    "\$${item.payableAmount!.amount}",
                                                                fontSize: 12,
                                                                textColor:
                                                                    AppColors
                                                                        .black,
                                                              ),
                                                        heightSpace(1),
                                                        customText(
                                                          text: "Sold",
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          textColor:
                                                              const Color(
                                                                  0xff12BC42),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        } else {
                                          return const SizedBox();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: PAD_ALL_10,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            child: ListView.builder(
                              itemCount: inEscrowModel.value.length,
                              itemBuilder: (context, index) {
                                final item = inEscrowModel.value[index];
                                dynamic timestamp = item.timeOfOrder;

                                DateTime dateTime =
                                    DateTime.fromMillisecondsSinceEpoch(
                                        timestamp! * 1000);

                                String formattedDateTime =
                                    DateFormat('MMM d, y, hh:mm a')
                                        .format(dateTime);

                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: AppColors.primary,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: SvgPicture.asset(
                                                AppImages.profileEvent,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 15,
                                                width: width / 2,
                                                child: customText(
                                                  text: "${item.escrowStatus}",
                                                  fontSize: 12,
                                                  textColor: AppColors.black,
                                                ),
                                              ),
                                              heightSpace(0.5),
                                              customText(
                                                  text: formattedDateTime,
                                                  fontSize: 12,
                                                  textColor: AppColors.black,
                                                  fontWeight: FontWeight.w400),
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
                                                      text:
                                                          "NGN${item.payableAmount!.amount}",
                                                      fontSize: 12,
                                                      textColor:
                                                          AppColors.black,
                                                    )
                                                  : customText(
                                                      text:
                                                          "\$${item.payableAmount!.amount}",
                                                      fontSize: 12,
                                                      textColor:
                                                          AppColors.black,
                                                    ),
                                              heightSpace(1),
                                              customText(
                                                text: "Pending",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                textColor: AppColors.primary,
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
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: PAD_ALL_10,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            height: height,
                            width: width,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: ListView.builder(
                                        itemCount:
                                            completedEscrowModel.value.length,
                                        itemBuilder: (context, index) {
                                          final item =
                                              completedEscrowModel.value[index];

                                          dynamic timestamp = item.timeOfOrder;
                                          DateTime dateTime = DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  timestamp! * 1000);
                                          String formattedDateTime =
                                              DateFormat('MMM d, y, hh:mm a')
                                                  .format(dateTime);
                                          // Build your UI for each item in the list

                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 15, 0, 3),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 50,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: AppColors.red
                                                            .withOpacity(0.5),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: SvgPicture.asset(
                                                          AppImages
                                                              .profileEvent,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 15,
                                                          width: width / 2,
                                                          child: customText(
                                                            text:
                                                                "${item.escrowStatus}",
                                                            fontSize: 12,
                                                            textColor:
                                                                AppColors.black,
                                                          ),
                                                        ),
                                                        heightSpace(0.5),
                                                        customText(
                                                            text:
                                                                formattedDateTime,
                                                            fontSize: 12,
                                                            textColor:
                                                                AppColors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        item.currency == "NGN"
                                                            ? customText(
                                                                text:
                                                                    "NGN${item.payableAmount!.amount}",
                                                                fontSize: 12,
                                                                textColor:
                                                                    AppColors
                                                                        .black,
                                                              )
                                                            : customText(
                                                                text:
                                                                    "\$${item.payableAmount!.amount}",
                                                                fontSize: 12,
                                                                textColor:
                                                                    AppColors
                                                                        .black,
                                                              ),
                                                        heightSpace(1),
                                                        customText(
                                                          text: "Cancelled",
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          textColor: AppColors
                                                              .red
                                                              .withOpacity(0.5),
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
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void cancelValue() {
    setState(() {
      cancel = !cancel;
      sold = false;
      escrow = false;
    });
  }

  void checkAccountStatus() async {
    //await context.read<WalletProvider>().checkAccountStatus();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  void escrowValue() {
    setState(() {
      escrow = !escrow;
      sold = false;
      cancel = false;
    });
  }

  Container nairaContainer() {
    final escrowUSD =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.escrowNaira);
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
            text: "₦$escrowUSD",
            fontSize: 18,
            textColor: AppColors.white,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  void soldValue() {
    setState(() {
      sold = !sold;
      escrow = false;
      cancel = false;
    });
  }

  Container usdContainer() {
    final escrowUSD =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.ecrowUSD);
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
            text: "\$$escrowUSD",
            fontSize: 18,
            textColor: AppColors.white,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  void walletNGNBalance() async {
    // await context.read<WalletProvider>().getNGNBalance();
    // log(Prefs.getNGN().toString());
    // log(StorageUtil.getInt(key: 'saveEscrowBalanceNGN').toString());
  }

  void walletUSDBalance() async {
    //   await context.read<WalletProvider>().getUSDBalance();
    //   log(Prefs.getUSD().toString());
    //   log(StorageUtil.getInt(key: 'saveEscrowBalanceUSD').toString());
  }
}

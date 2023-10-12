import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:chases_scroll/src/utils/constants/dimens.dart';
import 'package:chases_scroll/src/utils/constants/helpers/strings.dart';
import 'package:chases_scroll/src/utils/constants/spacer.dart';
import 'package:flutter/material.dart';

class PaymentMethodScreenView extends StatefulWidget {
  const PaymentMethodScreenView({
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentMethodScreenView> createState() =>
      _PaymentMethodScreenViewState();
}

class _PaymentMethodScreenViewState extends State<PaymentMethodScreenView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                "assets/icons-pack/card.svg",
                () {},
              ),
              heightSpace(3),
              payMethodContainerGesture(
                "Pay With Wallet",
                "assets/icons-pack/wallet-2.svg",
                () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

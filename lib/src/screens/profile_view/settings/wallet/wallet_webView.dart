import 'package:chases_scroll/src/repositories/wallet_repository.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPaystackFundNGN extends StatefulWidget {
  final String? url;
  final String? urlTransactID;
  const PaymentPaystackFundNGN({
    Key? key,
    this.url,
    this.urlTransactID,
  }) : super(key: key);

  @override
  State<PaymentPaystackFundNGN> createState() => _PaymentPaystackFundNGNState();
}

//--------- FUND WALLET --------------------------------------------------------

class PaymentStripeFund extends StatefulWidget {
  final String? url;
  final String? urlTransactID;
  const PaymentStripeFund({
    Key? key,
    this.url,
    this.urlTransactID,
  }) : super(key: key);

  @override
  State<PaymentStripeFund> createState() => _PaymentStripeFundState();
}

class _PaymentPaystackFundNGNState extends State<PaymentPaystackFundNGN> {
  final WalletRepository _repository = WalletRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          zoomEnabled: true,
          gestureNavigationEnabled: true,
          initialUrl: widget.url,
          navigationDelegate: (NavigationRequest request) async {
            // if (request.url.startsWith("https://example.com/success")) {
            //  //verifyFundAccount();
            // }
            dynamic result = await _repository.verifyPaymentWellet(
                transactID: widget.urlTransactID);
            if (result['verification'] == "Transaction verification success") {
              ToastResp.toastMsgSuccess(resp: "Payment Verified");
              context.pop();
            } else {
              ToastResp.toastMsgSuccess(resp: "Payment Verification failed");
              context.pop();
            }
            //context.pop();
            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }

  verifyFundAccount() async {
    dynamic result =
        _repository.verifyPaymentWellet(transactID: widget.urlTransactID);
    if (result['verification'] == "Transaction verification success") {
      ToastResp.toastMsgSuccess(resp: "Payment Verified");
      context.pop();
    } else {
      ToastResp.toastMsgSuccess(resp: "Payment Verification failed");
    }
  }
}

class _PaymentStripeFundState extends State<PaymentStripeFund> {
  final WalletRepository _repository = WalletRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          zoomEnabled: true,
          gestureNavigationEnabled: true,
          initialUrl: widget.url,
          navigationDelegate: (NavigationRequest request) async {
            // if (request.url.startsWith("https://example.com/success")) {
            //   log("verifing");
            //   verifyFundAccount();
            //   log("verified");
            // }
            dynamic result = await _repository.verifyPaymentWellet(
                transactID: widget.urlTransactID);
            if (result['verification'] == "Transaction verification success") {
              ToastResp.toastMsgSuccess(resp: "Payment Verified");
              context.pop();
            } else {
              ToastResp.toastMsgSuccess(resp: "Payment Verification failed");
              context.pop();
            }
            return NavigationDecision
                .navigate; // Allow navigation to other URLs
          },
        ),
      ),
    );
  }

  verifyFundAccount() async {
    dynamic result =
        _repository.verifyPaymentWellet(transactID: widget.urlTransactID);
    if (result['verification'] == "Transaction verification success") {
      ToastResp.toastMsgSuccess(resp: "Payment Verified");
      context.pop();
    } else {
      ToastResp.toastMsgSuccess(resp: "Payment Verification failed");
    }
  }
}

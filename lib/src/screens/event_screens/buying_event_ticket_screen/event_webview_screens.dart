import 'dart:developer';

import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/screens/widgets/success_screen.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

final _router = locator<GoRouter>();

class PaymentPaystackView extends StatefulWidget {
  final String url;

  const PaymentPaystackView({Key? key, required this.url}) : super(key: key);

  @override
  State<PaymentPaystackView> createState() => _PaymentPaystackViewState();
}

//this is for stripe
class PaymentStripeView extends StatefulWidget {
  final String url;

  const PaymentStripeView({
    Key? key,
    required this.url,
  }) : super(key: key);
  @override
  State<PaymentStripeView> createState() => _PaymentStripeViewState();
}

class _PaymentPaystackViewState extends State<PaymentPaystackView> {
  final _key = UniqueKey();
  final EventRepository _eventRepository = EventRepository();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    print(widget.url);
    onVerify() async {
      final result = await _eventRepository.createWebUrlPayStack();
      if (result['verification'] == "Order verification success") {
        log("Payment Verified...await change sdnjsnkcskncsk");
        ToastResp.toastMsgSuccess(resp: result['verification']);
        onTapFreeSuccess();
      } else {
        ToastResp.toastMsgError(resp: result['verification']);
        _router.pop();
      }
    }

    //orderID
    String orderCode =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.orderCode);

    return Scaffold(
      body: SafeArea(
        child: WebView(
          key: _key,
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          zoomEnabled: true,
          gestureNavigationEnabled: true,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith(
                "https://chasescroll-new.netlify.app/payment/verification?orderCode=$orderCode")) {
              onVerify();
            }
            return NavigationDecision.navigate;
          },
          onPageFinished: (_) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      ),
    );
  }

  void onTapFreeSuccess() {
    context.push(
      AppRoutes.threeLoadingDotsScreen,
      extra: const EventSuccessScreenView(
        widgetScreenString: AppRoutes.refundBoughtDetailScreen,
      ),
    );
  }
}

class _PaymentStripeViewState extends State<PaymentStripeView> {
  final _key = UniqueKey();
  final EventRepository _eventRepository = EventRepository();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    //orderID
    String orderID =
        locator<LocalStorageService>().getDataFromDisk(AppKeys.orderID);
    return Scaffold(
      body: SafeArea(
        child: WebView(
          key: _key,
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          zoomEnabled: true,
          gestureNavigationEnabled: true,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith(
                "https://chasescroll-new.netlify.app/payment/verification?orderId=$orderID")) {
              onVerify();
            }
            return NavigationDecision.navigate;
          },
          onPageFinished: (_) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      ),
    );
  }

  void onTapFreeSuccess() {
    context.push(
      AppRoutes.threeLoadingDotsScreen,
      extra: const EventSuccessScreenView(
        widgetScreenString: AppRoutes.refundBoughtDetailScreen,
      ),
    );
  }

  onVerify() async {
    final result = await _eventRepository.createWebUrlStripe();
    if (result['verification'] == "Order verification success") {
      log("Payment Verified...await change sdnjsnkcskncsk");
      ToastResp.toastMsgSuccess(resp: result['verification']);
      onTapFreeSuccess();
    } else {
      ToastResp.toastMsgError(resp: result['verification']);
      _router.pop();
    }
  }
}

import 'dart:developer';

import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/repositories/event_repository.dart';
import 'package:chases_scroll/src/screens/widgets/success_screen.dart';
import 'package:chases_scroll/src/screens/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewEventStripe extends StatefulWidget {
  final String url;

  const WebViewEventStripe({super.key, required this.url});

  @override
  _WebViewEventStripeState createState() => _WebViewEventStripeState();
}

// class PaymentPaystackView extends StatefulWidget {
//   final String url;

//   const PaymentPaystackView({Key? key, required this.url}) : super(key: key);

//   @override
//   State<PaymentPaystackView> createState() => _PaymentPaystackViewState();
// }

// //this is for stripe
// class PaymentStripeView extends StatefulWidget {
//   final String url;

//   const PaymentStripeView({
//     Key? key,
//     required this.url,
//   }) : super(key: key);
//   @override
//   State<PaymentStripeView> createState() => _PaymentStripeViewState();
// }

// class _PaymentPaystackViewState extends State<PaymentPaystackView> {
//   final _key = UniqueKey();
//   final EventRepository _eventRepository = EventRepository();
//   final bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: WebView(
//           key: _key,
//           initialUrl: widget.url,
//           javascriptMode: JavascriptMode.unrestricted,
//           zoomEnabled: true,
//           gestureNavigationEnabled: true,
//           navigationDelegate: (NavigationRequest request) async {
//             // dynamic result = await _eventRepository.createWebUrlPayStack();
//             // if (result['verification'] == "Order verification success") {
//             //   log("Payment Verified...await change sdnjsnkcskncsk");
//             //   ToastResp.toastMsgSuccess(resp: result['verification']);
//             //   onTapFreeSuccess();
//             // } else {
//             //   ToastResp.toastMsgError(resp: result['verification']);
//             //   _router.pop();
//             // }
//             return NavigationDecision.navigate;
//           },
//         ),
//       ),
//     );
//   }

//   void onTapFreeSuccess() {
//     context.push(
//       AppRoutes.threeLoadingDotsScreen,
//       extra: const EventSuccessScreenView(
//         widgetScreenString: AppRoutes.refundBoughtDetailScreen,
//       ),
//     );
//   }
// }

// class _PaymentStripeViewState extends State<PaymentStripeView> {
//   final _key = UniqueKey();
//   final EventRepository _eventRepository = EventRepository();

//   final bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     //orderID

//     return Scaffold(
//       body: SafeArea(
//         child: WebView(
//           key: _key,
//           initialUrl: widget.url,
//           javascriptMode: JavascriptMode.unrestricted,
//           zoomEnabled: true,
//           gestureNavigationEnabled: true,
//           navigationDelegate: (NavigationRequest request) async {
//             final result = await _eventRepository.createWebUrlStripe();
//             if (result['verification'] == "Order verification success") {
//               log("Payment Verified...await change sdnjsnkcskncsk");
//               ToastResp.toastMsgSuccess(resp: result['verification']);
//               onTapFreeSuccess();
//             } else {
//               ToastResp.toastMsgError(resp: result['verification']);
//               //_router.pop();
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       ),
//     );
//   }

//   void onTapFreeSuccess() {
//     context.push(
//       AppRoutes.threeLoadingDotsScreen,
//       extra: const EventSuccessScreenView(
//         widgetScreenString: AppRoutes.refundBoughtDetailScreen,
//       ),
//     );
//   }
// }

class WebViewPaystack extends StatefulWidget {
  final String url;

  const WebViewPaystack({super.key, required this.url});

  @override
  _WebViewPaystackState createState() => _WebViewPaystackState();
}

class _WebViewEventStripeState extends State<WebViewEventStripe> {
  bool _isLoading = true;
  final EventRepository _eventRepository = EventRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [
              WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                zoomEnabled: true,
                gestureNavigationEnabled: true,
                navigationDelegate: (NavigationRequest request) async {
                  if (request.url.startsWith(
                      "https://chasescroll-new.netlify.app/payment/verification?orderId=")) {
                    dynamic result =
                        await _eventRepository.verifyEventPaymentStripe();
                    if (result['verification'] ==
                        "Order verification success") {
                      log("Payment Verified...await change sdnjsnkcskncsk");
                      ToastResp.toastMsgSuccess(resp: result['verification']);
                      context.push(
                        AppRoutes.threeLoadingDotsScreen,
                        extra: const EventSuccessScreenView(
                          widgetScreenString:
                              AppRoutes.refundBoughtDetailScreen,
                        ),
                      );
                    } else {
                      ToastResp.toastMsgError(resp: result['verification']);
                      context.pop();
                    }
                  }

                  // Allow navigation to continue
                  return NavigationDecision.navigate;
                },
                onPageFinished: (String url) async {
                  setState(() {
                    _isLoading = false;
                  });

                  // Perform your action based on the finished page load
                  dynamic result =
                      await _eventRepository.verifyEventPaymentStripe();
                  if (result['verification'] == "Order verification success") {
                    log("Payment Verified...await change sdnjsnkcskncsk");
                    ToastResp.toastMsgSuccess(resp: result['verification']);
                    context.push(
                      AppRoutes.threeLoadingDotsScreen,
                      extra: const EventSuccessScreenView(
                        widgetScreenString: AppRoutes.refundBoughtDetailScreen,
                      ),
                    );
                  } else {
                    // ToastResp.toastMsgError(resp: result['verification']);
                    context.pop();
                  }
                },
              ),
              if (_isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WebViewPaystackState extends State<WebViewPaystack> {
  bool _isLoading = true;
  final EventRepository _eventRepository = EventRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [
              WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                zoomEnabled: true,
                gestureNavigationEnabled: true,
                navigationDelegate: (NavigationRequest request) async {
                  if (request.url.startsWith(
                      "https://chasescroll-new.netlify.app/payment/verification?orderCode=")) {
                    dynamic result =
                        await _eventRepository.verifyEventPaymentPaystack();
                    if (result['verification'] ==
                        "Order verification success") {
                      log("Payment Verified...await change sdnjsnkcskncsk");
                      ToastResp.toastMsgSuccess(resp: result['verification']);
                      context.push(
                        AppRoutes.threeLoadingDotsScreen,
                        extra: const EventSuccessScreenView(
                          widgetScreenString:
                              AppRoutes.refundBoughtDetailScreen,
                        ),
                      );
                    } else {
                      ToastResp.toastMsgError(resp: result['verification']);
                      context.pop();
                    }
                  }
                  return NavigationDecision.navigate;
                },
                onPageFinished: (_) {
                  setState(() {
                    _isLoading = false;
                  });
                },
              ),
              if (_isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

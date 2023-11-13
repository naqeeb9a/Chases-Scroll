import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndConditionScreenView extends StatefulWidget {
  const TermsAndConditionScreenView({
    super.key,
  });

  @override
  _TermsAndConditionScreenViewState createState() =>
      _TermsAndConditionScreenViewState();
}

class _TermsAndConditionScreenViewState
    extends State<TermsAndConditionScreenView> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Privacy Policy"),
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              initialUrl: "https://chasescroll.com/terms",
              javascriptMode: JavascriptMode.unrestricted,
              zoomEnabled: true,
              gestureNavigationEnabled: true,
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
    );
  }
}

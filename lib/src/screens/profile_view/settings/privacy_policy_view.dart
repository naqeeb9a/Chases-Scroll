import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreenView extends StatefulWidget {
  const PrivacyPolicyScreenView({
    super.key,
  });

  @override
  _PrivacyPolicyScreenViewState createState() =>
      _PrivacyPolicyScreenViewState();
}

class _PrivacyPolicyScreenViewState extends State<PrivacyPolicyScreenView> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Privacy Policy"),
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              initialUrl: "https://chasescroll.com/privacy-poilcy",
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

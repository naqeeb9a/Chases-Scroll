import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class AppHelper {
  static GlobalKey<NavigatorState>? _navigatorKey;
  static BuildContext? overlayContext;
  static set setNavigatorKey(GlobalKey<NavigatorState> key) {
    _navigatorKey = key;
  }

  AppHelper._();
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;
  static BuildContext? getContext() {
    return _navigatorKey?.currentState?.context;
  }

  static void showOverlayLoader() {
    showOverlay(
      (context, t) {
        overlayContext = context;
        return Container(
          color:
              Color.lerp(Colors.transparent, Colors.black.withOpacity(0.9), t),
          child: FractionalTranslation(
            translation:
                Offset.lerp(const Offset(0, -1), const Offset(0, 0), t)!,
            child: const Center(child: CircularProgressIndicator()),
          ),
        );
      },
      duration: Duration.zero,
    );
  }
}

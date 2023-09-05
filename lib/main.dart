import 'package:chases_scroll/src/config/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  await setUpLocator();
  runApp(ProviderScope(child: Chasescroll()));
}

class Chasescroll extends StatelessWidget {
  final _router = locator<GoRouter>();
  Chasescroll({super.key});
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: FlutterSizer(builder: (context, orientation, screenType) {
        return MaterialApp.router(
          routerConfig: _router,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
        );
      }),
    );
  }
}

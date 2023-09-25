import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/config/router/routes.dart';
import 'package:chases_scroll/src/services/storage_service.dart';
import 'package:chases_scroll/src/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _animation;
  final storage = locator<LocalStorageService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _animation!,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation!.value / 0.9,
              child: child,
            );
          },
          child: Image.asset(AppImages.logo),
        ),
      ),
    );
  }

  checkForOnBoarding() {
    bool firstInstall = storage.getDataFromDisk(AppKeys.firstInstall) ?? true;

    if (firstInstall) {
      context.push(AppRoutes.onboarding);
      return;
    }
    // checkForLogin();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _animateLogo();
  }

  void _animateLogo() async {
    await Future.delayed(const Duration(seconds: 0));
    _controller.forward().then(
          (value) => _controller.reverse().then((value) => _controller
              .forward()
              .then((value) => _controller.reverse().then((value) => _controller
                  .forward()
                  .then((value) => context.push(AppRoutes.emailScreen))))),
        );
  }
}

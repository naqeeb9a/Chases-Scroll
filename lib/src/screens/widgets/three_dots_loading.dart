import 'package:chases_scroll/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ThreeLoadingDotsScreen extends StatefulWidget {
  final Widget? screen;

  const ThreeLoadingDotsScreen({Key? key, this.screen}) : super(key: key);

  @override
  State<ThreeLoadingDotsScreen> createState() => _ThreeLoadingDotsScreenState();
}

class _ThreeLoadingDotsScreenState extends State<ThreeLoadingDotsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitThreeBounce(
          color: AppColors.deepPrimary,
          size: 50.0,
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget.screen!;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
        ),
      );
    });
  }
}

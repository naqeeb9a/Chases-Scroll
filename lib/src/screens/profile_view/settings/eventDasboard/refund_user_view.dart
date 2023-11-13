import 'package:chases_scroll/src/screens/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RefundUserView extends HookWidget {
  const RefundUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Refund User"),
    );
  }
}

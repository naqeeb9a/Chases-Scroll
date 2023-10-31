import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UserMainProfileViewe extends HookWidget {
  const UserMainProfileViewe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.green,
      )),
    );
  }
}

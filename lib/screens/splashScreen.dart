import 'dart:async';

import 'package:dendy_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigationLoginPage() {
    Get.offAllNamed(RouteConstant.welcomeScreen);
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), navigationLoginPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        '${baseImagePath}splash.png',
        fit: BoxFit.cover,
        height: Utils.height,
        width: Utils.width,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/app/pages/splash/controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        height: Get.height,
        width: Get.width,
      ),
    );
  }
}

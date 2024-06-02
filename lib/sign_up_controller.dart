import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    animationController.forward();

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToLogin();
      }
    });
  }

  void _navigateToLogin() async {
    await Future.delayed(Duration(seconds: 1));
    Get.offNamed('/login'); // Use Get.offNamed for named routes
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}

import 'package:contoh_ulangan_gw/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isValidEmail(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    // Add your password strength criteria here, for example, minimum length
    return password.length >= 8;
  }

  void signUp() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (!isValidEmail(email)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email address.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!isValidPassword(password)) {
      Get.snackbar(
        'Error',
        'Password must be at least 8 characters long.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Proceed with sign up logic
  }

  void goToLogin() {
    Get.off(LoginPage());
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

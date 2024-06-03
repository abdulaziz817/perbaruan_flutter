import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'schedule_page.dart';
import 'sign_up_view.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart'; // tambahkan ini

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void login() {
    if (formKey.currentState?.validate() ?? false) {
      Get.to(() => SchedulePage());
    } else {
      Get.snackbar('Error', 'Validation failed', snackPosition: SnackPosition.BOTTOM);
    }
  }

  void launchEmailApp() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'abdulaziizz817@gmail.com',
      queryParameters: {
        'subject': 'Login Request',
        'body': 'I want to login using this email.',
      },
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      Get.snackbar('Error', 'Could not launch email app', snackPosition: SnackPosition.BOTTOM);
    }
  }

  void chooseGoogleAccount() async {
    // Logika untuk memilih akun Google
    // Bisa menggunakan package seperti google_sign_in atau googleapis
    // Untuk demonstrasi, menggunakan print statement
    print('Google account selection goes here');
  }

  void goToSignUp() {
    Get.to(() => SignUpPage());
  }
}

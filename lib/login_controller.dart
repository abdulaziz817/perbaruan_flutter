import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'schedule_page.dart';
import 'sign_up_view.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void login() {
    if (formKey.currentState?.validate() ?? false) {
      Get.to(() => SchedulePage());
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
      throw 'Could not launch email app';
    }
  }

  void goToSignUp() {
    Get.to(() => SignUpPage());
  }
}

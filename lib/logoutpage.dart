import 'package:contoh_ulangan_gw/logout_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get/get.dart';

class LogoutPage extends StatelessWidget {
  final LogoutController _controller = Get.put(LogoutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'See You Again!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 32),
              AnimatedButton(
                onPress: () {
                  _controller.logout();
                },
                height: 60,
                width: double.infinity,
                text: 'Logout',
                isReverse: true,
                selectedTextColor: Colors.indigo,
                transitionType: TransitionType.LEFT_CENTER_ROUNDER,
                backgroundColor: Colors.indigo,
                borderColor: Colors.indigo,
                borderRadius: 12,
                borderWidth: 2,
              ),
              SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

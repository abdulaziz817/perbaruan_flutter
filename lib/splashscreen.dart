import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'splash_controller.dart';

class SplashScreen extends StatelessWidget {
  final SplashController _controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _controller.animation,
              child: FadeTransition(
                opacity: _controller.animation,
                child: Icon(
                  Icons.school, // Change icon here
                  size: 100,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'Absen Online',
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  speed: Duration(milliseconds: 150),
                ),
              ],
              totalRepeatCount: 1,
            ),
            SizedBox(height: 10),
            SpinKitWave(
              color: Colors.white,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}

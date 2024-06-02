import 'package:contoh_ulangan_gw/admin.dart';
import 'package:contoh_ulangan_gw/login_view.dart';
import 'package:contoh_ulangan_gw/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'qr_scanner_page.dart';
import 'splashscreen.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => SplashScreen(), binding: SplashBinding()),
      GetPage(name: '/login', page: () => LoginPage()), // Define the login route
      // Add more routes here as needed
    ],
  ));
}


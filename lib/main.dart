import 'package:contoh_ulangan_gw/admin.dart';
import 'package:contoh_ulangan_gw/logoutpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_view.dart';
import 'schedule_page.dart';
import 'qr_scanner_page.dart';

import 'splashscreen.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => SplashScreen()),
      GetPage(name: '/login', page: () => LoginPage()),
      GetPage(name: '/admin', page: () => AdminPage()),
      GetPage(name: '/schedule', page: () => SchedulePage()),
      GetPage(name: '/logout', page: () => LogoutPage()),
      GetPage(name: '/qr-scanner', page: () => QRScannerPage()),
    ],
  ));
}

import 'package:contoh_ulangan_gw/login_view.dart';
import 'package:flutter/material.dart';
// Uncomment the following lines if you are using GetX for state management and routing
// import 'package:get/get.dart';
// import 'package:your_project_name/controllers/auth_controller.dart';
// import 'package:your_project_name/routes/app_pages.dart';
import 'schedule_page.dart';
import 'sign_up_view.dart';
import 'admin.dart';
import 'splashscreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        
      ),
      home: SplashScreen(),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleController extends GetxController {
  var schedules = [
    {"time": "08:00 AM", "status": "Absent", "details": "Math Class"},
    {"time": "09:00 AM", "status": "Present", "details": "Science Class"},
    {"time": "10:00 AM", "status": "Late", "details": "History Class"},
    {"time": "11:00 AM", "status": "Present", "details": "Geography Class"},
    {"time": "01:00 PM", "status": "Absent", "details": "Physical Education"},
    {"time": "02:00 PM", "status": "Present", "details": "Art Class"},
  ].obs;

  var searchQuery = ''.obs;

  List<Map<String, dynamic>> get filteredSchedules => schedules.where((schedule) {
    return schedule["details"]!.toLowerCase().contains(searchQuery.value.toLowerCase());
  }).toList();

  void scanAttendance() {
    Get.dialog(
      AlertDialog(
        title: Text('Scan Attendance'),
        content: Text('Attendance scanned successfully.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

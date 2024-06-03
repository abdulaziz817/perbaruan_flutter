import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Schedule {
  String id;
  String title;
  DateTime dateTime;

  Schedule({required this.id, required this.title, required this.dateTime});
}

class AdminController extends GetxController {
  var schedules = <Schedule>[].obs;

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  var selectedDateTime = Rx<DateTime?>(null);

  void createOrUpdateSchedule({Schedule? existingSchedule}) {
    if (formKey.currentState!.validate()) {
      if (selectedDateTime.value != null) {
        if (existingSchedule == null) {
          final newSchedule = Schedule(
            id: Uuid().v4(),
            title: titleController.text,
            dateTime: selectedDateTime.value!,
          );
          schedules.add(newSchedule);
        } else {
          existingSchedule.title = titleController.text;
          existingSchedule.dateTime = selectedDateTime.value!;
          schedules.refresh();
        }

        titleController.clear();
        selectedDateTime.value = null;
        Get.back();
      } else {
        Fluttertoast.showToast(msg: 'Please select a date and time');
      }
    }
  }

  void showScheduleForm({Schedule? schedule}) {
    if (schedule != null) {
      titleController.text = schedule.title;
      selectedDateTime.value = schedule.dateTime;
    } else {
      titleController.clear();
      selectedDateTime.value = null;
    }

    Get.defaultDialog(
      title: schedule == null ? 'Create Schedule' : 'Edit Schedule',
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final newDateTime = await showDatePicker(
                  context: Get.context!,
                  initialDate: selectedDateTime.value ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (newDateTime != null) {
                  final time = await showTimePicker(
                    context: Get.context!,
                    initialTime: TimeOfDay.fromDateTime(selectedDateTime.value ?? DateTime.now()),
                  );
                  if (time != null) {
                    selectedDateTime.value = DateTime(
                      newDateTime.year,
                      newDateTime.month,
                      newDateTime.day,
                      time.hour,
                      time.minute,
                    );
                  }
                }
              },
              child: Obx(() => Text(
                  selectedDateTime.value == null
                      ? 'Select Date and Time'
                      : '${selectedDateTime.value!.toLocal()}'.split(' ')[0],
                ),
              ),
            ),
          ],
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () => createOrUpdateSchedule(existingSchedule: schedule),
        child: Text(schedule == null ? 'Create' : 'Update'),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back();
          titleController.clear();
          selectedDateTime.value = null;
        },
        child: Text('Cancel'),
      ),
    );
  }

  void showQRCode(Schedule schedule) {
    Get.defaultDialog(
      title: 'QR Code for ${schedule.title}',
      content: SizedBox(
        width: Get.width,
        height: Get.height * 0.4,
        child: QrImageView(
          data: schedule.id,
          version: QrVersions.auto,
        ),
      ),
      confirm: TextButton(
        onPressed: () => Get.back(),
        child: Text('Close'),
      ),
    );
  }

  void scanQRCode() async {
    final scannedData = await Get.toNamed('/qr-scanner');
    if (scannedData != null) {
      final scannedSchedule = schedules.firstWhere(
        (schedule) => schedule.id == scannedData,
        orElse: () => Schedule(id: '', title: 'Not Found', dateTime: DateTime.now()),
      );
      Fluttertoast.showToast(msg: 'Scanned Schedule: ${scannedSchedule.title}');
    }
  }

  void logout() {
    Get.offAllNamed('/login');
  }
}

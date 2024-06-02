// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:uuid/uuid.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class Schedule {
//   String id;
//   String title;
//   DateTime dateTime;

//   Schedule({required this.id, required this.title, required this.dateTime});
// }

// class AdminController extends GetxController {
//   var schedules = <Schedule>[].obs;

//   final formKey = GlobalKey<FormState>();
//   final titleController = TextEditingController();
//   var selectedDateTime = Rx<DateTime?>(null);

//   void createOrUpdateSchedule({Schedule? existingSchedule}) {
//     if (formKey.currentState!.validate()) {
//       if (selectedDateTime.value != null) {
//         if (existingSchedule == null) {
//           // Create new schedule
//           final newSchedule = Schedule(
//             id: Uuid().v4(),
//             title: titleController.text,
//             dateTime: selectedDateTime.value!,
//           );
//           schedules.add(newSchedule);
//         } else {
//           // Update existing schedule
//           existingSchedule.title = titleController.text;
//           existingSchedule.dateTime = selectedDateTime.value!;
//         }

//         titleController.clear();
//         selectedDateTime.value = null;
//         Get.back();
//       } else {
//         Fluttertoast.showToast(msg: 'Please select a date and time');
//       }
//     }
//   }

//   void showScheduleForm({Schedule? schedule}) {
//     if (schedule != null) {
//       titleController.text = schedule.title;
//       selectedDateTime.value = schedule.dateTime;
//     }

//     Get.defaultDialog(
//       title: schedule == null ? 'Create Schedule' : 'Edit Schedule',
//       content: Form(
//         key: formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextFormField(
//               controller: titleController,
//               decoration: InputDecoration(labelText: 'Title'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter a title';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () async {
//                 final newDateTime = await Get.defaultDialog<DateTime>(
//                   title: 'Select Date and Time',
//                   content: SizedBox(
//                     width: Get.width,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Expanded(
//                           child: SizedBox(
//                             height: Get.height * 0.4,
//                             child: CalendarDatePicker(
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(2000),
//                               lastDate: DateTime(2101),
//                               onDateChanged: (date) async {
//                                 final time = await showTimePicker(
//                                   context: Get.overlayContext!,
//                                   initialTime: TimeOfDay.fromDateTime(DateTime.now()),
//                                 );
//                                 if (time != null) {
//                                   Get.back(result: DateTime(date.year, date.month, date.day, time.hour, time.minute));
//                                 }
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//                 if (newDateTime != null) {
//                   selectedDateTime.value = newDateTime;
//                 }
//               },
//               child: Obx(() => Text(selectedDateTime.value == null
//                   ? 'Select Date and Time'
//                   : '${selectedDateTime.value!.toLocal()}'.split(' ')[0])),
//             ),
//           ],
//         ),
//       ),
//       confirm: ElevatedButton(
//         onPressed: () => createOrUpdateSchedule(existingSchedule: schedule),
//         child: Text(schedule == null ? 'Create' : 'Update'),
//       ),
//       cancel: TextButton(
//         onPressed: () {
//           Get.back();
//           titleController.clear();
//           selectedDateTime.value = null;
//         },
//         child: Text('Cancel'),
//       ),
//     );
//   }

//   void showQRCode(Schedule schedule) {
//     Get.defaultDialog(
//       title: 'QR Code for ${schedule.title}',
//       content: SizedBox(
//         width: Get.width,
//         height: Get.height * 0.4,
//         child: QrImage(
//           data: schedule.id,
//           version: QrVersions.auto,
//         ),
//       ),
//       confirm: TextButton(
//         onPressed: () => Get.back(),
//         child: Text('Close'),
//       ),
//     );
//   }

//   void scanQRCode() async {
//     final scannedData = await Get.toNamed('/qr-scanner');
//     if (scannedData != null) {
//       final scannedSchedule = schedules.firstWhere(
//         (schedule) => schedule.id == scannedData,
//         orElse: () => Schedule(id: '', title: 'Not Found', dateTime: DateTime.now()),
//       );
//       Fluttertoast.showToast(msg: 'Scanned Schedule: ${scannedSchedule.title}');
//     }
//   }
// }

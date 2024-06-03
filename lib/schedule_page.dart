import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get/get.dart';
import 'schedule_controller.dart';

class SchedulePage extends StatelessWidget {
  final ScheduleController _controller = Get.put(ScheduleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.indigo.shade50,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search classes...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              ),
              onChanged: (value) {
                _controller.searchQuery.value = value;
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: _controller.filteredSchedules.length,
                  itemBuilder: (context, index) {
                    final schedule = _controller.filteredSchedules[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(schedule.title),
                        subtitle: Text('Status: ${schedule.status} - ${schedule.details}'),
                        trailing: _getStatusIcon(schedule.status),
                        onTap: () {
                          Get.dialog(
                            AlertDialog(
                              title: Text('Class Details'),
                              content: Text(
                                'Time: ${schedule.dateTime}\nStatus: ${schedule.status}\nDetails: ${schedule.details}',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }),
            ),
            SizedBox(height: 16),
            AnimatedButton(
              onPress: _controller.scanAttendance,
              height: 60,
              width: double.infinity,
              text: 'Scan Attendance',
              isReverse: true,
              selectedTextColor: Colors.indigo,
              transitionType: TransitionType.LEFT_CENTER_ROUNDER,
              backgroundColor: Colors.indigo,
              borderColor: Colors.indigo,
              borderRadius: 12,
              borderWidth: 2,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Need help?'),
                TextButton(
                  onPressed: () {
                    // Handle help action
                  },
                  child: Text(
                    'Contact Support',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Icon _getStatusIcon(String status) {
    switch (status) {
      case 'Absent':
        return Icon(Icons.warning, color: Colors.red);
      case 'Present':
        return Icon(Icons.check_circle, color: Colors.green);
      case 'Late':
        return Icon(Icons.access_time, color: Colors.orange);
      default:
        return Icon(Icons.help, color: Colors.grey);
    }
  }
}

void main() {
  runApp(GetMaterialApp(
    home: SchedulePage(),
  ));
}

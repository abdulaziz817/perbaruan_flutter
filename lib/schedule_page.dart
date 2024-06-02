import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Map<String, dynamic>> schedules = [
    {"time": "08:00 AM", "status": "Absent", "details": "Math Class"},
    {"time": "09:00 AM", "status": "Present", "details": "Science Class"},
    {"time": "10:00 AM", "status": "Late", "details": "History Class"},
    {"time": "11:00 AM", "status": "Present", "details": "Geography Class"},
    {"time": "01:00 PM", "status": "Absent", "details": "Physical Education"},
    {"time": "02:00 PM", "status": "Present", "details": "Art Class"},
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredSchedules = schedules.where((schedule) {
      return schedule["details"].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    void scanAttendance() {
      // Add your scan logic here
      // For now, just show a dialog for demonstration
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Scan Attendance'),
          content: Text('Attendance scanned successfully.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }

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
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSchedules.length,
                itemBuilder: (context, index) {
                  final schedule = filteredSchedules[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(schedule["time"]),
                      subtitle: Text('Status: ${schedule["status"]} - ${schedule["details"]}'),
                      trailing: schedule["status"] == "Absent"
                          ? Icon(
                              Icons.warning,
                              color: Colors.red,
                            )
                          : schedule["status"] == "Present"
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : Icon(
                                  Icons.access_time,
                                  color: Colors.orange,
                                ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Class Details'),
                            content: Text(
                              'Time: ${schedule["time"]}\nStatus: ${schedule["status"]}\nDetails: ${schedule["details"]}',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            AnimatedButton(
              onPress: scanAttendance,
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
}

void main() {
  runApp(MaterialApp(
    home: SchedulePage(),
  ));
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'admin_controller.dart';

class AdminPage extends StatelessWidget {
  final AdminController _controller = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
        backgroundColor: Colors.indigo,
      ),
      body: Obx(() {
        return _controller.schedules.isEmpty
            ? Center(
                child: Text(
                  'No schedules available',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: _controller.schedules.length,
                itemBuilder: (context, index) {
                  final schedule = _controller.schedules[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.schedule, color: Colors.indigo),
                      title: Text(schedule.title),
                      subtitle: Text(
                        '${schedule.dateTime.toLocal()}'.split(' ')[0],
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.qr_code),
                            onPressed: () => _controller.showQRCode(schedule),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _controller.showScheduleForm(schedule: schedule),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
      }),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () => _controller.showScheduleForm(),
            child: Icon(Icons.add),
            backgroundColor: Colors.indigo,
            heroTag: 'addSchedule',
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => _controller.scanQRCode(),
            child: Icon(Icons.qr_code_scanner),
            backgroundColor: Colors.indigo,
            heroTag: 'scanQRCode',
          ),
        ],
      ),
    );
  }
}

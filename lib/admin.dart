import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Schedule {
  String id;
  String title;
  DateTime dateTime;

  Schedule({required this.id, required this.title, required this.dateTime});
}

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final List<Schedule> _schedules = [];
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  DateTime? _selectedDateTime;

  void _createOrUpdateSchedule({Schedule? existingSchedule}) {
    if (_formKey.currentState!.validate()) {
      if (_selectedDateTime != null) {
        if (existingSchedule == null) {
          // Create new schedule
          final newSchedule = Schedule(
            id: Uuid().v4(),
            title: _titleController.text,
            dateTime: _selectedDateTime!,
          );
          setState(() {
            _schedules.add(newSchedule);
          });
        } else {
          // Update existing schedule
          setState(() {
            existingSchedule.title = _titleController.text;
            existingSchedule.dateTime = _selectedDateTime!;
          });
        }

        _titleController.clear();
        _selectedDateTime = null;
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a date and time')),
        );
      }
    }
  }

  void _showScheduleForm({Schedule? schedule}) {
    if (schedule != null) {
      _titleController.text = schedule.title;
      _selectedDateTime = schedule.dateTime;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(schedule == null ? 'Create Schedule' : 'Edit Schedule'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
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
                  _selectedDateTime = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (_selectedDateTime != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                    );
                    if (time != null) {
                      _selectedDateTime = DateTime(
                        _selectedDateTime!.year,
                        _selectedDateTime!.month,
                        _selectedDateTime!.day,
                        time.hour,
                        time.minute,
                      );
                    }
                  }
                },
                child: Text(_selectedDateTime == null
                    ? 'Select Date and Time'
                    : '${_selectedDateTime!.toLocal()}'.split(' ')[0]),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _titleController.clear();
              _selectedDateTime = null;
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => _createOrUpdateSchedule(existingSchedule: schedule),
            child: Text(schedule == null ? 'Create' : 'Update'),
          ),
        ],
      ),
    );
  }

  void _showQRCode(Schedule schedule) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('QR Code for ${schedule.title}'),
        content: QrImageView(
          data: schedule.id,
          version: QrVersions.auto,
          size: 200.0,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _scanQRCode() async {
    final scannedData = await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => QRViewExample(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
    if (scannedData != null) {
      final scannedSchedule = _schedules.firstWhere(
        (schedule) => schedule.id == scannedData,
        orElse: () => Schedule(id: '', title: 'Not Found', dateTime: DateTime.now()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Scanned Schedule: ${scannedSchedule.title}')),
      );
    }
  }
 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Admin Page'),
      backgroundColor: Colors.indigo,
    ),
    body: _schedules.isEmpty
        ? Center(
            child: Text(
              'No schedules available',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          )
        : ListView.builder(
            itemCount: _schedules.length,
            itemBuilder: (context, index) {
              final schedule = _schedules[index];
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
                        onPressed: () => _showQRCode(schedule),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _showScheduleForm(schedule: schedule),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    floatingActionButton: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: () => _showScheduleForm(),
          child: Icon(Icons.add),
          backgroundColor: Colors.indigo,
          heroTag: 'addSchedule',
        ),
        SizedBox(height: 16),
        FloatingActionButton(
          onPressed: () => _scanQRCode(),
          child: Icon(Icons.qr_code_scanner),
          backgroundColor: Colors.indigo,
          heroTag: 'scanQRCode',
        ),
      ],
    ),
  );
}
}

class QRViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'Scan a code',
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      Navigator.pop(context, scanData.code);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: AdminPage(),
  ));
}
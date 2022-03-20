import 'package:flutter/material.dart';
import 'package:flutter_travelapp/screens/notification/notify_badge.dart';

class TestNotify extends StatefulWidget {
  const TestNotify({ Key? key }) : super(key: key);

  @override
  State<TestNotify> createState() => _TestNotifyState();
}

class _TestNotifyState extends State<TestNotify> {
  @override
  late int _totalNotifications;

  @override
  void initState() {
    _totalNotifications = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notify'),
        brightness: Brightness.dark,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'App for capturing Firebase Push Notifications',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 16.0),
          NotificationBadge(totalNotifications: _totalNotifications),
          SizedBox(height: 16.0),
          // TODO: add the notification text here
        ],
      ),
    );
  }
}
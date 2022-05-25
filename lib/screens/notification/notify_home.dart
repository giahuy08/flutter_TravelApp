import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelapp/providers/notification_provider.dart';
import 'package:flutter_travelapp/screens/notification/components/notification_tiles.dart';
import 'package:flutter_travelapp/screens/notification/notification_page.dart';
import 'package:flutter_travelapp/screens/notification/notify_badge.dart';
import 'package:flutter_travelapp/models/notify.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class NotifyHome extends StatefulWidget {
  const NotifyHome({Key? key}) : super(key: key);

  @override
  State<NotifyHome> createState() => _NotifyHomeState();
}

class _NotifyHomeState extends State<NotifyHome> {
  late List<Notify> notifications;
  static List<String?> detail = [];
  _getNotifications(List<Notify> notifications) async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // // List<dynamic> listNotifyString = notifications
    // //     .map((notification) => jsonEncode(notification.toStringJson()))
    // //     .toList();

    // final data =
    //     sharedPreferences.setString('notifications', notifications.toString());
    // print('data saved');
    // print(data);
  }

  late final FirebaseMessaging _messaging;
  late int _totalNotifications;
  Notify? _notificationInfo;

  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(
            'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');

        // Parse the message received
        Notify notification = Notify(
          title: message.notification?.title,
          body: message.notification?.body,
          // dataTitle: message.data['title'],
          // dataBody: message.data['body'],
        );
        // notificationProvider.addNotification(notification);
        setState(() {
          _notificationInfo = notification;

          _totalNotifications++;
        });

        // if (_notificationInfo != null) {
        //   // For displaying the notification as an overlay
        //   showSimpleNotification(
        //     Text(_notificationInfo!.title!),
        //     leading: NotificationBadge(totalNotifications: _totalNotifications),
        //     subtitle: Text(_notificationInfo!.body!),
        //     background: Colors.cyan.shade700,
        //     duration: Duration(seconds: 2),
        //   );
        // }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      Notify notification = Notify(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,

        // dataTitle: initialMessage.data['title'],
        // dataBody: initialMessage.data['body'],
      );
      // notificationProvider.addNotification(notification);

      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    }
  }

  @override
  void initState() {
    _totalNotifications = 0;
    notifications = notificationProvider.listNotification;
    _getNotifications(notifications);
    registerNotification();
    checkForInitialMessage();

    // setState(() {
    //   listNoti.addAll(notificationProvider.listNotification);
    // });

    // For handling notification when the app is in background
    // but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Notify notification = Notify(
        title: message.notification?.title,
        body: message.notification?.body,
        // dataTitle: message.data['title'],
        // dataBody: message.data['body'],
      );
      // notificationProvider.addNotification(notification);
      setState(() {
        _notificationInfo = notification;

        _totalNotifications++;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Thông báo'),
        ),
        body: notificationProvider.listNotification.isNotEmpty
            ? ListView.separated(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: notificationProvider.listNotification.length,
                itemBuilder: (context, index) {
                  return NotificationTiles(
                    title: notificationProvider.listNotification[index].title
                        .toString(),
                    subtitle: notificationProvider.listNotification[index].body
                        .toString(),
                    enable: true,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NotificationPage())),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                })
            : const Align(
                alignment: Alignment.center,
                child: Text('Không có thông báo')));
  }
}

class NotificationBadge extends StatelessWidget {
  final int totalNotifications;

  const NotificationBadge({required this.totalNotifications});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: new BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$totalNotifications',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

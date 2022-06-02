import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelapp/models/notify.dart';
import 'package:flutter_travelapp/providers/notification_provider.dart';
import 'package:flutter_travelapp/screens/notification/notify_home.dart';
import 'package:flutter_travelapp/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'icon_btn_with_counter.dart';
import 'search_field.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  late final FirebaseMessaging _messaging;
  late int count = notificationProvider.listNotification.length;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _noti() async {
    // final SharedPreferences prefs = await _prefs;
    // // final JsonDecoder json =
    // //     JsonDecoder(prefs.getStringList('notifications') );
    // print('refer');
    // print(prefs.getStringList('notifications') as List<Notify>);
    // if (prefs.getStringList('notifications') != null &&
    //     notificationProvider.listNotification.length == 0) {
    //   // notificationProvider.listNotification
    //   //     .addAll(jsonDecode(prefs.getString('notifications').toString()));
    // }
  }

  // late int _totalNotifications;
  // Notify? _notificationInfo;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

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
        notificationProvider.addNotification(notification);
        setState(() {
          // _notificationInfo = notification;

          // _totalNotifications++;
        });
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
      notificationProvider.addNotification(notification);
    }
  }

  @override
  void initState() {
    // _totalNotifications = 0;
    registerNotification();
    checkForInitialMessage();
    _noti();

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
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SearchField(),
          // IconBtnWithCounter(
          //   svgSrc: "assets/icons/order-history.svg",
          //   press: () => {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (BuildContext context) =>
          //             const BookedTourHomeScreen()))
          //   },
          // ),
          IconBtnWithCounter(
            numOfItems: notificationProvider.listNotification.length,
            svgSrc: 'assets/icons/Bell.svg',
            press: () => {
              _noti(),
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const NotifyHome()))
            },
          )
        ],
      ),
    );
  }
}

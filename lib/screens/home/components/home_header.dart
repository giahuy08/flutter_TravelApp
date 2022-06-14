import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelapp/components/listtours_argument.dart';
import 'package:flutter_travelapp/models/notify.dart';
import 'package:flutter_travelapp/models/tour.dart';
import 'package:flutter_travelapp/providers/notification_provider.dart';
import 'package:flutter_travelapp/repository/tour_repository.dart';
import 'package:flutter_travelapp/screens/bookedtour_booking/calendar_popup_view.dart';
import 'package:flutter_travelapp/screens/error/error_screen.dart';
import 'package:flutter_travelapp/screens/listtours/listtours_screen.dart';
import 'package:flutter_travelapp/screens/notification/notify_home.dart';
import 'package:flutter_travelapp/size_config.dart';

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
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  late List<TourModel> tourByDate;
  late final FirebaseMessaging _messaging;
  late int count = notificationProvider.listNotification.length;
  Future<void> _noti() async {}

  @override
  void dispose() {
    super.dispose();
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
          IconBtnWithCounter(
            svgSrc: "assets/icons/calendar.svg",
            press: () async => {
              FocusScope.of(context).requestFocus(FocusNode()),
              // setState(() {
              //   isDatePopupOpen = true;
              // });
              showDemoDialog(context: context),
            },
          ),
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

  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        //minimumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) async {
          setState(() {
            startDate = startData;
            endDate = endData;
          });

          tourByDate =
              await TourRepository().findTourByDate(startDate, endDate);
          if (tourByDate.isEmpty) {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, ErrorScreen.routeName,
                arguments: true);
          } else {
            Navigator.pushNamed(context, ListToursScreen.routeName,
                arguments: ListToursArguments(tours: tourByDate));
          }
        },
        onCancelClick: () {},
      ),
    );
  }
}

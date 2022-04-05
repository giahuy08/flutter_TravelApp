import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_travelapp/models/user.dart';
import 'package:flutter_travelapp/repository/user_repository.dart';
import 'package:flutter_travelapp/models/notify.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/cupertino.dart';

class NotificationProvider extends ChangeNotifier {
  List<Notify> _notifications = [];
  int _countNotify = 0;
  // List<dynamic> _notificationsController = [];

  // initial() {
  //   _notifications.clear();
  //   // _notificationsController.add(_notifications);
  // }

  addNotification(Notify notifications) {
    _notifications.add(notifications);
    // _notificationsController.add(_notifications);
    print(_notifications);
    print('hello');
    _countNotify = _notifications.length;
    notifyListeners();
  }

  List<Notify> get listNotification => _notifications.reversed.toList();
  int get countNotification => _countNotify;
}

NotificationProvider notificationProvider = NotificationProvider();

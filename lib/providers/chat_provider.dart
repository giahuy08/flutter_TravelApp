import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_travelapp/providers/user_provider.dart';

import '../repository/user_repository.dart';
import '../services/socket_emit.dart';

class ChatProvider extends ChangeNotifier {
  late String channelId;
  int skip = 0;

  List<dynamic> _messages = [];

  StreamController<List<dynamic>> _messagesController =
      StreamController<List<dynamic>>.broadcast();
  initial(String id) {
    _messages.clear();
    _messagesController.add(_messages);
    skip = 0;
    channelId = '';
  }

  joinChannel(String idUser) {
    SocketEmit().joinRoom(idRoom: idUser);
    notifyListeners();
  }

  initialMessage(String idUser) {
    joinChannel(idUser);
    skip = 0;
    _messages.clear();
  }

  insertMessage(dynamic messages) {
    int index =
        _messages.indexWhere((element) => element['_id'] == messages['_id']);
    if (index == -1) {
      _messages.insert(0, messages);
      _messagesController.add(_messages);
      skip++;
      notifyListeners();
    }
  }

  leaveChannel({required String idRoom}) {
    channelId = '';
    SocketEmit().leaveRoom(
      idRoom: idRoom,
    );
    notifyListeners();
  }

  getListMessage(String idRoom) {
    if (skip != -1) {
      UserRepository()
          .getMessage(
        skip: skip,
        idRoom: idRoom,
      )
          .then((value) {
        if (value.length > 0) {
          _messages.addAll(value);
          print('danh sach tin nhan');

          _messagesController.add(_messages);

          print(_messagesController);
          skip += value.length;
          notifyListeners();
        } else {
          skip = -1;
          notifyListeners();
        }
      });
    }
  }

  getMessage(String idRoom) {
    if (skip != -1) {
      UserRepository()
          .getMessage(
        skip: skip,
        idRoom: idRoom,
      )
          .then((value) {
        if (value.length > 0) {
          skip += value.length;
          addMoreMessage(value);
        } else {
          skip = -1;
        }
      });
    }
  }

  addMoreMessage(List<dynamic> messages) {
    _messages.addAll(messages);
    _messagesController.add(_messages);
    notifyListeners();
  }

  Stream<List<dynamic>> get listMessage => _messagesController.stream;
}

ChatProvider chatProvider = ChatProvider();

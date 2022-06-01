import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_travelapp/providers/user_provider.dart';
import 'package:flutter_travelapp/repository/base_repository.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
class ChatRepository {
  Future<String> getSocketConnectring() async  {
    var socket ='http://$root_url?token=Bearer ${userProvider.user.token}';
    return socket;
  }

  void connectSocket (){
    IO.Socket socket;
    getSocketConnectring().then((value) {

    socket = IO.io(
      value,
      IO.OptionBuilder().enableForceNew().setTransports(['websocket']).build(),
    );
    socket.connect();
    socket.onConnect((_) {
      debugPrint('connect');
   

      // socket.on(
      //   'ORDER_CHANGE_STATUS_SSC',
      //   (data) {
      //     Get.back();
      //     orderController.refreshOrder(convert.jsonDecode(data));
      //   },
      // );

      // socket.on(
      //   'SEND_MESSAGE_SSC',
      //   (data) {
      //     messageAdminController.insertMessage(data);
      //     // infoUserProvider.addInfoUser(data['createUser'] ?? null);
      //   },
      // );

      // socket.on('UPDATE_SHIPPING_SSC', (data) {
      //   if (!data['error']) {
      //     if (userProvider.user.role == 0) {
      //       userProvider.updateShippingFee(data);
      //     } else {
      //       Get.back();
      //       Get.back();
      //       adminController.setShippingFee(
      //         data['_id'],
      //         data,
      //       );
      //     }
      //   } else {
      //     if (userProvider.user.role == 1) {
      //       Get.back();
      //       GetSnackBar getSnackBar = GetSnackBar(
      //         title: 'Xét giá ship thất bại',
      //         subTitle: 'Lỗi máy chủ, thử lại sau!',
      //       );
      //       getSnackBar.show();
      //     }
      //   }
      // }
    });

    socket.onDisconnect((_) => debugPrint('disconnect'));
  });
  }
}

import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_travelapp/providers/user_provider.dart';
import 'package:http/http.dart' as http;

// const root_url = "freshfoodbe.tk";
// const root_url = "app-travelbe.herokuapp.com";
const root_url = "be-travel.herokuapp.com";
// const root_url = "192.168.1.24:5000";
//const root_url = "192.168.1.190:5000";

// const socket_url = "45.212.16.10:5000";

class HandleApis {
  Future<String> getBaseURLSocket() async {
    var fcmToken = await getFcmToken();
    print('fcmtoken');
    debugPrint('FCM Token: ' + fcmToken.toString());

    return 'http://$root_url?fcm=$fcmToken&token=Bearer ${userProvider.user.token}';
  }
  // Future<String> getBaseURLSocket() async {
  //   // var fcmToken = await getFcmToken();
  //   // debugPrint('FCM Token: ' + fcmToken.toString());

  //   // return 'http://$socket_url?fcm=$fcmToken&token=Bearer ${userProvider.user.token}';
  //   return 'http://$root_url?token=Bearer ${userProvider.user.token}';
  // }
  Future<String?> getFcmToken() async {
    FirebaseMessaging _fcm = FirebaseMessaging.instance;
    return await _fcm.getToken();
  }

  get(String name, [String? params]) async {
    Map<String, String> paramsObject = {};
    if (params != null) {
      params.split('&').forEach((element) {
        paramsObject[element.split('=')[0].toString()] =
            element.split('=')[1].toString();
      });
    }
    // stderr.write("GET: " + root_url +'/'+ name + '\n' + paramsObject.toString());
    http.Response response = await http.get(
      params == null
          ? Uri.http(root_url, '/' + name)
          : Uri.http(root_url, '/' + name, paramsObject),
      // Uri.http(root_url, '/' + name, paramsObject),
      headers: getHeaders(),
    );
    print(getHeaders()['Authorization']);
    return response;
  }

  post(String name, Map<String, dynamic> body) async {
    // stderr.write("POST: " + root_url +'/'+ name);
    return await http.post(Uri.http(root_url, '/' + name),
        // Uri.http(root_url, '/' + name),
        headers: getHeaders(),
        body: jsonEncode(body));
  }

  put(String name, Map<String, dynamic> body) async {
    // stderr.write("POST: " + root_url +'/'+ name);
    return await http.put(Uri.http(root_url, '/' + name),
        // Uri.http(root_url, '/' + name),
        headers: getHeaders(),
        body: jsonEncode(body));
  }

  putArray(String name, List<Map<String, dynamic>> body) async {
    // stderr.write("POST: " + root_url +'/'+ name);
    return await http.put(Uri.http(root_url, '/' + name),
        // Uri.http(root_url, '/' + name),
        headers: getHeaders(),
        body: jsonEncode(body));
  }

  delete(String name, [String? params]) async {
    Map<String, String> paramsObject = {};
    if (params != null) {
      params.split('&').forEach((element) {
        paramsObject[element.split('=')[0].toString()] =
            element.split('=')[1].toString();
      });
    }
    // stderr.write("GET: " + root_url +'/'+ name + '\n' + paramsObject.toString());
    http.Response response = await http.delete(
      params == null
          ? Uri.http(root_url, '/' + name)
          : Uri.http(root_url, '/' + name, paramsObject),
      // Uri.http(root_url, '/' + name, paramsObject),
      headers: getHeaders(),
    );
    return response;
  }

  getHeaders() {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Connection': 'keep-alive',
      'Accept': '*/*',
      'Accept-Encoding': 'gzip, deflate, br',
      'Authorization': 'Bearer ' +
          (userProvider.user == null ? '' : userProvider.user!.token!),
    };
  }
}

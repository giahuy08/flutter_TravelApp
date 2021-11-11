import 'dart:convert';
import 'package:http/http.dart' as http;

// const root_url = "freshfoodbe.tk";
//const root_url = "192.168.1.12:3000";
const root_url = "192.168.1.190:3000";

const socket_url = "45.212.16.10:3000";

class HandleApis {
  // Future<String> getBaseURLSocket() async {
  //   var fcmToken = await getFcmToken();
  //   debugPrint('FCM Token: ' + fcmToken.toString());

  //   return 'http://$socket_url?fcm=$fcmToken&token=Bearer ${userProvider.user.token}';
  // }

  // Future<String> getFcmToken() async {
  //   FirebaseMessaging _fcm = FirebaseMessaging.instance;
  //   return await _fcm.getToken();
  // }

  get(String name, [String? params]) async {
    Map<String, String> paramsObject = {};
    if (params != null)
      // ignore: curly_braces_in_flow_control_structures
      params.split('&').forEach((element) {
        paramsObject[element.split('=')[0].toString()] =
            element.split('=')[1].toString();
      });
    // stderr.write("GET: " + root_url +'/'+ name + '\n' + paramsObject.toString());
    //because i am very gioi
    http.Response response = await http.get(
      params == null
          ? Uri.http(root_url, '/' + name) // neu xai https thi cham https
          : Uri.http(root_url, '/' + name, paramsObject),
      // Uri.http(root_url, '/' + name, paramsObject),
      headers: getHeaders(),
    );
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

  delete(String name, {Map<String, dynamic>? body}) async {
    // stderr.write("POST: " + root_url +'/'+ name);
    return await http.delete(
      Uri.http(root_url, '/' + name),
      // Uri.http(root_url, '/' + name),
      headers: getHeaders(),
    );
  }

//string try ddi if type == post
//call post check if else or switch case thoi, 4 dunc de hon gop lai, ms bik 4 cai thoi do 4 cai hay viet thi neu nhu maj neu post form data, ko bik viet thi 5 tin hieu
//back thi ns chung la viet them thoi, bt mak, ko bik thi tin hieu cho thay, api thi z thoi, api chia 2 loai, http ... da so https cahn http(ko an toan)
// la bacckend ngu 1 diem ve cho
// tin hieu la gi
  getHeaders() {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Connection': 'keep-alive',
      'Accept': '*/*',
      'Accept-Encoding': 'gzip, deflate, br',
      'Authorization': 'Bearer ' +
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJUcmF2ZWwgQXBwIFRoaWVuIEh1eSIsImRhdGEiOnsiaWQiOiI2MTdkNjU4MmE2MjhmYjQ3ZTBmZjVmODciLCJyb2xlIjowfSwiaWF0IjoxNjM2MDE0OTgxMjkzLCJleHAiOjE2MzYxMDEzODEyOTN9.XeBPLov7Bx7KwjqH7BO5xScXu59Y95OOMcWFJ7IlQVA',
    };
  }
}

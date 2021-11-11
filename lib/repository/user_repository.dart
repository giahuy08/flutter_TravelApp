import 'dart:convert';
import 'package:flutter_travelapp/models/user.dart';
import 'package:get/get.dart';

import 'api_gateway.dart';
import 'base_repository.dart';

class UserRepository {
  Future<dynamic> getProfile() async {
    var response = await HandleApis().get(ApiGateway.findUserByToken);
    //print(response.statusCode);
    //print(response.body.toString());
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return null;
  }

  Future<String?> changePassword(String oldPassword, String newPassword) async {
    var body = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    };
    var response = await HandleApis().post(ApiGateway.changePassword, body);
    //print(response.statusCode);
    //print(response.body.toString());
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    }
    if (response.statusCode == 300) {
      return jsonDecode(response.body)['message'];
    }
    return null;
  }
}

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
}

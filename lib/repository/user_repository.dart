import 'dart:convert';
import 'dart:io';
import 'package:flutter_travelapp/models/user.dart';
import 'package:flutter_travelapp/providers/user_provider.dart';
import 'package:get/get.dart';

import 'api_gateway.dart';
import 'base_repository.dart';
import 'package:http/http.dart' as http;

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

  Future<String?> editProfile(
      String? name, String? address, String? phone) async {
    // var request =
    //     http.MultipartRequest('PUT', Uri.http(root_url, 'user/editProfile'));
    // request.headers["Content-Type"] = 'multipart/form-data';
    // request.headers["Authorization"] = 'Bearer ' +
    //     (userProvider.user == null ? '' : userProvider.user!.token!);
    // request.fields.addAll({
    //   "name": name!,
    //   "address": address!,
    //   "phone": phone!,
    // });
    // var response = await http.Response.fromStream(await request.send());
    var body = {
      "name": name!,
      "address": address!,
      "phone": phone!,
    };
    var response = await HandleApis().put(ApiGateway.editProfile, body);
    //print(response.statusCode);
    //print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    }
    if (response.statusCode == 300) {
      return jsonDecode(response.body)['message'];
    }

    return null;
  }

  Future<String?> updateAvatar(File? avatar) async {
    var request =
        http.MultipartRequest('PUT', Uri.http(root_url, 'user/updateAvatar'));
    request.headers["Content-Type"] = 'multipart/form-data';
    request.headers["Authorization"] = 'Bearer ' +
        (userProvider.user == null ? '' : userProvider.user!.token!);

    if (avatar != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          "Avatar",
          avatar.readAsBytesSync(),
          filename: avatar.path,
        ),
      );
    }
    if (request.files.isEmpty) return null;
    var response = await http.Response.fromStream(await request.send());
    //print(response.statusCode);
    //print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    }
    if (response.statusCode == 300) {
      return jsonDecode(response.body)['message'];
    }

    return null;
  }
}

import 'dart:convert';

import 'package:flutter_travelapp/repository/api_gateway.dart';
import 'package:flutter_travelapp/repository/base_repository.dart';

class AuthenRepository {
  Future<Map<String, dynamic>?> login(String email, String password) async {
    var body = {
      "email": email,
      "password": password,
    };
    var response = await HandleApis().post(ApiGateway.login, body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return null;
  }

  Future<Map<String, dynamic>?> loginwithGoogle(
      String email, String name) async {
    var body = {
      "email": email,
      "name": name,
    };

    var response = await HandleApis().post(ApiGateway.loginwithGoogle, body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }

    return null;
  }

  Future<String?> register(String email, String password, String phone,
      String name, String address) async {
    var body = {
      "email": email,
      "password": password,
      "phone": phone,
      "name": name,
      "address": address
    };
    var response = await HandleApis().post(ApiGateway.register, body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    }
    if (response.statusCode == 300) {
      return jsonDecode(response.body)['message'];
    }
    return null;
  }

  Future<String?> forgotpassword(String email) async {
    var response =
        await HandleApis().get(ApiGateway.forgotPassword, 'email=$email');
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    }
    if (response.statusCode == 300) {
      return jsonDecode(response.body)['message'];
    }
    return null;
  }

  Future<String?> resetpassword(
      String otp, String email, String password) async {
    var body = {
      "otp": otp,
      "email": email,
      "password": password,
    };
    var response = await HandleApis().post(ApiGateway.resetPassword, body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    }
    if (response.statusCode == 300) {
      return jsonDecode(response.body)['message'];
    }
    return null;
  }

  Future<String?> verifyUser(String otp, String email) async {
    var body = {
      "otp": otp,
      "email": email,
    };
    var response = await HandleApis().post(ApiGateway.verifyUser, body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    }
    if (response.statusCode == 300) {
      return jsonDecode(response.body)['message'];
    }
    return null;
  }
}

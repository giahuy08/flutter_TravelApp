import 'dart:convert';

import 'package:flutter_travelapp/models/enterprise.dart';
import 'package:http/http.dart';

import 'package:flutter_travelapp/repository/api_gateway.dart';
import 'package:flutter_travelapp/repository/base_repository.dart';

class EnterpriseRepository {
  Future<List<EnterpriseModel>> getListEnterprise() async {
    Response response = await HandleApis().get(ApiGateway.getAllEnterprise);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];

      if (jsonResponse.isEmpty) {
        return [];
      }

      return jsonResponse.map((item) => EnterpriseModel.fromMap(item)).toList();
    }
    return [];
  }

  Future<dynamic> getOneEnterprise(id) async {
    Response response =
        await HandleApis().get(ApiGateway.getOneEnterprise, 'id=$id');

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }

    return null;
  }

  Future<List<dynamic>> getListRoom(idEnterprise) async {
    Response response = await HandleApis()
        .get(ApiGateway.getRoomOfEnterprise, 'idEnterprise=$idEnterprise');

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
      if (jsonResponse.isEmpty) {
        return [];
      }
      return jsonResponse;
    }
    return [];
  }

  Future<List<dynamic>> getListTable(idEnterprise) async {
    Response response = await HandleApis()
        .get(ApiGateway.getTableOfEnterprise, 'idEnterprise=$idEnterprise');

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
      if (jsonResponse.isEmpty) {
        return [];
      }
      return jsonResponse;
    }
    return [];
  }
}

import 'dart:convert';

import 'package:http/http.dart';

import 'package:flutter_travelapp/repository/api_gateway.dart';
import 'package:flutter_travelapp/repository/base_repository.dart';

class DiscountRepository {
  Future<List<dynamic>> getListDiscount() async {
    Response response = await HandleApis().get(ApiGateway.getAllDiscount);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
      if (jsonResponse.isEmpty) {
        return [];
      }
      return jsonResponse;
    }
    return [];
  }

  Future<List<dynamic>> getListDiscountByEXP() async {
    Response response = await HandleApis().get(ApiGateway.getAllDiscountByEXP);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
      if (jsonResponse.isEmpty) {
        return [];
      }
      return jsonResponse;
    }
    return [];
  }

  Future<List<dynamic>> getListDiscountOfTourByEXP(idTour) async {
    Response response = await HandleApis()
        .get(ApiGateway.getDiscountOfTourByEXP, 'idTour=$idTour');

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

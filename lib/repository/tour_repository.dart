import 'dart:convert';

import 'package:flutter_travelapp/models/tour.dart';
import 'package:flutter_travelapp/repository/api_gateway.dart';
import 'package:flutter_travelapp/repository/base_repository.dart';
import 'package:http/http.dart';

class TourRepository {
  Future<List<TourModel>> getListTour(skip, limit) async {
    Response response = await HandleApis()
        .get(ApiGateway.getAllTour, 'skip=$skip&limit=$limit');
    //print(response.statusCode);
    //print(response.body.toString());
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];

      if (jsonResponse.isEmpty) {
        return [];
      }

      return jsonResponse.map((item) => TourModel.fromMap(item)).toList();
    }
    return [];
  }

  Future<TourModel?> getOneTour(id) async {
    Response response = await HandleApis().get(ApiGateway.getOneTour, 'id=$id');
    // print(response.statusCode);
    // print(response.body.toString());
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];

      if (jsonResponse.isEmpty) {
        return null;
      }

      return jsonResponse.map((item) => TourModel.fromMap(item)).single;
    }
    return null;
  }

  Future<List<TourModel>> findTourByName(name) async {
    Response response = await HandleApis().get(ApiGateway.findTourByName);
    // print(response.statusCode);
    // print(response.body.toString());
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];

      if (jsonResponse.isEmpty) {
        return [];
      }

      return jsonResponse.map((item) => TourModel.fromMap(item)).toList();
    }
    return [];
  }

  Future<List<TourModel>> findTourByCategory(category, skip, limit) async {
    Response response = await HandleApis().get(ApiGateway.findTourByCategory,
        'category=$category&skip=$skip&limit=$limit');
    // print(response.statusCode);
    // print(response.body.toString());
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];

      if (jsonResponse.isEmpty) {
        return [];
      }

      return jsonResponse.map((item) => TourModel.fromMap(item)).toList();
    }
    return [];
  }

  Future<List<TourModel>> findAllTourByCategory(category) async {
    Response response = await HandleApis()
        .get(ApiGateway.findAllTourByCategory, 'category=$category');
    //print(response.statusCode);
    //print(response.body.toString());
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];

      if (jsonResponse.isEmpty) {
        return [];
      }

      return jsonResponse.map((item) => TourModel.fromMap(item)).toList();
    }
    return [];
  }
}

import 'dart:convert';

import 'package:flutter_travelapp/models/tour.dart';
import 'package:flutter_travelapp/repository/api_gateway.dart';
import 'package:flutter_travelapp/repository/base_repository.dart';
import 'package:http/http.dart';

class TourRepository {
  Future<List<TourModel>> getListTour(skip, limit) async {
    Response response = await HandleApis()
        .get(ApiGateway.getAllTour, 'skip=$skip&limit=$limit');

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];

      if (jsonResponse.isEmpty) {
        return [];
      }

      return jsonResponse.map((item) => TourModel.fromMap(item)).toList();
    }
    return [];
  }

  Future<dynamic> getOneTour(id) async {
    Response response = await HandleApis().get(ApiGateway.getOneTour, 'id=$id');

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }

    return null;
  }

  Future<dynamic> favoriteTour(id) async {
    var body = {"idTour": id};
    var response = await HandleApis().post(ApiGateway.favoriteTour, body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }

    return null;
  }

  Future<List<TourModel>> findTourByName(name) async {
    Response response =
        await HandleApis().get(ApiGateway.findTourByName, 'name=$name');

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];

      if (jsonDecode(response.body)['message'] == 'Dont find tour') {
        return [];
      }

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

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];

      if (jsonResponse.isEmpty) {
        return [];
      }

      return jsonResponse.map((item) => TourModel.fromMap(item)).toList();
    }
    return [];
  }

  Future<List<TourModel>> getUserFarvorite() async {
    Response response = await HandleApis().get(ApiGateway.getUserFarvorite);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];

      if (jsonResponse.isEmpty) {
        return [];
      }

      return jsonResponse.map((item) => TourModel.fromMap(item)).toList();
    }
    return [];
  }

  Future<List<TourModel>> getHistoryAccess() async {
    Response response = await HandleApis().get(ApiGateway.getHistoryAccess);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];

      if (jsonResponse.isEmpty) {
        return [];
      }

      return jsonResponse.map((item) => TourModel.fromMap(item)).toList();
    }
    return [];
  }

  Future<List<TourModel>> findTourByDate(dateStart, dateEnd) async {
    Response response = await HandleApis().get(ApiGateway.getUserBookTourByDate,
        'dateStart=$dateStart&dateEnd=$dateEnd');

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

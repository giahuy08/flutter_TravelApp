import 'dart:convert';

import 'package:flutter_travelapp/models/booktour.dart';
import 'package:flutter_travelapp/providers/user_provider.dart';
import 'package:flutter_travelapp/repository/api_gateway.dart';
import 'package:flutter_travelapp/repository/base_repository.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class BookTourRepository {
  Future<List<BookTourModel>> getUserBookTour(skip, limit) async {
    Response response = await HandleApis()
        .get(ApiGateway.getUserBookTour, 'skip=$skip&limit=$limit');

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];

      if (jsonResponse.isEmpty) {
        return [];
      }

      return jsonResponse.map((item) => BookTourModel.fromMap(item)).toList();
    }
    return [];
  }

  Future<List<BookTourModel>> getUserBookTourByDate(dateStart, dateEnd) async {
    Response response = await HandleApis().get(ApiGateway.getUserBookTourByDate,
        'dateStart=$dateStart&dateEnd=$dateEnd');

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];

      if (jsonResponse.isEmpty) {
        return [];
      }

      return jsonResponse.map((item) => BookTourModel.fromMap(item)).toList();
    }
    return [];
  }

  Future<dynamic> bookTour(idTour, codediscount, date) async {
    var body = {"idTour": idTour, "startDate": date};
    var response = await HandleApis().post(ApiGateway.bookTour, body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    if (response.statusCode == 300) {
      return jsonDecode(response.body)['message'];
    }

    return null;
  }

  Future<List<dynamic>> getSheduleOfTour(idTour) async {
    Response response = await HandleApis()
        .get(ApiGateway.getScheduleTourOfTourByEXP, 'idTour=$idTour');
    List<dynamic> jsonResponse = [];
    if (response.statusCode == 200) {
      jsonResponse = jsonDecode(response.body)['data'];

      if (jsonResponse.isEmpty) {
        return [];
      }
      return jsonResponse;
    }
    return jsonResponse;
  }

  Future<dynamic> bookTourPayment(
      idTour, codediscount, typepayment, date) async {
    var body = {
      "idTour": idTour,
      "codediscount": codediscount,
      "typePayment": typepayment,
      "startDate": date
    };
    var response = await HandleApis().post(ApiGateway.bookTourPayment, body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    if (response.statusCode == 300) {
      return jsonDecode(response.body)['message'];
    }

    if (response.statusCode == 404) {
      return jsonDecode(response.body)['message'];
    }
    return null;
  }
}

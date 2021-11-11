import 'dart:convert';

import 'package:flutter_travelapp/models/booktour.dart';
import 'package:flutter_travelapp/repository/api_gateway.dart';
import 'package:flutter_travelapp/repository/base_repository.dart';
import 'package:http/http.dart';

class BookTourRepository {
  Future<List<BookTourModel>> getUserBookTour(skip, limit) async {
    Response response = await HandleApis()
        .get(ApiGateway.getUserBookTour, 'skip=$skip&limit=$limit');
    //print(response.statusCode);
    //print(response.body.toString());
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];

      if (jsonResponse.isEmpty) {
        return [];
      }

      return jsonResponse.map((item) => BookTourModel.fromMap(item)).toList();
    }
    return [];
  }
}

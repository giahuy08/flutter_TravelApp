import 'dart:convert';

import 'package:flutter_travelapp/models/tour.dart';
import 'package:flutter_travelapp/repository/api_gateway.dart';
import 'package:flutter_travelapp/repository/base_repository.dart';
import 'package:http/http.dart';

class TourRepository {
  Future<List<TourModel>> getListTour() async {
    Response response = await HandleApis().get(ApiGateway.getAllTour);
    print(response.statusCode);
    print(response.body.toString());
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

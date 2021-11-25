import 'dart:convert';

import 'package:flutter_travelapp/models/reviewtour.dart';
import 'package:http/http.dart';

import 'package:flutter_travelapp/repository/api_gateway.dart';
import 'package:flutter_travelapp/repository/base_repository.dart';

class ReviewRepository {
  Future<List<ReviewTourModel>> getListReview(idTour) async {
    Response response =
        await HandleApis().get(ApiGateway.getReviewOfTour, 'idTour=$idTour');
    // print(response.statusCode);
    // print(response.body.toString());
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
      if (jsonResponse.isEmpty) {
        return [];
      }
      return jsonResponse.map((item) => ReviewTourModel.fromMap(item)).toList();
    }
    return [];
  }

  Future<String?> createReviewTour(String idTour, String star, String comment) async {
    var body = {
      "idTour": idTour,
      "star": star,
      "comment": comment,
    };
    var response = await HandleApis().post(ApiGateway.createReviewTour, body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    }
    if (response.statusCode == 300) {
      return jsonDecode(response.body)['message'];
    }
    return null;
  }

}

import 'dart:convert';
import 'dart:io';

import 'package:flutter_travelapp/models/reviewtour.dart';
import 'package:flutter_travelapp/providers/user_provider.dart';
import 'package:http/http.dart';

import 'package:flutter_travelapp/repository/api_gateway.dart';
import 'package:flutter_travelapp/repository/base_repository.dart';
import 'package:http/http.dart' as http;

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

  Future<dynamic> createReviewTour(
      String idTour, String star, String comment, File? image) async {
    var request = http.MultipartRequest(
        'POST', Uri.http(root_url, ApiGateway.createReviewTour));
    request.headers["Content-Type"] = 'multipart/form-data';
    request.headers["Authorization"] = 'Bearer ' +
        (userProvider.user == null ? '' : userProvider.user!.token!);
    request.fields['idTour'] = idTour;
    request.fields['star'] = star;
    request.fields['comment'] = comment;
    request.files.add(
      http.MultipartFile.fromBytes(
        "ImagesReview",
        image!.readAsBytesSync(),
        filename: image.path,
      ),
    );
   
    var response = await http.Response.fromStream(await request.send());
    print(response);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    }
    if (response.statusCode == 300) {
      return jsonDecode(response.body)['message'];
    }
    return null;
  }
}

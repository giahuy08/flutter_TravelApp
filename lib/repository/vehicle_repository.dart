import 'dart:convert';
import 'package:flutter_travelapp/models/vehicle.dart';
import 'package:http/http.dart';
import 'package:flutter_travelapp/repository/api_gateway.dart';
import 'package:flutter_travelapp/repository/base_repository.dart';

class VehicleRepository {
  Future<List<VehicleModel>> getListVehicle() async {
    Response response = await HandleApis().get(ApiGateway.getAllVehicle);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body)['data'];

      if (jsonResponse.isEmpty) {
        return [];
      }

      return jsonResponse.map((item) => VehicleModel.fromMap(item)).toList();
    }
    return [];
  }

  Future<dynamic> getOneVehicle(id) async {
    Response response =
        await HandleApis().get(ApiGateway.getOneVehicle, 'id=$id');

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }

    return null;
  }
}

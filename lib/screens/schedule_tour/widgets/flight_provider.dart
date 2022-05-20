import 'package:flutter_travelapp/models/flight_model.dart';
import 'package:flutter_travelapp/screens/schedule_tour/widgets/flights_data.dart';

final List<FlightModel> flightsAvailable = flightsAvailableJson
    .asMap()
    .map((index, value) =>
        MapEntry(index, FlightModel.fromMap(flightsAvailableJson[index])))
    .values
    .toList();

import 'dart:convert';

import 'package:flutter/foundation.dart';

class VehicleModel {
  int type;
  String vehicleNumber;
  List<String> imagesVehicle;
  String name;
  int status;
  final String id;
  VehicleModel({
    required this.type,
    required this.vehicleNumber,
    required this.imagesVehicle,
    required this.name,
    required this.status,
    required this.id,
  });

  VehicleModel copyWith({
    int? type,
    String? vehicleNumber,
    List<String>? imagesVehicle,
    String? name,
    int? status,
    String? id,
  }) {
    return VehicleModel(
      type: type ?? this.type,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      imagesVehicle: imagesVehicle ?? this.imagesVehicle,
      name: name ?? this.name,
      status: status ?? this.status,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'vehicleNumber': vehicleNumber,
      'imagesVehicle': imagesVehicle,
      'name': name,
      'status': status,
      'id': id,
    };
  }

  factory VehicleModel.fromMap(Map<String, dynamic> map) {
    return VehicleModel(
      type: map['type'],
      vehicleNumber: map['vehicleNumber'],
      imagesVehicle: (map['imagesVehicle'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      name: map['name'],
      status: map['status'],
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleModel.fromJson(String source) =>
      VehicleModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VehicleModel(type: $type, vehicleNumber: $vehicleNumber, imagesVehicle: $imagesVehicle, name: $name, status: $status, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VehicleModel &&
        other.type == type &&
        other.vehicleNumber == vehicleNumber &&
        listEquals(other.imagesVehicle, imagesVehicle) &&
        other.name == name &&
        other.status == status &&
        other.id == id;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        vehicleNumber.hashCode ^
        imagesVehicle.hashCode ^
        name.hashCode ^
        status.hashCode ^
        id.hashCode;
  }
}

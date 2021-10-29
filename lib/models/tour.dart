import 'dart:convert';

import 'package:collection/collection.dart';

class TourModel {
  final String idEnterprise;
  final List<String> idVehicle;
  final String detail;
  final String payment;
  final List<String> imagesTour;
  final String id;
  final String name;
  final String place;
  final DateTime createdAt;
  TourModel({
    required this.idEnterprise,
    required this.idVehicle,
    required this.detail,
    required this.payment,
    required this.imagesTour,
    required this.id,
    required this.name,
    required this.place,
    required this.createdAt,
  });

  TourModel copyWith({
    String? idEnterprise,
    List<String>? idVehicle,
    String? detail,
    String? payment,
    List<String>? imagesTour,
    String? id,
    String? name,
    String? place,
    DateTime? createdAt,
  }) {
    return TourModel(
      idEnterprise: idEnterprise ?? this.idEnterprise,
      idVehicle: idVehicle ?? this.idVehicle,
      detail: detail ?? this.detail,
      payment: payment ?? this.payment,
      imagesTour: imagesTour ?? this.imagesTour,
      id: id ?? this.id,
      name: name ?? this.name,
      place: place ?? this.place,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idEnterprise': idEnterprise,
      'idVehicle': idVehicle,
      'detail': detail,
      'payment': payment,
      'imagesTour': imagesTour,
      'id': id,
      'name': name,
      'place': place,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory TourModel.fromMap(Map<String, dynamic> map) {
    return TourModel(
      idEnterprise: map['idEnterprise'],
      idVehicle: List<String>.from(map['idVehicle']),
      detail: map['detail'],
      payment: map['payment'],
      imagesTour: List<String>.from(map['imagesTour']),
      id: map['_id'],
      name: map['name'],
      place: map['place'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TourModel.fromJson(String source) =>
      TourModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TourModel(idEnterprise: $idEnterprise, idVehicle: $idVehicle, detail: $detail, payment: $payment, imagesTour: $imagesTour, id: $id, name: $name, place: $place, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is TourModel &&
        other.idEnterprise == idEnterprise &&
        listEquals(other.idVehicle, idVehicle) &&
        other.detail == detail &&
        other.payment == payment &&
        listEquals(other.imagesTour, imagesTour) &&
        other.id == id &&
        other.name == name &&
        other.place == place &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return idEnterprise.hashCode ^
        idVehicle.hashCode ^
        detail.hashCode ^
        payment.hashCode ^
        imagesTour.hashCode ^
        id.hashCode ^
        name.hashCode ^
        place.hashCode ^
        createdAt.hashCode;
  }
}

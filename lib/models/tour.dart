import 'dart:convert';

import 'package:flutter/foundation.dart';

class TourModel {
  String idEnterprise;
  List<String> idVehicles;
  String detail;
  double? payment;
  List<String> imagesTour;
  double? star;
  int category;
  final String id;
  String name;
  String place;
  String latitude;
  String longtitude;
  String time;
  TourModel(
      {required this.idEnterprise,
      required this.idVehicles,
      required this.detail,
      required this.payment,
      required this.imagesTour,
      required this.star,
      required this.category,
      required this.id,
      required this.name,
      required this.place,
      required this.latitude,
      required this.longtitude,
      required this.time});

  TourModel copyWith({
    String? idEnterprise,
    List<String>? idVehicles,
    String? detail,
    double? payment,
    List<String>? imagesTour,
    double? star,
    int? category,
    String? id,
    String? name,
    String? place,
    String? latitude,
    String? longtitude,
    String? time,
  }) {
    return TourModel(
      idEnterprise: idEnterprise ?? this.idEnterprise,
      idVehicles: idVehicles ?? this.idVehicles,
      detail: detail ?? this.detail,
      payment: payment ?? this.payment,
      imagesTour: imagesTour ?? this.imagesTour,
      star: star ?? this.star,
      category: category ?? this.category,
      id: id ?? this.id,
      name: name ?? this.name,
      place: place ?? this.place,
      latitude: latitude ?? this.latitude,
      longtitude: latitude ?? this.longtitude,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idEnterprise': idEnterprise,
      'idVehicles': idVehicles,
      'detail': detail,
      'payment': payment,
      'imagesTour': imagesTour,
      'star': star,
      'category': category,
      'id': id,
      'name': name,
      'place': place,
      'time': time,
    };
  }

  factory TourModel.fromMap(Map<String, dynamic> map) {
    return TourModel(
      idEnterprise: map['idEnterprise'],
      idVehicles: (map['idVehicles'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      detail: map['detail'],
      payment: double.tryParse((map['payment'] ?? 0).toString()),
      imagesTour: (map['imagesTour'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      star: double.tryParse((map['star'] ?? 0).toString()),
      category: map['category'],
      id: map['_id'],
      name: map['name'],
      place: map['place'],
      latitude: map['latitude'],
      longtitude: map['longtitude'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TourModel.fromJson(String source) =>
      TourModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TourModel(idEnterprise: $idEnterprise, idVehicles: $idVehicles, detail: $detail, payment: $payment, imagesTour: $imagesTour, star: $star, category: $category, id: $id, name: $name, place: $place, latitude:$latitude,longtitude:$longtitude, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TourModel &&
        other.idEnterprise == idEnterprise &&
        listEquals(other.idVehicles, idVehicles) &&
        other.detail == detail &&
        other.payment == payment &&
        listEquals(other.imagesTour, imagesTour) &&
        other.star == star &&
        other.category == category &&
        other.id == id &&
        other.name == name &&
        other.place == place &&
        other.latitude == latitude &&
        other.longtitude == longtitude &&
        other.time == time;
  }

  @override
  int get hashCode {
    return idEnterprise.hashCode ^
        idVehicles.hashCode ^
        detail.hashCode ^
        payment.hashCode ^
        imagesTour.hashCode ^
        star.hashCode ^
        category.hashCode ^
        id.hashCode ^
        name.hashCode ^
        place.hashCode ^
        latitude.hashCode ^
        longtitude.hashCode ^
        time.hashCode;
  }
}

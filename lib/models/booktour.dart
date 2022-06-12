import 'dart:convert';

import 'package:flutter/foundation.dart';

class BookTourModel {
  String? id;
  String idEnterprise;
  List<String> idVehicles;
  String detail;
  double? payment;
  List<String> imagesTour;
  double? star;
  int category;
  final String idTour;
  String name;
  String place;
  String startingplace;
  String time;
  final String idUser;
  int status;
  double? finalpayment;
  DateTime? startDate;
  DateTime? endDate;
  String? nameUser;
  String? phoneUser;
  BookTourModel(
      {this.id,
      required this.idEnterprise,
      required this.idVehicles,
      required this.detail,
      this.payment,
      required this.imagesTour,
      this.star,
      required this.category,
      required this.idTour,
      required this.name,
      required this.place,
      required this.startingplace,
      required this.time,
      required this.idUser,
      required this.status,
      this.finalpayment,
      required this.startDate,
      required this.endDate,
      this.nameUser,
      this.phoneUser});

  BookTourModel copyWith(
      {String? id,
      String? idEnterprise,
      List<String>? idVehicles,
      String? detail,
      double? payment,
      List<String>? imagesTour,
      double? star,
      int? category,
      String? idTour,
      String? name,
      String? place,
      String? startingplace,
      String? time,
      String? idUser,
      int? status,
      double? finalpayment,
      DateTime? startDate,
      DateTime? endDate,
      String? nameUser,
      String? phoneUser}) {
    return BookTourModel(
        id: id ?? this.id,
        idEnterprise: idEnterprise ?? this.idEnterprise,
        idVehicles: idVehicles ?? this.idVehicles,
        detail: detail ?? this.detail,
        payment: payment ?? this.payment,
        imagesTour: imagesTour ?? this.imagesTour,
        star: star ?? this.star,
        category: category ?? this.category,
        idTour: idTour ?? this.idTour,
        name: name ?? this.name,
        place: place ?? this.place,
        startingplace: startingplace ?? this.startingplace,
        time: time ?? this.time,
        idUser: idUser ?? this.idUser,
        status: status ?? this.status,
        finalpayment: finalpayment ?? this.finalpayment,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        nameUser: nameUser ?? this.nameUser,
        phoneUser: phoneUser ?? this.phoneUser);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idEnterprise': idEnterprise,
      'idVehicles': idVehicles,
      'detail': detail,
      'payment': payment,
      'imagesTour': imagesTour,
      'star': star,
      'category': category,
      'idTour': idTour,
      'name': name,
      'place': place,
      'startingplace': startingplace,
      'time': time,
      'idUser': idUser,
      'status': status,
      'finalpayment': finalpayment,
      'startDate': startDate!.millisecondsSinceEpoch,
      'endDate': endDate!.millisecondsSinceEpoch,
      'nameUser': nameUser,
      'phoneUser': phoneUser,
    };
  }

  factory BookTourModel.fromMap(Map<String, dynamic> map) {
    return BookTourModel(
        id: map['_id'],
        idEnterprise: map['idEnterprise'],
        idVehicles: List<String>.from(map['idVehicles']),
        detail: map['detail'],
        payment: double.tryParse((map['payment'] ?? 0).toString()),
        imagesTour: List<String>.from(map['imagesTour']),
        star: double.tryParse((map['star'] ?? 0).toString()),
        category: map['category'],
        idTour: map['idTour'],
        name: map['name'],
        place: map['place'],
        startingplace: map['startingplace'],
        time: map['time'],
        idUser: map['idUser'],
        status: map['status'],
        finalpayment: double.tryParse((map['finalpayment'] ?? 0).toString()),
        startDate: DateTime.parse(map['startDate']),
        endDate: DateTime.parse(map['endDate']),
        nameUser: map['nameUser'],
        phoneUser: map['phoneUser']);
  }

  String toJson() => json.encode(toMap());

  factory BookTourModel.fromJson(String source) =>
      BookTourModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookTourModel(id: $id, idEnterprise: $idEnterprise, idVehicles: $idVehicles, detail: $detail, payment: $payment, imagesTour: $imagesTour, star: $star, category: $category, idTour: $idTour, name: $name, place: $place, startingplace: $startingplace, time: $time, idUser: $idUser, status: $status, finalpayment: $finalpayment, startDate: $startDate, endDate: $endDate, nameUser: $nameUser, phoneUser: $phoneUser)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookTourModel &&
        other.id == id &&
        other.idEnterprise == idEnterprise &&
        listEquals(other.idVehicles, idVehicles) &&
        other.detail == detail &&
        other.payment == payment &&
        listEquals(other.imagesTour, imagesTour) &&
        other.star == star &&
        other.category == category &&
        other.idTour == idTour &&
        other.name == name &&
        other.place == place &&
        other.startingplace == startingplace &&
        other.time == time &&
        other.idUser == idUser &&
        other.status == status &&
        other.finalpayment == finalpayment &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.nameUser == nameUser &&
        other.phoneUser == phoneUser;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idEnterprise.hashCode ^
        idVehicles.hashCode ^
        detail.hashCode ^
        payment.hashCode ^
        imagesTour.hashCode ^
        star.hashCode ^
        category.hashCode ^
        idTour.hashCode ^
        name.hashCode ^
        place.hashCode ^
        startingplace.hashCode ^
        time.hashCode ^
        idUser.hashCode ^
        status.hashCode ^
        finalpayment.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        nameUser.hashCode ^
        phoneUser.hashCode;
  }
}

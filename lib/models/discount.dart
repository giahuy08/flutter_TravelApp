import 'dart:convert';

class DiscountModel {
  final String id;
  String code;
  String discount;
  int status;
  String idTour;
  DiscountModel({
    required this.id,
    required this.code,
    required this.discount,
    required this.status,
    required this.idTour,
  });

  DiscountModel copyWith({
    String? id,
    String? code,
    String? discount,
    int? status,
    String? idTour,
  }) {
    return DiscountModel(
      id: id ?? this.id,
      code: code ?? this.code,
      discount: discount ?? this.discount,
      status: status ?? this.status,
      idTour: idTour ?? this.idTour,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'discount': discount,
      'status': status,
      'idTour': idTour,
    };
  }

  factory DiscountModel.fromMap(Map<String, dynamic> map) {
    return DiscountModel(
      id: map['id'],
      code: map['code'],
      discount: map['discount'],
      status: map['status'],
      idTour: map['idTour'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DiscountModel.fromJson(String source) =>
      DiscountModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DiscountModel(id: $id, code: $code, discount: $discount, status: $status, idTour: $idTour)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DiscountModel &&
        other.id == id &&
        other.code == code &&
        other.discount == discount &&
        other.status == status &&
        other.idTour == idTour;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        code.hashCode ^
        discount.hashCode ^
        status.hashCode ^
        idTour.hashCode;
  }
}

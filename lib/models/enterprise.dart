import 'dart:convert';

class EnterpriseModel {
  final int type;
  final String detail;
  final String logo;
  final String name;
  final String id;
  EnterpriseModel({
    required this.type,
    required this.detail,
    required this.logo,
    required this.name,
    required this.id,
  });

  EnterpriseModel copyWith({
    int? type,
    String? detail,
    String? logo,
    String? name,
    String? id,
  }) {
    return EnterpriseModel(
      type: type ?? this.type,
      detail: detail ?? this.detail,
      logo: logo ?? this.logo,
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'detail': detail,
      'logo': logo,
      'name': name,
      'id': id,
    };
  }

  factory EnterpriseModel.fromMap(Map<String, dynamic> map) {
    return EnterpriseModel(
      type: map['type'],
      detail: map['detail'],
      logo: map['logo'],
      name: map['name'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EnterpriseModel.fromJson(String source) =>
      EnterpriseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EnterpriseModel(type: $type, detail: $detail, logo: $logo, name: $name, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EnterpriseModel &&
        other.type == type &&
        other.detail == detail &&
        other.logo == logo &&
        other.name == name &&
        other.id == id;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        detail.hashCode ^
        logo.hashCode ^
        name.hashCode ^
        id.hashCode;
  }
}

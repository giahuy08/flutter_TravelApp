// ignore_for_file: file_names

import 'dart:convert';

class UserGoogle {
  final String id;
  int? role;
  String? otp;
  String? fcm;
  String? token;
  String? email;
  String? phone;
  String? name;
  String? address;
  String? avatar;
  UserGoogle({
    required this.id,
    this.role,
    this.otp,
    this.fcm,
    this.token,
    this.email,
    this.phone,
    this.name,
    this.address,
    this.avatar,
  });

  factory UserGoogle.fromLogin(Map<String, dynamic> data) {
    return UserGoogle(
      token: data['token'],
      id: '',
      address: '',
      avatar: '',
      email: '',
      fcm: '',
      name: '',
      otp: '',
      phone: '',
      role: null,
    );
  }

  UserGoogle copyWith({
    String? id,
    int? role,
    String? otp,
    String? fcm,
    String? token,
    String? email,
    String? phone,
    String? name,
    String? address,
    String? avatar,
  }) {
    return UserGoogle(
      id: id ?? this.id,
      role: role ?? this.role,
      otp: otp ?? this.otp,
      fcm: fcm ?? this.fcm,
      token: token ?? this.token,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      address: address ?? this.address,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role': role,
      'otp': otp,
      'fcm': fcm,
      'token': token,
      'email': email,
      'phone': phone,
      'name': name,
      'address': address,
      'avatar': avatar,
    };
  }

  factory UserGoogle.fromMap(Map<String, dynamic> map) {
    return UserGoogle(
      id: map['_id'],
      role: map['role'],
      otp: map['otp'],
      fcm: map['fcm'],
      token: map['token'],
      email: map['email'],
      phone: map['phone'],
      name: map['name'],
      address: map['address'],
      avatar: map['avatar'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserGoogle.fromJson(String source) => UserGoogle.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, role: $role, otp: $otp, fcm: $fcm, token: $token, email: $email, phone: $phone, name: $name, address: $address, avatar: $avatar)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserGoogle &&
        other.id == id &&
        other.role == role &&
        other.otp == otp &&
        other.fcm == fcm &&
        other.token == token &&
        other.email == email &&
        other.phone == phone &&
        other.name == name &&
        other.address == address &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        role.hashCode ^
        otp.hashCode ^
        fcm.hashCode ^
        token.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        name.hashCode ^
        address.hashCode ^
        avatar.hashCode;
  }
}


//   User({
//     required this.id,
//     required this.token,
//   });

//   factory User.fromLogin(Map<String, dynamic> data) {
//     return User(
//       token: data['token'],
//       id: '',
//     );
//   }

//   User copyWith({
//     String? id,
//     String? token,
//   }) {
//     return User(
//       id: id ?? this.id,
//       token: token ?? this.token,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'token': token,
//     };
//   }

//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       id: map['id'],
//       token: map['token'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory User.fromJson(String source) => User.fromMap(json.decode(source));

//   @override
//   String toString() => 'User(id: $id, token: $token)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is User && other.id == id && other.token == token;
//   }

//   @override
//   int get hashCode => id.hashCode ^ token.hashCode;
// }



import 'dart:convert';

class UserModel {
   String? id;
  int? role;
  String? otp;
  String? fcm;
  String? token;
  String? email;
  String? phone;
  String? name;
  String? address;
  String? avatar;
  UserModel({
    this.id,
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

  factory UserModel.fromLogin(Map<String, dynamic> data) {
    return UserModel(
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

  UserModel copyWith({
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
    return UserModel(
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

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
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

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, role: $role, otp: $otp, fcm: $fcm, token: $token, email: $email, phone: $phone, name: $name, address: $address, avatar: $avatar)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
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


//   UserModel({
//     required this.id,
//     required this.token,
//   });

//   factory UserModel.fromLogin(Map<String, dynamic> data) {
//     return UserModel(
//       token: data['token'],
//       id: '',
//     );
//   }

//   UserModel copyWith({
//     String? id,
//     String? token,
//   }) {
//     return UserModel(
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

//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       id: map['id'],
//       token: map['token'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

//   @override
//   String toString() => 'UserModel(id: $id, token: $token)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is UserModel && other.id == id && other.token == token;
//   }

//   @override
//   int get hashCode => id.hashCode ^ token.hashCode;
// }

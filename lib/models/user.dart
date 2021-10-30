import 'dart:convert';

class User {
  final String id;
  String token;
  User({
    required this.id,
    required this.token,
  });

  factory User.fromLogin(Map<String, dynamic> data) {
    return User(
      token: data['token'],
      id: '',
    );
  }

  User copyWith({
    String? id,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(id: $id, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.id == id && other.token == token;
  }

  @override
  int get hashCode => id.hashCode ^ token.hashCode;
}

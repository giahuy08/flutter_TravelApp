import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

class Room {
  String idRoom;
  String name;
  List<String> seenByUser;
  String message;
  String avatar;
  DateTime updatedAt;
  Room({
    required this.idRoom,
    required this.name,
    required this.seenByUser,
    required this.message,
    required this.avatar,
    required this.updatedAt,
  });

  Room copyWith({
    String? idRoom,
    String? name,
    List<String>? seenByUser,
    String? message,
    String? avatar,
    DateTime? updatedAt,
  }) {
    return Room(
      idRoom: idRoom ?? this.idRoom,
      name: name ?? this.name,
      seenByUser: seenByUser ?? this.seenByUser,
      message: message ?? this.message,
      avatar: avatar ?? this.avatar,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idRoom': idRoom,
      'name': name,
      'seenByUser': seenByUser,
      'message': message,
      'avatar': avatar,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      idRoom: map['idRoom'] ?? '',
      name: map['name'] ?? '',
      seenByUser: List<String>.from(map['seenByUser']),
      message: map['message'] ?? '',
      avatar: map['avatar'] ?? '',
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Room.fromJson(String source) => Room.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Room(idRoom: $idRoom, name: $name, seenByUser: $seenByUser, message: $message, avatar: $avatar, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Room &&
      other.idRoom == idRoom &&
      other.name == name &&
      listEquals(other.seenByUser, seenByUser) &&
      other.message == message &&
      other.avatar == avatar &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return idRoom.hashCode ^
      name.hashCode ^
      seenByUser.hashCode ^
      message.hashCode ^
      avatar.hashCode ^
      updatedAt.hashCode;
  }
}

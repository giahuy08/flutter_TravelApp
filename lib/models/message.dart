import 'dart:convert';

import 'package:flutter/foundation.dart';

class Message {
  String id;
  String creatorUser;
  List<String> seenByUser;
  bool isDelete;
  String message;
  String idRoom;
  DateTime createdAt;
  DateTime updatedAt;
  Message({
    required this.id,
    required this.creatorUser,
    required this.seenByUser,
    required this.isDelete,
    required this.message,
    required this.idRoom,
    required this.createdAt,
    required this.updatedAt,
  });

  Message copyWith({
    String? id,
    String? creatorUser,
    List<String>? seenByUser,
    bool? isDelete,
    String? message,
    String? idRoom,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Message(
      id: id ?? this.id,
      creatorUser: creatorUser ?? this.creatorUser,
      seenByUser: seenByUser ?? this.seenByUser,
      isDelete: isDelete ?? this.isDelete,
      message: message ?? this.message,
      idRoom: idRoom ?? this.idRoom,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'creatorUser': creatorUser,
      'seenByUser': seenByUser,
      'isDelete': isDelete,
      'message': message,
      'idRoom': idRoom,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['_id'] ?? '',
      creatorUser: map['creatorUser'] ?? '',
      seenByUser: List<String>.from(map['seenByUser']),
      isDelete: map['isDelete'] ?? false,
      message: map['message'] ?? '',
      idRoom: map['idRoom'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Message(id: $id, creatorUser: $creatorUser, seenByUser: $seenByUser, isDelete: $isDelete, message: $message, idRoom: $idRoom, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.id == id &&
        other.creatorUser == creatorUser &&
        listEquals(other.seenByUser, seenByUser) &&
        other.isDelete == isDelete &&
        other.message == message &&
        other.idRoom == idRoom &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        creatorUser.hashCode ^
        seenByUser.hashCode ^
        isDelete.hashCode ^
        message.hashCode ^
        idRoom.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

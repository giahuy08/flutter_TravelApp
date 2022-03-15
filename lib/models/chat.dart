import 'dart:convert';

class ChatModel {
   String id;
  String username;
  String sentAt;
  String message;
  ChatModel({
    required this.id,
    required this.username,
    required this.sentAt,
    required this.message,
  });

  ChatModel copyWith({
    String? id,
    String? username,
    String? sentAt,
    String? message,
  }) {
    return ChatModel(
      id: id ?? this.id,
      username: username ?? this.username,
      sentAt: sentAt ?? this.sentAt,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'sentAt': sentAt,
      'message': message,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      sentAt: map['sentAt'] ?? '',
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatModel(id: $id, username: $username, sentAt: $sentAt, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ChatModel &&
      other.id == id &&
      other.username == username &&
      other.sentAt == sentAt &&
      other.message == message;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      username.hashCode ^
      sentAt.hashCode ^
      message.hashCode;
  }
}

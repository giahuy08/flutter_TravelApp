import 'dart:convert';

import 'package:flutter/foundation.dart';

class ReviewTourModel {
  double? star;
  String comment;
  List<String> imagesReview;
  DateTime createdAt;
  DateTime updatedAt;
  String avatarUser;
  String nameUser;
  ReviewTourModel({
    required this.star,
    required this.comment,
    required this.imagesReview,
    required this.createdAt,
    required this.updatedAt,
    required this.avatarUser,
    required this.nameUser,
  });

  ReviewTourModel copyWith({
    double? star,
    String? comment,
    List<String>? imagesReview,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? avatarUser,
    String? nameUser,
  }) {
    return ReviewTourModel(
      star: star ?? this.star,
      comment: comment ?? this.comment,
      imagesReview: imagesReview ?? this.imagesReview,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      avatarUser: avatarUser ?? this.avatarUser,
      nameUser: nameUser ?? this.nameUser,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'star': star,
      'comment': comment,
      'imagesReview': imagesReview,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'avatarUser': avatarUser,
      'nameUser': nameUser,
    };
  }

  factory ReviewTourModel.fromMap(Map<String, dynamic> map) {
    return ReviewTourModel(
      star: double.tryParse((map['star'] ?? 0).toString()),
      comment: map['comment'],
      imagesReview: List<String>.from(map['imagesReview']),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      avatarUser: map['avatarUser'],
      nameUser: map['nameUser'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewTourModel.fromJson(String source) =>
      ReviewTourModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReviewTourModel(star: $star, comment: $comment, imagesReview: $imagesReview, createdAt: $createdAt, updatedAt: $updatedAt, avatarUser: $avatarUser, nameUser: $nameUser)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReviewTourModel &&
        other.star == star &&
        other.comment == comment &&
        listEquals(other.imagesReview, imagesReview) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.avatarUser == avatarUser &&
        other.nameUser == nameUser;
  }

  @override
  int get hashCode {
    return star.hashCode ^
        comment.hashCode ^
        imagesReview.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        avatarUser.hashCode ^
        nameUser.hashCode;
  }
}

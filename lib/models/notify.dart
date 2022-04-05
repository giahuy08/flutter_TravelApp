import 'dart:convert';

class Notify {
  String? title;
  String? body;
  Notify({
    this.title,
    this.body,
  });
  // dynamic data;

  Notify copyWith({
    String? title,
    String? body,
  }) {
    return Notify(
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
    };
  }

  factory Notify.fromMap(Map<String, dynamic> map) {
    return Notify(
      title: map['title'],
      body: map['body'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Notify.fromJson(String source) =>
      Notify.fromMap(json.decode(source));

  @override
  String toString() => 'Notify(title: $title, body: $body)';
  
  Map<String, dynamic> toStringJson() {
        return {
          "title": this.title,
          "body": this.body,
         
        };
    }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Notify &&
        other.title == title &&
        other.body == body;
  }

  @override
  int get hashCode => title.hashCode ^ body.hashCode;
}

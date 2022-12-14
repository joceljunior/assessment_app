import 'dart:convert';

class Option {
  final int? id;
  final String name;
  Option({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'name': name});

    return result;
  }

  factory Option.fromMap(Map<String, dynamic> map) {
    return Option(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Option.fromJson(Map<String, dynamic> source) =>
      Option.fromMap(source);
}

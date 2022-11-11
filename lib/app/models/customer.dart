import 'dart:convert';

class Customer {
  final int id;
  final String name;
  final String url;
  Customer({
    required this.id,
    required this.name,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'url': url});

    return result;
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      url: map['url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(Map<String, dynamic> source) =>
      Customer.fromMap(source);
}

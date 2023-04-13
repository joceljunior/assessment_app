import 'dart:convert';

class Customer {
  final int id;
  final String name;
  final String url;
  final int idSession;
  String pathLogo;
  Customer({
    required this.id,
    required this.name,
    required this.url,
    required this.idSession,
    this.pathLogo = "assets/logo_pitaco.png",
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'url': url});
    result.addAll({'id_session': idSession});

    return result;
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      url: map['url'] ?? '',
      idSession: map['id_session']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(Map<String, dynamic> source) =>
      Customer.fromMap(source);
}

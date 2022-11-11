import 'dart:convert';

class Question {
  final int id;
  final String question;

  Question({required this.id, required this.question});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'question': question});

    return result;
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id']?.toInt() ?? 0,
      question: map['question'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(Map<String, dynamic> source) =>
      Question.fromMap(source);
}

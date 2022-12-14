import 'dart:convert';

import 'package:assessment_app/app/models/option.dart';

class Question {
  final int id;
  final String question;
  final List<Option>? options;
  Question({
    required this.id,
    required this.question,
    this.options,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'question': question});
    if (options != null) {
      result.addAll({'options': options!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id']?.toInt() ?? 0,
      question: map['question'] ?? '',
      options: map['options'] != null
          ? List<Option>.from(map['options']?.map((x) => Option.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());
  factory Question.fromJson(Map<String, dynamic> source) =>
      Question.fromMap(source);
}

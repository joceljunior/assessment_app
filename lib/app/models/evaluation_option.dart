import 'dart:convert';

class EvaluationOption {
  final int idQuestion;
  final int idSession;
  final int idOption;
  EvaluationOption({
    required this.idQuestion,
    required this.idSession,
    required this.idOption,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'idQuestion': idQuestion});
    result.addAll({'idSession': idSession});
    result.addAll({'idOption': idOption});

    return result;
  }

  factory EvaluationOption.fromMap(Map<String, dynamic> map) {
    return EvaluationOption(
      idQuestion: map['idQuestion']?.toInt() ?? 0,
      idSession: map['idSession']?.toInt() ?? 0,
      idOption: map['idOption']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory EvaluationOption.fromJson(Map<String, dynamic> source) =>
      EvaluationOption.fromMap(source);
}

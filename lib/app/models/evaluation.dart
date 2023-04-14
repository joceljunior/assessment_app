class Evaluation {
  final int idQuestion;
  final int idCustomer;
  final double answer;
  final String comment;
  int idSession;
  final List<int> options;
  Evaluation({
    required this.idQuestion,
    required this.idCustomer,
    required this.answer,
    required this.comment,
    this.idSession = 0,
    required this.options,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id_question': idQuestion});
    result.addAll({'id_customer': idCustomer});
    result.addAll({'answer': answer});
    result.addAll({'comment': comment});
    result.addAll({'id_session': idSession});
    result.addAll({'options': options});

    return result;
  }

  Map<String, dynamic> toJson() => toMap();
}

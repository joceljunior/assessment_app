class Evaluation {
  final int idQuestion;
  final int idCustomer;
  final double answer;
  final String comment;

  Evaluation(this.idQuestion, this.idCustomer, this.answer, this.comment);

  Map<String, dynamic> toJson() {
    return {
      'id_question': idQuestion,
      'id_customer': idCustomer,
      'answer': answer,
      'comment': comment,
    };
  }
}

import '../../../models/question.dart';

abstract class EvaluationState {}

class Initial extends EvaluationState {}

class Loading extends EvaluationState {}

class QuestionsSuccess extends EvaluationState {
  final List<Question> questions;
  bool showOptions;
  QuestionsSuccess({
    required this.questions,
    this.showOptions = false,
  });
}

class EvaluationSuccess extends EvaluationState {}

class ShowOptions extends EvaluationState {
  final bool show;
  ShowOptions({
    required this.show,
  });
}

class Error extends EvaluationState {
  final String message;
  Error({
    required this.message,
  });
}

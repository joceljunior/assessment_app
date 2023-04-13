import '../../../models/question.dart';

abstract class EvaluationState {}

class Initial extends EvaluationState {}

class Loading extends EvaluationState {}

class QuestionsSuccess extends EvaluationState {
  final List<Question> questions;
  QuestionsSuccess({
    required this.questions,
  });
}

class EvaluationSuccess extends EvaluationState {}

class Error extends EvaluationState {
  final String message;
  Error({
    required this.message,
  });
}

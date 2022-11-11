import 'package:assessment_app/app/models/question.dart';

abstract class EvaluationState {}

class Loading implements EvaluationState {}

class SuccessPost implements EvaluationState {}

class Success implements EvaluationState {
  final List<Question> questions;
  Success({
    required this.questions,
  });
}

class Error implements EvaluationState {
  final String message;

  Error({required this.message});
}

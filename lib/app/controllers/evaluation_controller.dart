// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:assessment_app/app/controllers/interfaces/i_evaluation_controller.dart';
import 'package:assessment_app/app/models/evaluation.dart';
import 'package:assessment_app/app/models/question.dart';
import 'package:assessment_app/app/repositories/interfaces/i_evaluation_repository.dart';
import 'package:assessment_app/app/repositories/interfaces/i_question_repository.dart';
import 'package:get_it/get_it.dart';

import '../../core/exception/assessment_failures.dart';

class EvaluationController implements IEvaluationController {
  final IQuestionRespository questionRepository =
      GetIt.I<IQuestionRespository>();
  final IEvaluationRepository evaluationRepository =
      GetIt.I<IEvaluationRepository>();

  @override
  Future<List<Question>> getQuestions({required int customerId}) async {
    try {
      var questions =
          await questionRepository.getQuestions(customerId: customerId);
      return questions;
    } on QuestionFailure catch (e) {
      throw QuestionFailure(message: e.message);
    }
  }

  @override
  Future<bool> postEvaluations(
      {required List<Evaluation> listEvaluations}) async {
    try {
      await evaluationRepository.postEvaluations(evaluations: listEvaluations);
      return true;
    } on QuestionFailure catch (e) {
      throw QuestionFailure(message: e.message);
    }
  }
}

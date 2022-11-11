import 'package:assessment_app/app/models/question.dart';
import 'package:assessment_app/core/exception/assessment_failures.dart';
import 'package:assessment_app/core/interfaces/i_question_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class QuestionRepository implements IQuestionRespository {
  final httpClient = GetIt.I<Dio>();

  @override
  Future<List<Question>> getQuestions({required int customerId}) async {
    try {
      var url =
          'https://assessmentforlearning.herokuapp.com/getQuestions/$customerId';
      var result = await httpClient.get(url);
      var list = result.data['questions'];
      var questions = (list as List).map((e) => Question.fromJson(e)).toList();

      return questions;
    } catch (e) {
      throw QuestionFailure(message: 'Houve uma falha');
    }
  }
}

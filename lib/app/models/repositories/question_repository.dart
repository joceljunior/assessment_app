import 'package:assessment_app/app/models/question.dart';
import 'package:assessment_app/core/exception/assessment_failures.dart';
import 'package:assessment_app/core/interfaces/i_question_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../core/constants.dart';

class QuestionRepository implements IQuestionRespository {
  final httpClient = GetIt.I<Dio>();

  @override
  Future<List<Question>> getQuestions({required int customerId}) async {
    try {
      var url = '${Constants.baseurl}getQuestions/$customerId';
      var response = await httpClient.get(url);
      var data = response.data;
      var questions = (data as List).map((e) => Question.fromJson(e)).toList();

      return questions;
    } catch (e) {
      throw QuestionFailure(message: 'Houve uma falha');
    }
  }
}

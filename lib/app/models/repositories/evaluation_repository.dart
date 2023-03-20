import 'dart:convert';

import 'package:assessment_app/app/models/evaluation.dart';
import 'package:assessment_app/core/interfaces/i_evaluation_repository.dart';
import 'package:dio/dio.dart';

import '../../../core/constants.dart';
import '../../../core/exception/assessment_failures.dart';

class EvaluationRepository implements IEvaluationRepository {
  final Dio httpClient = Dio();
  @override
  Future<bool> postEvaluations({required List<Evaluation> evaluations}) async {
    try {
      var json = jsonEncode(evaluations);
      var urlApi = '${Constants.baseurl}postEvaluation';
      var response = await httpClient.post(urlApi, data: json);
      return true;
    } catch (e) {
      throw EvaluationFailure(message: 'Houve uma falha');
    }
  }
}

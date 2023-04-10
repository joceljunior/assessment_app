import 'package:assessment_app/app/models/question.dart';

import '../../models/evaluation.dart';

abstract class IEvaluationController {
  Future<List<Question>> getQuestions({required int customerId});
  Future<bool> postEvaluations({required List<Evaluation> listEvaluations});
}

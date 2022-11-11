import '../../app/models/evaluation.dart';

abstract class IEvaluationRepository {
  Future<bool> postEvaluations({required List<Evaluation> evaluations});
}

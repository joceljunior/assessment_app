import 'package:assessment_app/app/models/question.dart';

abstract class IQuestionRespository {
  Future<List<Question>> getQuestions({required int customerId});
}

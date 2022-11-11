import 'package:assessment_app/app/models/repositories/evaluation_repository.dart';
import 'package:assessment_app/app/models/repositories/question_repository.dart';
import 'package:assessment_app/core/interfaces/i_customer_repository.dart';
import 'package:assessment_app/app/models/repositories/customer_repository.dart';
import 'package:assessment_app/core/interfaces/i_evaluation_repository.dart';
import 'package:assessment_app/core/interfaces/i_question_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class AssessmentBinds {
  static void setup() {
    GetIt getIt = GetIt.instance;
    getIt.registerSingleton<Dio>(Dio());
    getIt.registerSingleton<ICustomerRepository>(CustomerRepository());
    getIt.registerSingleton<IQuestionRespository>(QuestionRepository());
    getIt.registerSingleton<IEvaluationRepository>(EvaluationRepository());
  }
}

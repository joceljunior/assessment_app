import 'package:assessment_app/app/controllers/interfaces/i_evaluation_controller.dart';
import 'package:assessment_app/app/controllers/interfaces/i_splash_controller.dart';
import 'package:assessment_app/app/controllers/splash_controller.dart';
import 'package:assessment_app/app/repositories/evaluation_repository.dart';
import 'package:assessment_app/app/repositories/question_repository.dart';
import 'package:assessment_app/app/repositories/interfaces/i_customer_repository.dart';
import 'package:assessment_app/app/repositories/customer_repository.dart';
import 'package:assessment_app/app/repositories/interfaces/i_evaluation_repository.dart';
import 'package:assessment_app/app/repositories/interfaces/i_question_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../app/controllers/evaluation_controller.dart';

class AssessmentBinds {
  static void setup() {
    GetIt getIt = GetIt.instance;
    getIt.registerFactory<Dio>(() => Dio());
    getIt.registerLazySingleton<ISplashController>(() => SplashController());
    getIt.registerLazySingleton<IEvaluationController>(
        () => EvaluationController());
    getIt
        .registerLazySingleton<ICustomerRepository>(() => CustomerRepository());
    getIt.registerLazySingleton<IEvaluationRepository>(
        () => EvaluationRepository());
    getIt.registerLazySingleton<IQuestionRespository>(
        () => QuestionRepository());
  }
}

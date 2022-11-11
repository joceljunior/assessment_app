import 'package:assessment_app/app/models/evaluation.dart';
import 'package:assessment_app/app/models/question.dart';
import 'package:assessment_app/core/interfaces/i_evaluation_repository.dart';
import 'package:assessment_app/core/interfaces/i_question_repository.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../core/exception/assessment_failures.dart';
import '../../core/states/evaluation_states.dart';

class EvaluationController extends ValueNotifier<EvaluationState> {
  EvaluationController() : super(Loading());
  IQuestionRespository repository = GetIt.I<IQuestionRespository>();
  IEvaluationRepository repositoryEvaluation = GetIt.I<IEvaluationRepository>();

  List<Evaluation> listEvaluations = [];
  List<Question> listQuestions = [];
  Question questionItem = Question(id: 0, question: '');
  double answerSelected = 0;
  int customerId = 0;
  TextEditingController commentController = TextEditingController();
  CarouselController sliderController = CarouselController();
  int index = 0;
  int indexCurrent = 0;
  bool returnQUestion = false;
  bool showButtonSend = true;

  Future getQuestions() async {
    sendState(Loading());
    try {
      var questions = await repository.getQuestions(customerId: customerId);
      sendState(Success(questions: questions));
    } on QuestionFailure catch (e) {
      sendState(Error(message: e.message));
    }
  }

  Future postEvaluations() async {
    sendState(Loading());
    try {
      await repositoryEvaluation.postEvaluations(evaluations: listEvaluations);
      sendState(SuccessPost());
    } on QuestionFailure catch (e) {
      sendState(Error(message: e.message));
    }
  }

  sendState(EvaluationState state) {
    value = state;
  }

  @override
  void dispose() {
    listEvaluations = [];
    listQuestions = [];
    questionItem = Question(id: 0, question: '');
    answerSelected = 0;
    customerId = 0;
    commentController = TextEditingController();
    sliderController = CarouselController();
    index = 0;
    indexCurrent = 0;
    returnQUestion = false;
    showButtonSend = true;
    super.dispose();
  }
}

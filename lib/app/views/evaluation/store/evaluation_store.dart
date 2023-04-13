import 'package:assessment_app/app/controllers/interfaces/i_evaluation_controller.dart';
import 'package:assessment_app/app/models/question.dart';
import 'package:assessment_app/app/views/evaluation/store/evaluation_states.dart';
import 'package:assessment_app/core/exception/assessment_failures.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../models/evaluation.dart';

class EvaluationStore extends ValueNotifier<EvaluationState> {
  EvaluationStore() : super(Initial());
  final IEvaluationController controller = GetIt.I<IEvaluationController>();

  List<Evaluation> evaluations = [];
  List<Question> questions = [];
  TextEditingController commentController = TextEditingController();
  CarouselController sliderController = CarouselController();
  bool showButtonSend = true;
  bool showOption = false;
  double answerSelected = 0;
  Question currentQuestion = Question(id: 0, question: "");

  int index = 0;

  Future<void> getQuestions({required int customerId}) async {
    value = Loading();
    try {
      var questionsList = await controller.getQuestions(customerId: customerId);
      questions = questionsList;
      value = QuestionsSuccess(questions: questions);
    } on QuestionFailure catch (e) {
      value = Error(message: e.message);
    }
  }

  Future<void> postEvaluations() async {
    value = Loading();
    try {
      await controller.postEvaluations(listEvaluations: evaluations);
      value = EvaluationSuccess();
    } on EvaluationFailure catch (e) {
      value = Error(message: e.message);
    }
  }

  void showOptions() {
    if (answerSelected <= 3 &&
        currentQuestion.options != null &&
        currentQuestion.options!.isNotEmpty) {
      value = ShowOptions(show: true);
    } else {
      value = ShowOptions(show: false);
    }
  }
}

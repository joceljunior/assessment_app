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
  TextEditingController commentController = TextEditingController();
  CarouselController sliderController = CarouselController();
  bool showButtonSend = true;
  bool showOption = false;
  double answerSelected = 0;
  Question currentQuestion = Question(id: 0, question: "");

  Future<void> getQuestions({required int customerId}) async {
    value = Loading();
    try {
      var questions = await controller.getQuestions(customerId: customerId);
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

  // void showOptions() {
  //   if (answerSelected <= 3 &&
  //       questionItem.options != null &&
  //       questionItem.options!.isNotEmpty) {
  //     emit(ShowOptionsWidget());
  //   } else {
  //     emit(HideOptionsWidget());
  //   }
  // }

  void dispose() {
    // listEvaluations = [];
    // listQuestions = [];
    // questionItem = Question(id: 0, question: '');
    // answerSelected = 0;
    // customerId = 0;
    // commentController = TextEditingController();
    // sliderController = CarouselController();
    // index = 0;
    // indexCurrent = 0;
    // returnQuestion = false;
    // showButtonSend = true;
  }
}

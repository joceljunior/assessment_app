import 'package:assessment_app/app/controllers/interfaces/i_evaluation_controller.dart';
import 'package:assessment_app/app/views/evaluation/bloc/evaluation_states.dart';
import 'package:assessment_app/core/exception/assessment_failures.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../models/evaluation.dart';
import '../../../models/question.dart';

class EvaluationBloc {
  final state = ValueNotifier<EvaluationState>(Initial());
  final IEvaluationController controller = GetIt.I<IEvaluationController>();

  List<Evaluation> listEvaluations = [];
  List<Question> listQuestions = [];
  Question questionItem = Question(id: 0, question: '');
  double answerSelected = 0;
  int customerId = 0;
  TextEditingController commentController = TextEditingController();
  CarouselController sliderController = CarouselController();
  int index = 0;
  int indexCurrent = 0;
  bool returnQuestion = false;
  bool showButtonSend = true;
  bool showOption = false;

  Future<void> getQuestions() async {
    try {
      state.value = Loading();
      var questions = await controller.getQuestions(customerId: customerId);
      state.value = QuestionsSuccess(questions: questions);
    } on QuestionFailure catch (e) {
      state.value = Error(message: e.message);
    }
  }

  Future<void> postEvaluations() async {
    try {
      state.value = Loading();
      await controller.postEvaluations(listEvaluations: listEvaluations);
      state.value = EvaluationSuccess();
    } on EvaluationFailure catch (e) {
      state.value = Error(message: e.message);
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
    listEvaluations = [];
    listQuestions = [];
    questionItem = Question(id: 0, question: '');
    answerSelected = 0;
    customerId = 0;
    commentController = TextEditingController();
    sliderController = CarouselController();
    index = 0;
    indexCurrent = 0;
    returnQuestion = false;
    showButtonSend = true;
  }
}

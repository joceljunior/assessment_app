import 'package:assessment_app/app/views/evaluation/store/evaluation_states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../core/widgets/bottom_sheet_widget.dart';
import '../../models/evaluation.dart';
import 'store/evaluation_store.dart';
import 'widgets/form_comment_evaluation_widget.dart';
import 'widgets/options_evaluation_widget.dart';
import 'widgets/rating_evaluation_widget.dart';
import 'widgets/row_button_evaluation_widget.dart';
import 'widgets/steps_evaluation_widget.dart';

class EvaluationPage extends StatefulWidget {
  final int customerId;
  const EvaluationPage({super.key, required this.customerId});

  @override
  State<EvaluationPage> createState() => _EvaluationPageState();
}

final EvaluationStore store = GetIt.I<EvaluationStore>();

class _EvaluationPageState extends State<EvaluationPage> {
  @override
  void initState() {
    store.getQuestions(customerId: widget.customerId);
    listener();
    super.initState();
  }

  @override
  void dispose() {
    store.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ValueListenableBuilder<EvaluationState>(
        valueListenable: store,
        builder: (context, state, child) {
          if (state is Loading || state is EvaluationSuccess) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
          if (state is Error) {
            return Center(
              child: Text(state.message),
            );
          }

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: size.height * 0.70,
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: CarouselSlider.builder(
                      carouselController: store.sliderController,
                      options: CarouselOptions(
                        aspectRatio: 16 / 15,
                        viewportFraction: 0.9,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        reverse: false,
                        autoPlay: false,
                        autoPlayCurve: Curves.elasticIn,
                        enlargeCenterPage: true,
                        scrollPhysics: NeverScrollableScrollPhysics(),
                        onPageChanged: (index, reason) {
                          setState(() {
                            store.answerSelected = 0;
                            store.showOption = false;
                            store.commentController.clear();
                            // store.optionsSlected.clear();
                          });
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                      itemCount: store.questions.length,
                      itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) {
                        store.currentQuestion = store.questions[store.index];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // QUESTIONS
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(store.currentQuestion.question,
                                  style: TextStyle(fontSize: 20)),
                            ),
                            // RATING
                            RatingEvaluationWidget(
                              onUpdateRating: ((rating) {
                                print(rating);
                                store.answerSelected = rating;
                                store.showOptions();
                              }),
                            ),

                            // COMMENT
                            FormCommentEvaluationWidget(
                              controller: store.commentController,
                            ),
                            // STEPS
                            StepsEvaluationWidget(
                              currentStep: store.index,
                              totelSteps: store.questions.length,
                            ),
                            // OPTIONS
                            OptionsEvaluationWidget(
                              show: store.showOption,
                              options: store.currentQuestion.options!,
                              optionSelected: (values) {
                                store.optionsSelected = values;
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  //Buton
                  RowButtonEvaluationWidget(
                    showButtonReturn: false,
                    showButtonSend: store.showButtonSend,
                    onPressedEvaluate: () {
                      if (checkAnswerSelected(context)) {
                        updateIndex();
                        createEvaluation();
                        nextAction();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomSheet: BottomSheetWidget(),
    );
  }

  void nextAction() {
    if (store.index >= store.questions.length) {
      store.postEvaluations();
    } else {
      store.sliderController.nextPage();
    }
  }

  void createEvaluation() {
    final Evaluation evaluation = Evaluation(
      idQuestion: store.currentQuestion.id,
      idCustomer: widget.customerId,
      answer: store.answerSelected,
      comment: store.commentController.text,
      options: store.optionsSelected,
    );

    store.evaluations.add(evaluation);
  }

  bool checkAnswerSelected(BuildContext context) {
    if (store.answerSelected == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Selecione uma nota'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
      return false;
    }

    return true;
  }

  void updateIndex() {
    setState(() {
      store.index++;
    });
  }

  void listener() {
    store.addListener(() {
      var state = store.value;
      if (state is ShowOptions) {
        setState(() {
          store.showOption = state.show;
        });
      }
      if (state is EvaluationSuccess) {
        Navigator.pushNamed(context, "/checkout");
      }
    });
  }
}

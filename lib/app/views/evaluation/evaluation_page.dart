import 'package:assessment_app/app/views/evaluation/store/evaluation_states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../models/evaluation.dart';
import 'store/evaluation_store.dart';
import 'widgets/options_widget.dart';
import 'widgets/row_button_evaluation_widget.dart';

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
      body: ValueListenableBuilder<EvaluationState>(
        valueListenable: store,
        builder: (context, state, child) {
          if (state is Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is Error) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is QuestionsSuccess) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
                  child: Container(
                    height: size.height,
                    width: size.width,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: size.height * 0.5,
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
                                //  store.index = index;
                                // if (controller.itemIndex <
                                //     controller.listEvaluations.length) {
                                //   getDefaultValues(index: controller.index);
                                // }
                              },
                              scrollDirection: Axis.horizontal,
                            ),
                            itemCount: state.questions.length,
                            itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) {
                              store.currentQuestion = state.questions[itemIndex];
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  // QUESTIONS
                                  Text(store.currentQuestion.question,
                                      style: TextStyle(fontSize: 20)),

                                  // RATING
                                  RatingBar.builder(
                                    // initialRating: evaluationController.answerSelected,
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    glow: false, //brilho
                                    itemSize: size.height * 0.08,
                                    wrapAlignment: WrapAlignment.end,
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (double rating) {
                                      store.answerSelected = rating;
                                      //! store.showOptions();
                                    },
                                  ),

                                  //OPTIONS
                                  Visibility(
                                    visible: store.showOption,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        "Selecione um ou mais problemas",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),

                                  Visibility(
                                    visible: store.showOption,
                                    child: OptionsWidget(
                                      options: store.currentQuestion.options!,
                                    ),
                                  ),
                                  // END OPTIONS
                                  const SizedBox(height: 20),

                                  //COMMENT
                                  TextFormField(
                                    controller: store.commentController,
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                        color: Colors.black45,
                                      ),
                                      hintText: 'Deixe um comentário',
                                    ),
                                  ),

                                  //STEPS
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: StepProgressIndicator(
                                      totalSteps: state.questions.length,
                                      currentStep: itemIndex,
                                      size: 8,
                                      padding: 0,
                                      selectedColor: Colors.yellow,
                                      unselectedColor: Colors.cyan,
                                      roundedEdges: Radius.circular(10),
                                      selectedGradientColor: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color.fromARGB(255, 33, 150, 243),
                                          Color.fromRGBO(144, 202, 249, 1)
                                        ],
                                      ),
                                      unselectedGradientColor: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.black45,
                                          Colors.black38
                                        ],
                                      ),
                                    ),
                                  )
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
                                            var evaluation = Evaluation(
                  store.currentQuestion.id,
                  store.currentQuestion.,
                  store.answerSelected,
                  store.commentController.text,
                );

                // if (store.answerSelected != 0) {
                //   var value = Evaluation(
                //     store.questionItem.id,
                //     store.customerId,
                //     store.answerSelected,
                //     store.commentController.text,
                //   );

                //   if (store.returnQuestion) {
                //     // var itemSelected = controller.listEvaluations
                //     //     .firstWhere((element) =>
                //     //         element.idQuestion == value.idQuestion);
                //     // controller.listEvaluations.remove(itemSelected);
                //     store.listEvaluations
                //         .setAll(store.index, [value]);
                //   } else {
                //     store.listEvaluations.add(value);
                //   }
                //   store.commentController.clear();
                //   store.returnQuestion = false;
                //   store.answerSelected = 0;
                //   if (store.listQuestions.length - 1 >
                //       store.index) {
                //     store.sliderController.nextPage();
                //   } else {
                //     setState(() {
                //       store.showButtonSend = false;
                //       store.indexCurrent++;
                //     });
                //     await store.postEvaluations();
                //     Navigator.of(context).pushNamed(
                //         '/checkout/${store.listQuestions.length}/${widget.customerId}');
                //   }
                // } else {
                //   ScaffoldMessenger.of(context)
                //       .showSnackBar(SnackBar(
                //     content: Text('Selecione uma nota'),
                //     duration: Duration(seconds: 2),
                //     backgroundColor: Colors.red,
                //   ));
                // }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}

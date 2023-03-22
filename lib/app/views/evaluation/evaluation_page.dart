import 'package:assessment_app/app/views/evaluation/widgets/options_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../core/states/evaluation_states.dart';
import '../../controllers/evaluation_controller.dart';
import '../../models/evaluation.dart';

class EvaluationPage extends StatefulWidget {
  final String? customerId;
  const EvaluationPage({super.key, required this.customerId});

  @override
  State<EvaluationPage> createState() => _EvaluationPageState();
}

EvaluationController evaluationController = EvaluationController();

class _EvaluationPageState extends State<EvaluationPage> {
  @override
  void initState() {
    evaluationController.indexCurrent = 0;
    evaluationController.customerId = int.parse(widget.customerId == null ? '0' : widget.customerId!);
    evaluationController.getQuestions();

    super.initState();
  }

  @override
  void dispose() {
    evaluationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // AppBarLogoWidget(
                //   size: size,
                //   customerId: int.parse(
                //       widget.customerId == null ? '0' : widget.customerId!),
                // ),
                Container(
                  height: size.height * 0.2,
                  color: Colors.grey.shade100,
                ),

                Container(
                  height: size.height * 0.5,
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: BlocConsumer<EvaluationController, EvaluationState>(
                      bloc: evaluationController,
                      listener: (context, state) {
                        if (state is Success) {
                          evaluationController.listQuestions = state.questions;
                        }

                        if (state is ShowOptionsWidget) {
                          evaluationController.showOption = true;
                        }

                        if (state is HideOptionsWidget) {
                          evaluationController.showOption = false;
                        }
                      },
                      builder: (context, state) {
                        if (state is Loading) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (state is Error) {
                          return Center(
                            child: Text(state.message),
                          );
                        }

                        return CarouselSlider.builder(
                            carouselController: evaluationController.sliderController,
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
                                evaluationController.index = index;
                                // if (controller.itemIndex <
                                //     controller.listEvaluations.length) {
                                //   getDefaultValues(index: controller.index);
                                // }
                              },
                              scrollDirection: Axis.horizontal,
                            ),
                            itemCount: evaluationController.listQuestions.length,
                            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                              evaluationController.questionItem = evaluationController.listQuestions[itemIndex];
                              evaluationController.indexCurrent = itemIndex;

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(evaluationController.questionItem.question, style: TextStyle(fontSize: 20)),

                                  // Starts Rating
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
                                      evaluationController.answerSelected = rating;
                                      evaluationController.showOptions();
                                    },
                                  ),

                                  // Problems options
                                  Visibility(
                                    visible: evaluationController.showOption,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        "Selecione um ou mais problemas",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(height: 5),

                                  Visibility(
                                    visible: evaluationController.showOption,
                                    child: OptionsWidget(
                                      options: evaluationController.questionItem.options!,
                                    ),
                                  ),

                                  const SizedBox(height: 20),
//até aqui
                                  TextFormField(
                                    controller: evaluationController.commentController,
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

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: StepProgressIndicator(
                                      totalSteps: evaluationController.listQuestions.length,
                                      currentStep: evaluationController.indexCurrent,
                                      size: 8,
                                      padding: 0,
                                      selectedColor: Colors.yellow,
                                      unselectedColor: Colors.cyan,
                                      roundedEdges: Radius.circular(10),
                                      selectedGradientColor: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [Color.fromARGB(255, 33, 150, 243), Color.fromRGBO(144, 202, 249, 1)],
                                      ),
                                      unselectedGradientColor: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [Colors.black45, Colors.black38],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            });
                      }),
                ),
                Row(
                  mainAxisAlignment: /*controller.index*/ 0 == 0 ? MainAxisAlignment.center : MainAxisAlignment.spaceAround,
                  children: [
                    Visibility(
                      visible: /*controller.index != 0*/ false,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: size.height * 0.08),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.04,
                                horizontal: size.height * 0.07,
                              ),
                              elevation: 5,
                              backgroundColor: Colors.white24,
                              side: BorderSide(width: 1, color: Color.fromARGB(78, 0, 0, 0))),
                          child: Text(
                            'VOLTAR',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            evaluationController.returnQuestion = true;
                            evaluationController.answerSelected = 0;
                            evaluationController.sliderController.previousPage();
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: evaluationController.showButtonSend,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: size.height * 0.08),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.03,
                                horizontal: size.height * 0.07,
                              ),
                              elevation: 5,
                              backgroundColor: Color.fromARGB(255, 27, 115, 231),
                              side: BorderSide(width: 1, color: Color.fromARGB(78, 0, 0, 0))),
                          child: Text(
                            'AVALIAR',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            if (evaluationController.answerSelected != 0) {
                              var value = Evaluation(
                                evaluationController.questionItem.id,
                                evaluationController.customerId,
                                evaluationController.answerSelected,
                                evaluationController.commentController.text,
                              );

                              if (evaluationController.returnQuestion) {
                                // var itemSelected = controller.listEvaluations
                                //     .firstWhere((element) =>
                                //         element.idQuestion == value.idQuestion);
                                // controller.listEvaluations.remove(itemSelected);
                                evaluationController.listEvaluations.setAll(evaluationController.index, [value]);
                              } else {
                                evaluationController.listEvaluations.add(value);
                              }
                              evaluationController.commentController.clear();
                              evaluationController.returnQuestion = false;
                              evaluationController.answerSelected = 0;
                              if (evaluationController.listQuestions.length - 1 > evaluationController.index) {
                                evaluationController.sliderController.nextPage();
                              } else {
                                setState(() {
                                  evaluationController.showButtonSend = false;
                                  evaluationController.indexCurrent++;
                                });
                                await evaluationController.postEvaluations();
                                GoRouter.of(context).go('/checkout/${evaluationController.listQuestions.length}/${widget.customerId}');
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Selecione uma nota'),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getDefaultValues({required int index}) {
    var existItem = evaluationController.listEvaluations[index];
    evaluationController.answerSelected = existItem.answer;
    evaluationController.commentController.text = existItem.comment;
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:assessment_app/app/controllers/evaluation_controller.dart';
import 'package:assessment_app/app/models/evaluation.dart';
import 'package:assessment_app/core/states/evaluation_states.dart';
import 'package:assessment_app/core/widgets/app_bar_logo_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../models/question.dart';

class EvaluationPage extends StatefulWidget {
  final String? customerId;
  const EvaluationPage({super.key, required this.customerId});

  @override
  State<EvaluationPage> createState() => _EvaluationPageState();
}

EvaluationController controller = EvaluationController();

class _EvaluationPageState extends State<EvaluationPage> {
  List<Widget> options = <Widget>[
    Text('Limpeza', style: TextStyle(fontSize: 20)),
    Text('Educação', style: TextStyle(fontSize: 20)),
    Text('Muito caro', style: TextStyle(fontSize: 20))
  ];
  final List<bool> _selectedVegetables = <bool>[false, true, false];

  @override
  void initState() {
    controller.indexCurrent = 0;
    controller.customerId =
        int.parse(widget.customerId == null ? '0' : widget.customerId!);
    controller.getQuestions();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
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
                  color: Colors.red,
                ),
                Container(
                  height: size.height * 0.6,
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: ValueListenableBuilder<EvaluationState>(
                      valueListenable: controller,
                      builder: (context, state, child) {
                        if (state is Loading) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (state is Error) {
                          return Center(
                            child: Text(state.message),
                          );
                        }

                        if (state is Success) {
                          controller.listQuestions = state.questions;
                          return CarouselSlider.builder(
                              carouselController: controller.sliderController,
                              options: CarouselOptions(
                                aspectRatio: 16 / 20,
                                viewportFraction: 0.9,
                                initialPage: 0,
                                enableInfiniteScroll: false,
                                reverse: false,
                                autoPlay: false,
                                autoPlayCurve: Curves.elasticIn,
                                enlargeCenterPage: true,
                                scrollPhysics: NeverScrollableScrollPhysics(),
                                onPageChanged: (index, reason) {
                                  controller.index = index;

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
                                controller.questionItem =
                                    state.questions[itemIndex];
                                controller.indexCurrent = itemIndex;

                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(controller.questionItem.question,
                                        style: TextStyle(fontSize: 20)),
                                    RatingBar.builder(
                                      initialRating: controller.answerSelected,
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
                                      onRatingUpdate: (rating) {
                                        controller.answerSelected = rating;
                                        if ((controller.answerSelected) > 3) {
                                          controller.menorIgual = false;
                                        } else {
                                          setState(() {
                                            controller.menorIgual = true;
                                          });
                                        }
                                        print(rating);
                                      },
                                    ),
                                    Visibility(
                                        visible: controller.menorIgual,
                                        child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text(
                                              "Selecione um ou mais problemas",
                                              style: TextStyle(fontSize: 20),
                                            ))),

                                    //if (controller.answerSelected <=(3)) {
                                    //return
                                    // Padding(
                                    //   padding: const EdgeInsets.all(20.0),
                                    //   child: Text(
                                    //     "Selecione um ou mais problemas",
                                    //     style: TextStyle(fontSize: 20),
                                    //   ),
                                    // ),

                                    // ToggleButtons(
                                    //     children: options,
                                    //     isSelected: _selectedVegetables),
// ToggleButtons with a multiple selection.
                                    //const SizedBox(height: 5),
                                    // ToggleButtons(
                                    //   onPressed: (int index) {
                                    //     // All buttons are selectable.
                                    //     setState(() {
                                    //       _selectedVegetables[index] =
                                    //           !_selectedVegetables[index];
                                    //     });
                                    //   },
                                    //   borderRadius: const BorderRadius.all(
                                    //       Radius.circular(8)),
                                    //   selectedBorderColor:
                                    //       Color.fromARGB(255, 255, 255, 255),
                                    //   selectedColor: Colors.white,
                                    //   fillColor: Color.fromARGB(255, 0, 0, 0),
                                    //   color: Color.fromARGB(255, 0, 0, 0),
                                    //   constraints: const BoxConstraints(
                                    //     minHeight: 50.0,
                                    //     minWidth: 110.0,
                                    //   ),
                                    //   isSelected: _selectedVegetables,
                                    //   children: options,
                                    // ),
                                    // const SizedBox(height: 20),
//até aqui
                                    TextFormField(
                                      controller: controller.commentController,
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: StepProgressIndicator(
                                        totalSteps: state.questions.length,
                                        currentStep: controller.indexCurrent,
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
                                            Color.fromRGBO(144, 202, 249, 1)!
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
                              });
                        } else {
                          return Container();
                        }
                      }),
                ),
                Row(
                  mainAxisAlignment: /*controller.index*/ 0 == 0
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceAround,
                  children: [
                    Visibility(
                      visible: /*controller.index != 0*/ false,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.08),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.04,
                                horizontal: size.height * 0.07,
                              ),
                              elevation: 5,
                              backgroundColor: Colors.white24,
                              side: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(78, 0, 0, 0))),
                          child: Text(
                            'VOLTAR',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            controller.returnQUestion = true;
                            controller.answerSelected = 0;
                            controller.sliderController.previousPage();
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.showButtonSend,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.08),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.04,
                                horizontal: size.height * 0.07,
                              ),
                              elevation: 5,
                              backgroundColor:
                                  Color.fromARGB(255, 27, 115, 231),
                              side: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(78, 0, 0, 0))),
                          child: Text(
                            'AVALIAR',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            if (controller.answerSelected != 0) {
                              var value = Evaluation(
                                controller.questionItem.id,
                                controller.customerId,
                                controller.answerSelected,
                                controller.commentController.text,
                              );
                              if (controller.returnQUestion) {
                                // var itemSelected = controller.listEvaluations
                                //     .firstWhere((element) =>
                                //         element.idQuestion == value.idQuestion);
                                // controller.listEvaluations.remove(itemSelected);
                                controller.listEvaluations
                                    .setAll(controller.index, [value]);
                              } else {
                                controller.listEvaluations.add(value);
                              }
                              controller.commentController.clear();
                              controller.returnQUestion = false;
                              controller.answerSelected = 0;
                              if (controller.listQuestions.length - 1 >
                                  controller.index) {
                                controller.sliderController.nextPage();
                              } else {
                                setState(() {
                                  controller.showButtonSend = false;
                                  controller.indexCurrent++;
                                });
                                await controller.postEvaluations();
                                GoRouter.of(context).go(
                                    '/checkout/${controller.listQuestions.length}/${widget.customerId}');
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
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
    var existItem = controller.listEvaluations[index];
    controller.answerSelected = existItem.answer;
    controller.commentController.text = existItem.comment;
  }
}

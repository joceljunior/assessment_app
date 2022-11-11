import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:assessment_app/app/controllers/evaluation_controller.dart';
import 'package:assessment_app/app/models/evaluation.dart';
import 'package:assessment_app/core/states/evaluation_states.dart';
import 'package:assessment_app/core/widgets/app_bar_logo_widget.dart';
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
  @override
  void initState() {
    controller.customerId =
        int.parse(widget.customerId == null ? '0' : widget.customerId!);
    controller.getQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AppBarLogoWidget(
                size: size,
                customerId: int.parse(
                    widget.customerId == null ? '0' : widget.customerId!),
              ),
            ),
            Expanded(
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
                            aspectRatio: 16 / 9,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(controller.questionItem.question,
                                      style: TextStyle(fontSize: 20)),
                                ),
                                Expanded(
                                  child: RatingBar.builder(
                                    initialRating: controller.answerSelected,
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      controller.answerSelected = rating;
                                      print(rating);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: controller.commentController,
                                    maxLines: 2,
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
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: StepProgressIndicator(
                                    totalSteps: state.questions.length,
                                    currentStep: controller.indexCurrent,
                                    size: 36,
                                    selectedColor: Colors.blue,
                                    unselectedColor: Colors.grey,
                                    customStep: (index, color, _) =>
                                        color == Colors.blue
                                            ? Container(
                                                color: color,
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Container(
                                                color: color,
                                                child: Icon(
                                                  Icons.remove,
                                                ),
                                              ),
                                  ),
                                )
                              ],
                            );
                          });
                    } else {
                      return SizedBox(
                        height: size.height * 0.3,
                        width: size.width,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'Obrigado pelo seu feedback!',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 10),
                                child: StepProgressIndicator(
                                  totalSteps: controller.listQuestions.length,
                                  currentStep: controller.indexCurrent,
                                  size: 36,
                                  selectedColor: Colors.blue,
                                  unselectedColor: Colors.grey,
                                  customStep: (index, color, _) =>
                                      color == Colors.blue
                                          ? Container(
                                              color: color,
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                              ),
                                            )
                                          : Container(
                                              color: color,
                                              child: Icon(
                                                Icons.remove,
                                              ),
                                            ),
                                ),
                              )
                            ]),
                      );
                    }
                  }),
            ),
            Expanded(
              child: Row(
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
                                width: 1, color: Color.fromARGB(78, 0, 0, 0))),
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
                    visible:
                        controller.listQuestions.length - 1 < controller.index,
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
                            backgroundColor: Color.fromARGB(255, 27, 115, 231),
                            side: BorderSide(
                                width: 1, color: Color.fromARGB(78, 0, 0, 0))),
                        child: Text(
                          'AVALIAR',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
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
                              controller.indexCurrent++;
                            });
                            controller.postEvaluations();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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

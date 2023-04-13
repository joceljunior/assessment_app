import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class StepsEvaluationWidget extends StatefulWidget {
  final int totelSteps;
  final int currentStep;
  const StepsEvaluationWidget({
    Key? key,
    required this.totelSteps,
    required this.currentStep,
  }) : super(key: key);

  @override
  State<StepsEvaluationWidget> createState() => _StepsEvaluationWidgetState();
}

class _StepsEvaluationWidgetState extends State<StepsEvaluationWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: StepProgressIndicator(
        totalSteps: widget.totelSteps,
        currentStep: widget.currentStep,
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
          colors: [Colors.black45, Colors.black38],
        ),
      ),
    );
  }
}

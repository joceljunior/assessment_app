import 'package:flutter/material.dart';

class RowButtonEvaluationWidget extends StatefulWidget {
  final bool showButtonReturn;
  final bool showButtonSend;
  final Function onPressedEvaluate;
  const RowButtonEvaluationWidget(
      {super.key,
      required this.showButtonReturn,
      required this.showButtonSend,
      required this.onPressedEvaluate});

  @override
  State<RowButtonEvaluationWidget> createState() =>
      _RowButtonEvaluationWidgetState();
}

class _RowButtonEvaluationWidgetState extends State<RowButtonEvaluationWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: /*controller.index*/ 0 == 0
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceAround,
      children: [
        Visibility(
          visible: /*widget.showButtonReturn*/ false,
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
                  side:
                      BorderSide(width: 1, color: Color.fromARGB(78, 0, 0, 0))),
              child: Text(
                'VOLTAR',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                // store.returnQuestion = true;
                // store.answerSelected = 0;
                // store.sliderController.previousPage();
              },
            ),
          ),
        ),
        Visibility(
          visible: widget.showButtonSend,
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
                  side:
                      BorderSide(width: 1, color: Color.fromARGB(78, 0, 0, 0))),
              child: Text(
                'AVALIAR',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                widget.onPressedEvaluate();
              },
            ),
          ),
        ),
      ],
    );
  }
}

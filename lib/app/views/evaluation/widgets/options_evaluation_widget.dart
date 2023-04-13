import 'package:flutter/material.dart';

import 'package:assessment_app/app/models/option.dart';

import 'options_item_widget.dart';

class OptionsEvaluationWidget extends StatefulWidget {
  final List<Option> options;
  final bool show;
  const OptionsEvaluationWidget({
    Key? key,
    required this.options,
    required this.show,
  }) : super(key: key);

  @override
  State<OptionsEvaluationWidget> createState() =>
      _OptionsEvaluationWidgetState();
}

class _OptionsEvaluationWidgetState extends State<OptionsEvaluationWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Visibility(
            visible: widget.show,
            child: Text(
              "Selecione um ou mais problemas",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: Visibility(
              visible: widget.show,
              child: OptionsItemWidget(
                options: widget.options,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:assessment_app/app/models/option.dart';

import 'options_item_widget.dart';

class OptionsEvaluationWidget extends StatefulWidget {
  final List<Option> options;
  final bool show;
  final Function(List<int> values) optionSelected;
  const OptionsEvaluationWidget({
    Key? key,
    required this.options,
    required this.show,
    required this.optionSelected,
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
              "Selecione no que podemos melhorar",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: Visibility(
              visible: widget.show,
              child: OptionsItemWidget(
                options: widget.options,
                optionSelected: ((values) {
                  widget.optionSelected(values);
                }),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

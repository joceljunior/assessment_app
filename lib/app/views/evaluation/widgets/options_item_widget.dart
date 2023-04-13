import 'package:assessment_app/app/views/evaluation/store/evaluation_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../models/option.dart';

class OptionsItemWidget extends StatefulWidget {
  final List<Option> options;
  const OptionsItemWidget({super.key, required this.options});

  @override
  State<OptionsItemWidget> createState() => _OptionsItemWidgetState();
}

class _OptionsItemWidgetState extends State<OptionsItemWidget> {
  // https://karthikponnam.medium.com/flutter-multi-select-choicechip-244ea016b6fa
  List<bool> problemSeleted = [];
  final EvaluationStore store = GetIt.I<EvaluationStore>();

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List<Widget>.generate(widget.options.length, (int index) {
          var item = widget.options[index];
          problemSeleted.add(false);

          return ChoiceChip(
            label: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                item.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            selected: problemSeleted[index], // _selectedAnimalIndex == index,
            onSelected: (bool selected) {
              setState(() {
                problemSeleted[index] = selected;
                store.optionsSelected.add(item.id!);
              });
            },
            backgroundColor: Colors.grey.shade50,
            selectedColor: Colors.orange,
          );
        }).toList());
  }
}

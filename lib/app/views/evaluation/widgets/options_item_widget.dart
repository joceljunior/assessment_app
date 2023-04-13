import 'package:flutter/material.dart';

import '../../../models/option.dart';

class OptionsItemWidget extends StatefulWidget {
  final List<Option> options;
  final Function(int value) optionSelected;
  const OptionsItemWidget({
    Key? key,
    required this.options,
    required this.optionSelected,
  }) : super(key: key);

  @override
  State<OptionsItemWidget> createState() => _OptionsItemWidgetState();
}

class _OptionsItemWidgetState extends State<OptionsItemWidget> {
  // https://karthikponnam.medium.com/flutter-multi-select-choicechip-244ea016b6fa
  List<bool> problemSeleted = [];

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
                widget.optionSelected(item.id!);
              });
            },
            backgroundColor: Colors.grey.shade50,
            selectedColor: Colors.orange,
          );
        }).toList());
  }
}

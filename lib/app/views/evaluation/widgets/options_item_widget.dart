import 'package:flutter/material.dart';

import '../../../models/option.dart';

class OptionsItemWidget extends StatefulWidget {
  final List<Option> options;
  final Function(List<int> values) optionSelected;
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
  List<int> seletedIds = [];

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
              problemSeleted[index] = selected;
              if (selected) {
                seletedIds.add(item.id!);
              } else if (selected == false && seletedIds.contains(item.id)) {
                seletedIds.remove(item.id);
              }
              widget.optionSelected(seletedIds);
              setState(() {});
            },
            backgroundColor: Colors.grey.shade50,
            selectedColor: Theme.of(context).primaryColor,
          );
        }).toList());
  }
}

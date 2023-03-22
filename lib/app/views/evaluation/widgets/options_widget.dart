import 'package:flutter/material.dart';
import '../../../models/option.dart';

class OptionsWidget extends StatefulWidget {
  final List<Option> options;
  const OptionsWidget({super.key, required this.options});

  @override
  State<OptionsWidget> createState() => _OptionsWidgetState();
}

class _OptionsWidgetState extends State<OptionsWidget> {
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
              });
            },
            backgroundColor: Colors.grey.shade50,
            selectedColor: Colors.orange,
          );
        }).toList()

        // ListView.builder(
        //   shrinkWrap: true,
        //   physics: NeverScrollableScrollPhysics(),
        //   // scrollDirection: Axis.horizontal,
        //   itemCount: widget.options.length,
        //   itemBuilder: ((context, index) {
        //     var item = widget.options[index];
        //     return Container(
        //       padding: EdgeInsets.all(2.0),
        //       child: ChoiceChip(
        //         label: Text(
        //           item.name,
        //           style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal,
        //           ),
        //         ),
        //         selected: false,
        //         onSelected: (selected) {},
        //       ),
        //     );
        //   }),
        // ),
        // ],

        );
  }
}

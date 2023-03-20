import 'package:flutter/material.dart';

import '../../../models/option.dart';

class OptionsWidget extends StatefulWidget {
  final List<Option> options;
  const OptionsWidget({super.key, required this.options});

  @override
  State<OptionsWidget> createState() => _OptionsWidgetState();
}

class _OptionsWidgetState extends State<OptionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.options.length,
        itemBuilder: ((context, index) {
          var item = widget.options[index];
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  // textStyle: MaterialStateProperty.all(
                  //   TextStyle(color: Colors.black),
                  // ),
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 199, 193, 193)),
                ),
                child: Text(item.name),
                onPressed: () {},
              ));
        }),
      ),
    );
  }
}

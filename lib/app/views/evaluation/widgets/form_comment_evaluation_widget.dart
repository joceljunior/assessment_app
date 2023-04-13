import 'package:flutter/material.dart';

class FormCommentEvaluationWidget extends StatelessWidget {
  final TextEditingController controller;
  const FormCommentEvaluationWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 4,
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
    );
  }
}

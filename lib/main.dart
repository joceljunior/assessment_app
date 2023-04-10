import 'package:assessment_app/app_widget.dart';
import 'package:assessment_app/core/assessment_binds.dart';
import 'package:flutter/material.dart';

void main() async {
  AssessmentBinds.setup();
  runApp(AppWidget());
}

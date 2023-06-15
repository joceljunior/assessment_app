import 'package:assessment_app/app_widget.dart';
import 'package:assessment_app/core/assessment_binds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() async {
  usePathUrlStrategy();
  AssessmentBinds.setup();
  runApp(AppWidget());
}

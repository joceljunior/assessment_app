import 'package:assessment_app/store/app_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'core/themes/assessment_theme.dart';
import 'routes/router_assessment.dart';

class AppWidget extends StatefulWidget {
  AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final AppStore store = GetIt.I<AppStore>();

  @override
  void initState() {
    store.changeTheme(key: AssessmentThemeKeys.defaultTheme);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeData>(
      valueListenable: store,
      builder: (context, theme, child) {
        return MaterialApp(
          onGenerateRoute: (settings) =>
              RouterAssessment().generateRoute(settings),
          initialRoute: '/',
          title: 'Assessment',
          theme: theme,
        );
      },
    );
  }
}

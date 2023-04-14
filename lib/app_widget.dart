import 'package:assessment_app/store/app_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'routes/router_assessment.dart';

class AppWidget extends StatelessWidget {
  AppWidget({Key? key}) : super(key: key);

  final AppStore store = GetIt.I<AppStore>();

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

import 'package:flutter/material.dart';

import 'routes/router_assessment.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: RouterAssessment.routes,
      title: 'Assessment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

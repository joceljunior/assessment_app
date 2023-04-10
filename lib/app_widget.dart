import 'package:flutter/material.dart';

import 'routes/router_assessment.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouterAssessment().generateRoute,
      initialRoute: '/',
      title: 'Assessment',
      theme: ThemeData(
        fontFamily: 'ProductSans',
        primarySwatch: Colors.blue,
      ),
    );
  }
}

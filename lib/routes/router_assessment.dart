import 'package:flutter/material.dart';

import '../app/views/evaluation/evaluation_page.dart';
import '../app/views/splash/splash_page.dart';

class RouterAssessment {
  Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => SplashPage(),
        );

      case '/evaluation/:customerId':
        var customerId = args as String;
        return MaterialPageRoute(
          builder: (_) => EvaluationPage(customerId: customerId),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => SplashPage(),
        );
    }
  }
}

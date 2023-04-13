import 'package:flutter/material.dart';

import '../app/views/evaluation/evaluation_page.dart';
import '../app/views/splash/splash_page.dart';

class RouterAssessment {
  Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => SplashPage(url: "lavateen"),
        );

      case '/evaluation':
        var customerId = args as String;
        return MaterialPageRoute(
          builder: (_) => EvaluationPage(customerId: customerId),
        );

      default:
        String completedUrl = settings.name!;
        // ignore: unused_local_variable
        var url = completedUrl.substring(
            completedUrl.indexOf('#') + 2, completedUrl.length);
        return MaterialPageRoute(
          builder: (_) => SplashPage(url: "lavateen"),
        );
    }
  }
}

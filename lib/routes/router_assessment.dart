import 'package:assessment_app/app/views/checkout/checkout_page.dart';
import 'package:assessment_app/core/views/error_page.dart';
import 'package:flutter/material.dart';

import '../app/views/evaluation/evaluation_page.dart';
import '../app/views/splash/splash_page.dart';

class RouterAssessment {
  Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case '/':
        String completedUrl = settings.name!;

        var url = completedUrl.isEmpty
            ? ""
            : completedUrl.substring(
                completedUrl.indexOf('#') + 2, completedUrl.length);
        return MaterialPageRoute(
          builder: (_) => SplashPage(url: url),
        );

      case '/evaluation':
        var customerId = args as int;
        return MaterialPageRoute(
          builder: (_) => EvaluationPage(customerId: customerId),
        );

      case '/checkout':
        return MaterialPageRoute(
          builder: (_) => CheckoutPage(),
        );
      case '/error':
        return MaterialPageRoute(
          builder: (_) => ErrorPage(),
        );

      default:
        String completedUrl = settings.name!;
        // ignore: unused_local_variable
        var url = completedUrl.substring(
            completedUrl.indexOf('#') + 2, completedUrl.length);
        return MaterialPageRoute(
          builder: (_) => SplashPage(url: url),
        );
    }
  }
}

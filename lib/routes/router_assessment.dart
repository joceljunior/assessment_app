import 'package:assessment_app/app/views/evaluation/evaluation_page.dart';
import 'package:assessment_app/app/views/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterAssessment {
  static GoRouter routes = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return SplashPage();
        },
      ),
      GoRoute(
        path: '/evaluation/:customerId',
        builder: (BuildContext context, GoRouterState state) {
          return EvaluationPage(customerId: state.params['customerId']);
        },
      ),
    ],
    errorBuilder: (context, state) => SplashPage(),
  );
}

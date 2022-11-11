import 'package:assessment_app/app/models/customer.dart';

abstract class SplashState {}

class Loading implements SplashState {}

class Success implements SplashState {
  final Customer customer;
  Success({
    required this.customer,
  });
}

class Error implements SplashState {
  final String message;
  Error({
    required this.message,
  });
}

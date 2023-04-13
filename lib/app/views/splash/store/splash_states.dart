import '../../../models/customer.dart';

abstract class SplashState {}

class Initial extends SplashState {}

class Loading extends SplashState {}

class Success extends SplashState {
  final Customer customer;
  Success({
    required this.customer,
  });
}

class Error extends SplashState {
  final String message;
  Error({
    required this.message,
  });
}

abstract class ICustomerFailure implements Exception {}

class CustomerFailure implements ICustomerFailure {
  final String message;
  CustomerFailure({
    required this.message,
  });
}

class QuestionFailure implements ICustomerFailure {
  final String message;
  QuestionFailure({
    required this.message,
  });
}

class EvaluationFailure implements ICustomerFailure {
  final String message;
  EvaluationFailure({
    required this.message,
  });
}
import 'package:assessment_app/app/models/customer.dart';

abstract class ISplashController {
  Future<Customer> getCustomer({required String url});
}

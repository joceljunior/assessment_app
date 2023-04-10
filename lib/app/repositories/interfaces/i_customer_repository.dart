import 'package:assessment_app/app/models/customer.dart';

abstract class ICustomerRepository {
  Future<Customer> getCustomer({required String url});
}

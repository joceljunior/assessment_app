import 'package:assessment_app/core/exception/assessment_failures.dart';
import 'package:assessment_app/core/interfaces/i_customer_repository.dart';

import 'package:dio/dio.dart';

import '../customer.dart';

class CustomerRepository implements ICustomerRepository {
  final Dio httpClient = Dio();
  @override
  Future<Customer> getCustomer({required String url}) async {
    try {
      var urlApi =
          'https://assessmentforlearning.herokuapp.com/getCustomerUrl/$url';
      var response = await httpClient.get(urlApi);
      var customer =
          (response.data as List).map((e) => Customer.fromJson(e)).first;
      return customer;
    } catch (e) {
      throw CustomerFailure(message: 'Houve uma falha');
    }
  }
}

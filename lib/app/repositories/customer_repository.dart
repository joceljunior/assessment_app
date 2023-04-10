import 'package:assessment_app/core/constants.dart';
import 'package:assessment_app/core/exception/assessment_failures.dart';
import 'package:assessment_app/app/repositories/interfaces/i_customer_repository.dart';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../models/customer.dart';

class CustomerRepository implements ICustomerRepository {
  final Dio httpClient = GetIt.I<Dio>();
  @override
  Future<Customer> getCustomer({required String url}) async {
    try {
      var urlApi = '${Constants.baseurl}getCustomerUrl/$url';
      var response = await httpClient.get(urlApi);
      var customer = Customer.fromJson(response.data);
      return customer;
    } catch (e) {
      throw CustomerFailure(message: 'Houve uma falha');
    }
  }
}

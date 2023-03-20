import 'package:assessment_app/core/exception/assessment_failures.dart';
import 'package:assessment_app/core/interfaces/i_customer_repository.dart';
import 'package:assessment_app/core/states/splash_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController {
  ICustomerRepository repository = GetIt.I<ICustomerRepository>();

  var customerId = 0;
  final state = ValueNotifier<SplashState>(Loading());

  Future getCustomer({required String url}) async {
    state.value = Loading();
    try {
      final db = await SharedPreferences.getInstance();
      var customer = await repository.getCustomer(url: url);
      await db.setInt('session', customer.idSession);
      state.value = Success(customer: customer);
    } on CustomerFailure catch (e) {
      state.value = Error(message: e.message);
    }
  }
}

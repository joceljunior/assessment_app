import 'package:assessment_app/core/exception/assessment_failures.dart';
import 'package:assessment_app/core/interfaces/i_customer_repository.dart';
import 'package:assessment_app/core/states/splash_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends ValueNotifier<SplashState> {
  SplashController() : super(Loading());
  ICustomerRepository repository = GetIt.I<ICustomerRepository>();

  var customerId = 0;

  Future getCustomer({required String url}) async {
    sendState(Loading());
    try {
      final db = await SharedPreferences.getInstance();
      var customer = await repository.getCustomer(url: url);
      await db.setInt('session', customer.idSession);
      sendState(Success(customer: customer));
    } on CustomerFailure catch (e) {
      sendState(Error(message: e.message));
    }
  }

  sendState(SplashState state) {
    value = state;
  }
}

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exception/assessment_failures.dart';
import '../models/customer.dart';
import '../repositories/interfaces/i_customer_repository.dart';
import 'interfaces/i_splash_controller.dart';

class SplashController implements ISplashController {
  final ICustomerRepository repository = GetIt.I<ICustomerRepository>();

  @override
  Future<Customer> getCustomer({required String url}) async {
    try {
      final db = await SharedPreferences.getInstance();
      var customer = await repository.getCustomer(url: url);
      await db.setInt('session', customer.idSession);
      return customer;
    } on CustomerFailure catch (e) {
      throw CustomerFailure(message: e.message);
    }
  }
}

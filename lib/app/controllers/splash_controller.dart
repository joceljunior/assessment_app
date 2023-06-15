import 'package:assessment_app/core/themes/assessment_theme.dart';
import 'package:assessment_app/store/app_store.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exception/assessment_failures.dart';
import '../models/customer.dart';
import '../repositories/interfaces/i_customer_repository.dart';
import 'interfaces/i_splash_controller.dart';

class SplashController implements ISplashController {
  final ICustomerRepository repository = GetIt.I<ICustomerRepository>();
  final AppStore appStore = GetIt.I<AppStore>();

  @override
  Future<Customer> getCustomer({required String url}) async {
    try {
      final db = await SharedPreferences.getInstance();
      db.clear();
      var customer = await repository.getCustomer(url: url);
      await db.setInt('session', customer.idSession);
      if (customer.id == 2) {
        customer.pathLogo = "assets/skina_pao.jpg";
        appStore.changeTheme(key: AssessmentThemeKeys.skinaPao);
      } else if (customer.id == 3) {
        customer.pathLogo = "assets/sabor_trigo.jpg";
        appStore.changeTheme(key: AssessmentThemeKeys.saborTrigo);
      } else {
        appStore.changeTheme(key: AssessmentThemeKeys.defaultTheme);
      }

      return customer;
    } on CustomerFailure catch (e) {
      throw CustomerFailure(message: e.message);
    }
  }
}

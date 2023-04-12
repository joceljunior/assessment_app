import 'package:assessment_app/app/views/splash/bloc/splash_states.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/exception/assessment_failures.dart';
import '../../../controllers/interfaces/i_splash_controller.dart';

class SplashStore extends ValueNotifier<SplashState> {
  SplashStore() : super(Loading());
  final ISplashController controller = GetIt.I<ISplashController>();

  int customerId = 0;
  bool showLogo = false;
  bool showButton = false;
  bool showNameCustomer = false;

  Future<void> getCustomer({required String url}) async {
    value = Loading();

    try {
      var customer = await controller.getCustomer(url: url);
      customerId = customer.id;
      value = Success(customer: customer);
    } on CustomerFailure catch (e) {
      value = Error(message: e.message);
    }
  }
}

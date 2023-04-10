import 'package:assessment_app/app/controllers/interfaces/i_splash_controller.dart';
import 'package:assessment_app/app/views/splash/bloc/splash_states.dart';
import 'package:assessment_app/core/exception/assessment_failures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SplashBloc {
  final state = ValueNotifier<SplashState>(Initial());
  final ISplashController controller = GetIt.I<ISplashController>();

  int customerId = 0;

  Future<void> getCustomer({required String url}) async {
    try {
      state.value = Loading();
      var customer = await controller.getCustomer(url: url);
      state.value = Success(customer: customer);
    } on CustomerFailure catch (e) {
      state.value = Error(message: e.message);
    }
  }
}

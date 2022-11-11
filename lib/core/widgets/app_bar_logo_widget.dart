import 'package:flutter/material.dart';

class AppBarLogoWidget extends StatelessWidget {
  final Size size;
  final int customerId;
  const AppBarLogoWidget({
    Key? key,
    required this.size,
    required this.customerId,
  }) : super(key: key);

  String getLogo({required int customerId}) {
    switch (customerId) {
      case 24:
        return 'assets/logo.png';

      default:
        return 'assets/splash.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(getLogo(customerId: customerId));
  }
}

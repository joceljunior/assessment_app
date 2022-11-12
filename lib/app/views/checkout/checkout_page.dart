import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../core/widgets/app_bar_logo_widget.dart';

class CheckoutPage extends StatelessWidget {
  final String totalSteps;
  final String customerId;
  const CheckoutPage(
      {super.key, required this.totalSteps, required this.customerId});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height * 0.8,
        width: size.width,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Expanded(
            child: AppBarLogoWidget(
              size: size,
              customerId: int.parse(customerId),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Obrigado pelo seu pitaco!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: StepProgressIndicator(
              totalSteps: int.parse(totalSteps),
              currentStep: int.parse(totalSteps),
              size: 8,
              selectedColor: Colors.yellow,
              unselectedColor: Colors.cyan,
              roundedEdges: Radius.circular(10),
              selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.blue[200]!],
              ),
              unselectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black45, Colors.black38],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

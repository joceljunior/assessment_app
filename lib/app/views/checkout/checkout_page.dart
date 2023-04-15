import 'package:assessment_app/core/widgets/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height * 0.8,
        width: size.width,
        child: Center(
          child: Text(
            'Obrigado pelo seu pitaco!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      bottomSheet: BottomSheetWidget(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Animate(
              child: Image.asset(
                height: size.height * 0.3,
                'error_teste.jpg',
              ).animate().shake(duration: Duration(seconds: 3)).shimmer(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'ESTAMOS EM MANUTENÇÃO',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

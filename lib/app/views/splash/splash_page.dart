import 'dart:html';

import 'package:assessment_app/app/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/states/splash_states.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

bool showLogo = false;
bool showButton = false;
bool showNameCustomer = false;
final controller = SplashController();

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    var completedUrl = window.location.href;

    var url = completedUrl.substring(
        completedUrl.indexOf('#') + 2, completedUrl.length);
    controller.getCustomer(url: url);
    showAnimations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildFadeLogo(context),
            buildFadeNameCustomer(context),
            buildFadeButton(context),
          ],
        ),
      ),
    );
  }

  Future<void> showAnimations() async {
    await Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          showLogo = true;
        });
      }
    });

    await Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          showButton = true;
        });
      }
    });

    await Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          showNameCustomer = true;
        });
      }
    });
    // await Future.delayed(Duration(seconds: 1), navigation);
  }

  Widget buildFadeLogo(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var logoWidth = size.width * (0.8);
    return Expanded(
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: Duration(seconds: 1),
        builder: (context, dynamic opacity, child) {
          return AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: showLogo ? opacity : 0,
            child: Image.asset(
              'assets/logo_pitaco.png',
              width: logoWidth,
            ),
          );
        },
      ),
    );
  }

  Widget buildFadeButton(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(seconds: 2),
      builder: (context, dynamic opacity, child) {
        return AnimatedOpacity(
          duration: Duration(seconds: 2),
          opacity: showLogo ? opacity : 0,
          child: GestureDetector(
            child: Container(
              color: Color.fromARGB(255, 27, 115, 231),
              width: _size.width,
              height: _size.height * 0.10,
              child: Center(
                child: Text(
                  'Iniciar',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white),
                ),
              ),
            ),
            onTap: () {
              GoRouter.of(context).go('/evaluation/${controller.customerId}');
            },
          ),
        );
      },
    );
  }

  Widget buildFadeNameCustomer(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    var logoWidth = _size.width * (0.8);
    return ValueListenableBuilder(
      valueListenable: controller.state,
      builder: (context, state, child) {
        print(state.toString());
        if (state is Loading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is Error) {
          return Center(
            child: Text(state.message),
          );
        }

        if (state is Success) {
          controller.customerId = state.customer.id;
          return Expanded(
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(seconds: 1),
              builder: (context, dynamic opacity, child) {
                return AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  opacity: showNameCustomer ? opacity : 0,
                  child: Column(
                    children: [
                      Text(
                        'Avalie os serviços de',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        state.customer.name,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }

        return Container();
      },
    );
  }
}

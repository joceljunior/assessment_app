import 'package:assessment_app/app/views/splash/bloc/splash_store.dart';
import 'package:assessment_app/app/views/splash/bloc/splash_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get_it/get_it.dart';

class SplashPage extends StatefulWidget {
  final String url;
  const SplashPage({Key? key, required this.url}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

final SplashStore store = GetIt.I<SplashStore>();

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    store.getCustomer(url: widget.url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: ValueListenableBuilder<SplashState>(
        valueListenable: store,
        builder: (context, state, child) {
          return Container(
            color: Colors.white,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildFadeLogo(context),
                buildFadeNameCustomer(context, state),
                buildFadeButton(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildFadeLogo(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var logoWidth = size.width * (0.8);
    return Expanded(
      child: Animate(
        child: Image.asset(
          'assets/logo_pitaco.png',
          width: logoWidth,
        ).animate().fade(duration: Duration(seconds: 1)).shimmer(),
      ),
    );
  }

  Widget buildFadeNameCustomer(BuildContext context, SplashState state) {
    print(state.runtimeType.toString());
    if (state is Loading) {
      return Expanded(child: Center(child: CircularProgressIndicator()));
    }
    if (state is Error) {
      return Expanded(child: Center(child: Text(state.message)));
    }

    if (state is Success) {
      return Expanded(
        child: Center(
          child: Animate(
            child: Text(
              state.customer.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ).animate().fadeIn(duration: Duration(seconds: 1)),
          ),
        ),
      );
    }

    return Container();
  }

  Widget buildFadeButton(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Animate(
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
          Navigator.of(context)
              .pushNamed('/evaluation', arguments: store.customerId.toString());
        },
      ).animate().fadeIn(duration: Duration(seconds: 1)),
    );
  }
}

import 'package:assessment_app/app/views/splash/store/splash_store.dart';
import 'package:assessment_app/app/views/splash/store/splash_states.dart';
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
                buildFadeLogo(context, state),
                buildFadeNameCustomer(context, state),
                buildFadeButton(context, state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildFadeLogo(BuildContext context, SplashState state) {
    var size = MediaQuery.of(context).size;
    var logoWidth = size.width * (0.8);
    if (state is Success) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Animate(
            child: Image.asset(
              store.pathLogo,
              width: logoWidth,
            ).animate().fade(duration: Duration(seconds: 2)).shimmer(),
          ),
        ),
      );
    }
    return Container();
  }

  Widget buildFadeNameCustomer(BuildContext context, SplashState state) {
    if (state is Success) {
      return Expanded(
        child: Center(
          child: Animate(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Você está avaliando os serviços de",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ).animate().fadeIn(duration: Duration(seconds: 1)),
                Text(
                  state.customer.name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ).animate().fadeIn(duration: Duration(seconds: 1)),
              ],
            ),
          ),
        ),
      );
    }

    return Container();
  }

  Widget buildFadeButton(BuildContext context, SplashState state) {
    var _size = MediaQuery.of(context).size;
    if (state is Loading) {
      return Expanded(child: Center(child: CircularProgressIndicator()));
    }
    if (state is Error) {
      return Expanded(child: Center(child: Text(state.message)));
    }
    if (state is Success) {
      return Animate(
        child: GestureDetector(
          child: Container(
            color: Theme.of(context).primaryColor,
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
                .pushNamed('/evaluation', arguments: store.customerId);
          },
        ).animate().fadeIn(duration: Duration(seconds: 1)),
      );
    }

    return Container();
  }
}

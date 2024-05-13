import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code/app/modules/home/views/home_view.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash: 
    Column(
      children: [
        Center(
          child: LottieBuilder.asset("lib/assets/lottie/animation.json"),
        )
      ],
    ), nextScreen: HomeView(),
    splashIconSize: 400,
    backgroundColor: Colors.white,
    );
  }
}
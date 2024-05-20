import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_page_controller.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code/app/modules/login/views/login_view.dart';

class SplashPageView extends StatelessWidget {
  const SplashPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Center(
            child: LottieBuilder.asset("lib/assets/lottie/splash.json"),
          )
        ],
      ),
      // nextScreen: HomeView(),
      nextScreen: LoginView(),
      splashIconSize: 400,
      backgroundColor: Colors.white,
      duration: 7000,
    );
  }
}

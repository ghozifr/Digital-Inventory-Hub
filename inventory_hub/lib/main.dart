import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code/app/modules/login/controllers/login_controller.dart';

import 'app/controllers/auth_controller.dart';
import 'app/modules/loading/loading_screen.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(AuthController(), permanent: true);
  // Register LoginController
  Get.put(LoginController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // UNTUK AUTO LOGIN -> FIREBASE AUTHENTICATION
    return StreamBuilder<User?>(
      // stream: auth.authStateChanges(),
      // builder: (context, snapAuth) {
      //   if (snapAuth.connectionState == ConnectionState.waiting)
      //     return const LoadingScreen();
      stream: auth.authStateChanges(),
      builder: (context, snapAuth) {
        if (snapAuth.connectionState == ConnectionState.waiting)
          return const LoadingScreen();
        Future.delayed(Duration(seconds: 2), () {
          // Navigate to either home or login based on authentication status
          if (snapAuth.hasData) {
            Get.offAllNamed(Routes.home); // Navigate to home screen
          } else {
            Get.offAllNamed(Routes.login); // Navigate to login screen
          }
        });
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splash,
          initialBinding: BindingsBuilder(() {
            // Register LoginController
            Get.lazyPut(() => LoginController());
          }),
          getPages: AppPages.routes,
        );
      },
    );
  }
}

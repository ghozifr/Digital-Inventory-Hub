import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_hub/app/routes/app_pages.dart';

import '../../../controllers/auth_controller.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController(
    text: 'admin@gmail.com',
  );
  final TextEditingController passController = TextEditingController(
    text: 'admin123',
  );

  final AuthController authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOGIN'),
        centerTitle: true,
      ),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        TextField(
          autocorrect: false,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Obx(
          () => TextField(
            autocorrect: false,
            controller: passController,
            keyboardType: TextInputType.text,
            obscureText: controller.isHidden.value,
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: IconButton(
                onPressed: () {
                  controller.isHidden.toggle();
                  // = !controller.isHidden.value;
                },
                icon: Icon(
                  controller.isHidden.isFalse
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined,
                ), //Icons.visibility_off
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
        ),
        const SizedBox(height: 35),
        ElevatedButton(
          onPressed: () async {
            if (controller.isLoading.isFalse) {
              // controller.isLoading(true);
              if (emailController.text.isNotEmpty &&
                  passController.text.isNotEmpty) {
                controller.isLoading(true);
                //login process
                Map<String, dynamic> result = await authC.login(
                    emailController.text, passController.text);
                controller.isLoading(false);

                if (result['error'] == true) {
                  Get.snackbar("Error", result["message"]);
                } else {
                  Get.offAllNamed(Routes.home);
                }
              } else {
                Get.snackbar("Error", "Email and Password cannot be empty!");
              }
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
          // Get.offNamed('/home');
          child: Obx(
            () => Text(controller.isLoading.isFalse ? "LOGIN" : "LOADING..."),
          ),
        ),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController emailC = TextEditingController(
    text: "",
  );
  final TextEditingController passC = TextEditingController(
    text: "",
  );

  final AuthController authC = Get.find<AuthController>();
 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Hi! Welcome back', style: TextStyle(
        color: Color(0xFF3383C5),
        fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    ),
    
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Illustration Picture
        Image.asset(
          'lib/assets/images/login.png', // image path
          width: 200, 
          height: 200, 
        ),
        const SizedBox(height: 50),
        // Email TextField
        Column(
          children: [
            TextField(
              autocorrect: false,
              controller: emailC,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
        // Password TextField
        Obx(
          () => TextField(
            autocorrect: false,
            controller: passC,
            keyboardType: TextInputType.text,
            obscureText: controller.isHidden.value,
            decoration: InputDecoration(
              labelText: "Password",
              suffixIcon: IconButton(
                onPressed: () {
                  controller.isHidden.toggle();
                },
                icon: Icon(
                  controller.isHidden.isFalse
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        TextButton(
          onPressed: () {
            Get.toNamed(Routes.registration);
          },
          child: Text("Create an account"),
        ),
        const SizedBox(height: 35),
        ElevatedButton(
          onPressed: () async {
            if (controller.isLoading.isFalse) {
              if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
                controller.isLoading(true);
                Map<String, dynamic> hasil =
                    await authC.login(emailC.text, passC.text);
                controller.isLoading(false);

                if (hasil["error"] == true) {
                  Get.snackbar("Error", hasil["message"]);
                } else {
                  Get.offAllNamed(Routes.home);
                }
              } else {
                Get.snackbar("Error", "Email dan password must be filled.");
              }
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
          child: Obx(
            () => Text(controller.isLoading.isFalse ? "LOGIN" : "LOADING..."),
          ),
        ),
      ],
    ),
  );
}
}
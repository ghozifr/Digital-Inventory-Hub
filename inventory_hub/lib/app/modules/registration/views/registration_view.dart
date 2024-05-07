import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code/app/routes/app_pages.dart';

import '../../login/views/login_view.dart';
import '../controllers/registration_controller.dart';

class RegistrationView extends StatelessWidget {
  final RegistrationController _signupController =
      Get.put(RegistrationController());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegistrationView({super.key});

  void signUp() {
    String email = _emailController.text;
    String password = _passwordController.text;
    _signupController.signUp(email, password);
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'Hi! Welcome',
        style: TextStyle(
          color: Color(0xFF5B0888),
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: const Color(0xFFF1EAFF),
    ),
    backgroundColor: const Color(0xFFF1EAFF),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Illustration Picture
        Image.asset(
          'lib/assets/images/signup.png', // image path
          width: 200, 
          height: 200, 
        ),
        const SizedBox(height: 50),
        // Email TextField
        Column(
          children: [
            TextField(
              autocorrect: false,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                prefixIconColor: Color(0xFF5B0888), // Add icon to the left of TextField
                labelText: "Email",
                border: InputBorder.none,
                fillColor: Color.fromARGB(255, 255, 255, 255),
                filled: true,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
        // Password TextField
        TextField(
          autocorrect: false,
          controller: _passwordController,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.lock),
            prefixIconColor: Color(0xFF5B0888),
            labelText: "Password",
            border: InputBorder.none,
            fillColor: Color.fromARGB(255, 255, 255, 255),
            filled: true,
          ),
        ),
        const SizedBox(height: 15),
        // Confirm Password TextField
        TextField(
          autocorrect: false,
          controller: _passwordController,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.lock),
            prefixIconColor:  Color(0xFF5B0888),
            labelText: "Confirm Password",
            border: InputBorder.none,
            fillColor:  Color.fromARGB(255, 255, 255, 255),
            filled: true,
          ),
        ),
        const SizedBox(height: 15),
        TextButton(
          onPressed: () {
            Get.toNamed(Routes.registration);
          },
          child: Text("Already have an account?"),
        ),
        const SizedBox(height: 35),
        ElevatedButton(
          onPressed: _signupController.isLoading.value
              ? null
              : () {
                  signUp();
                  // Navigate to the login page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                  );
                },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            elevation: 5,
          ),
          child: _signupController.isLoading.value
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5B0888)),
                )
              : const Text(
                  'SIGN UP',
                  style: TextStyle(
                    color: Color(0xFF5B0888),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ],
    ),
  );
}

}
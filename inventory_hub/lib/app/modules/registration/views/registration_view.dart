import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        title: const Text('Hi! Welcome', style: TextStyle(
        color: Color(0xFF5B0888),
        fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF1EAFF),
      ),
      backgroundColor: const Color(0xFFF1EAFF),
      body: Padding(
        padding: const EdgeInsets.all(20),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration Picture
        Image.asset(
          'lib/assets/images/signup.png', // image path
          width: 200, 
          height: 200, 
        ),
        const SizedBox(height: 50),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ),
            const SizedBox(height: 35),
            Obx(() {
              return ElevatedButton(
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
                ),
                child: _signupController.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text('Sign Up'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
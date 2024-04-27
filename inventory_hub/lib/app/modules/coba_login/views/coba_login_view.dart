import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/coba_login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CobaLoginView extends StatelessWidget {
  final CobaLoginController _controller = Get.put(CobaLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller.emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller.passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _controller.login();
                Get.offAllNamed('/home');
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}



// class CobaLoginView extends GetView<CobaLoginController> {
//   const CobaLoginView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('CobaLoginView'),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text(
//           'CobaLoginView is working',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationController extends GetxController {
  //TODO: Implement RegistrationController

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxBool isHidden = true.obs;
  RxBool isLoading = false.obs;

  void signUp(String email, String password, String confirmPassword) async {
    try {
      isLoading.value = true;
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create a new document in Firestore with the user's UID as the document ID
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
//         // Add more fields as needed
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
          'Error',
          'Password is too weak.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          'Error',
          'Email is already in use.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        //Get.offAllNamed(
        // Routes.home);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class RegistrationController extends GetxController {
//   //TODO: Implement RegistrationController

//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   //RxBool isHidden = true.obs;
//   RxBool isLoading = false.obs;

//   void signUp(String email, String password, String username) async {
//     try {
//       isLoading.value = true;
//       UserCredential userCredential =
//           await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // Create a new document in Firestore with the user's UID as the document ID
//       await _firestore.collection('users').doc(userCredential.user!.uid).set({
//         'email': email,
//         // Add more fields as needed
//       });



//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         Get.snackbar(
//           'Error',
//           'Password is too weak.',
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       } else if (e.code == 'email-already-in-use') {
//         Get.snackbar(
//           'Error',
//           'Email is already in use.',
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       } else {
//         //Get.offAllNamed(
//         // Routes.home);
//       }
//     } catch (e) {
//       print(e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

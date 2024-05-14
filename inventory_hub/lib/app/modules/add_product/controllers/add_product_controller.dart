import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddProductController extends GetxController {
  RxBool isLoading = false.obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> addProduct(Map<String, dynamic> data) async {
    try {
      
      // Get the current user
      User? user = _auth.currentUser;
      if (user != null) {
        // Get the user's document reference
        // DocumentReference userDocRef = firestore.collection('users').doc(user.uid);

        // Create a new document in the "profile" subcollection
        CollectionReference profileDocRef = firestore.collection('users/${user.uid}/products');

        // Set data for the profile document
        // await profileDocRef.set({
        //   'username': _usernameController.text,
        //   // Add more fields as needed
        // });

        // Optionally, you can navigate back to the home page or another page after data submission
        // Navigator.pop(context);
      

      var hasil = await profileDocRef.add(data);
      await profileDocRef.doc(hasil.id).update({
        "productId": hasil.id,
        });
      }


      return {
        "error": false,
        "message": "Product added successfully.",
      };
    } catch (e) {
      // Error general
      print(e);
      return {
        "error": true,
        "message": "Added product was unsuccessful.",
      };
    }
  }


}

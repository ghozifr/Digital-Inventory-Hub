import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';

class AddProductController extends GetxController {

  RxBool isLoading = false.obs;


  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late FirebaseDatabase _database;

  late DatabaseReference ref;

  late TextEditingController textController;
  RxInt productId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Generate a random product ID when the controller is initialized
    generateRandomProductId();
    textController = TextEditingController(text: productId.value.toString());
    productId.listen((val) {
      textController.text = val.toString();
    });
    _database = FirebaseDatabase.instance;

    ref = _database.ref();

    textController = TextEditingController();
  }

  void generateRandomProductId() {
    Random random = Random();
    productId.value = random.nextInt(1000000000);
  }

  // void timeRecordToFrestore() {
  //   final DateTime now = DateTime.now();
  //   final String formattedTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(now);

  //   final DatabaseReference = ref = Database.ref('timestamps');
  //   ref.push().set({'timestamps': formattedTime});
  // }
  // void onInit_ref() {

  //   super.onInit();

  //   _database = FirebaseDatabase.instance;

  //   ref = _database.ref();

  //   textController = TextEditingController();

  // }


  @override

  void onClose() {

    textController.dispose();

    super.onClose();

  }


  String formatTime(DateTime now) {

    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');

    return formatter.format(now);

  }


  Future<String> timeRecordToFrestore() async {

    final DateTime now = DateTime.now();

    final String formattedTime = formatTime(now);


    final DatabaseReference timestampRef = ref.child('timestamps');

    timestampRef.push().set({'timestamps': formattedTime});


    return formattedTime;

  }

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

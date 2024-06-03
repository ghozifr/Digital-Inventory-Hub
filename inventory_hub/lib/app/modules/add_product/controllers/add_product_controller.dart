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

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }

  String formatTime(DateTime now) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
    return formatter.format(now);
  }

  Future<String> timeRecordToFirestore() async {
    final DateTime now = DateTime.now();
    final String formattedTime = formatTime(now);
    final DatabaseReference timestampRef = ref.child('timestamps');
    timestampRef.push().set({'timestamps': formattedTime});

    return formattedTime;
  }

  String formatCurrentTime() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
    return formatter.format(now);
  }
  Future<Map<String, dynamic>> addProduct(Map<String, dynamic> data) async {
  try {
    User? user = _auth.currentUser;
    if (user != null) {
      CollectionReference productsCollection = firestore.collection('users').doc(user.uid).collection('products');

      // Add the product data to the 'products' collection
      var hasil = await productsCollection.add(data);

      // Update the product document to include its own ID
      await productsCollection.doc(hasil.id).update({
        "productId": hasil.id,
      });

      // Set a custom document ID for the 'timedate' subcollection using current time
      String timestampId = DateTime.now().millisecondsSinceEpoch.toString();
      await productsCollection.doc(hasil.id).collection('timedate').doc(timestampId).set({
        'qty': data["qty"],
        'updatedAt': formatCurrentTime(),
      });

      return {
        "error": false,
        "message": "Product added successfully.",
      };
    }
    return {
      "error": true,
      "message": "User is not logged in.",
    };
  } catch (e) {
    print(e);
    return {
      "error": true,
      "message": "Adding product was unsuccessful.",
    };
  }
}

}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:qr_code/app/data/models/product_model.dart';

class DetailProductController extends GetxController {
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingDelete = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Helper method to format the current time
  String formatCurrentTime() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
    return formatter.format(now);
  }

  // Method to log user UID and product ID when user views product details
  Future<void> logProductView(String productId) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        final String formattedTime = formatCurrentTime();
        
        // Print statements to verify logging
        print("User UID: ${user.uid}");
        print("Product ID: $productId");

        await firestore.collection("productViews").add({
          "userUid": user.uid,
          "productId": productId,
          "viewedAt": formattedTime,
        });
      }
    } catch (e) {
      print("Failed to log product view: $e");
    }
  }

  void goToAnalysisView(ProductModel product) {
    User? user = _auth.currentUser;
    if (user != null) {
      Get.toNamed("/analysis", arguments: {
        "userUid": user.uid,
        "productUid": product.productId,
      });
    }
  }

 Future<Map<String, dynamic>> editProduct(Map<String, dynamic> data) async {
  try {
    User? user = _auth.currentUser;
    if (user != null) {
      final String formattedTime = formatCurrentTime();
      CollectionReference productsCollection = firestore.collection('users').doc(user.uid).collection('products');

      await firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(productsCollection.doc(data["id"]));
        
        if (!snapshot.exists) {
          throw Exception("Product does not exist!");
        }

        // Update the quantity and updatedAt directly in the product document
        transaction.update(productsCollection.doc(data["id"]), {
          "name": data["name"],
          "qty": data["qty"],
          "updatedAt": formattedTime,
        });

        // Set a custom document ID for the 'timedate' subcollection using current time
        String timestampId = DateTime.now().millisecondsSinceEpoch.toString();
        await productsCollection.doc(data["id"]).collection('timedate').doc(timestampId).set({
          'qty': data["qty"],
          'updatedAt': formattedTime,
        });
      });
    }
    return {
      "error": false,
      "message": "Product updated successfully.",
    };
  } catch (e) {
    return {
      "error": true,
      "message": "Updated product was unsuccessful.",
    };
  }
}



  Stream<DocumentSnapshot<Map<String, dynamic>>> streamProduct(String id) async* {
    User? user = _auth.currentUser;
    if (user != null) {
      yield* firestore.collection("/users/${user.uid}/products").doc(id).snapshots();
    }
  }

  Future<Map<String, dynamic>> deleteProduct(String id) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await firestore.collection("/users/${user.uid}/products").doc(id).delete();
      }

      return {
        "error": false,
        "message": "Product deleted successfully.",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Deleted product was unsuccessful.",
      };
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:qr_code/app/data/models/product_model.dart'; // Add this import for date formatting

class DetailProductController extends GetxController {
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingDelete = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

   void goToAnalysisView(ProductModel product) {
    Get.toNamed("/analysis", arguments: product.productId);
  }

  // Helper method to format the current time
  String formatCurrentTime() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
    return formatter.format(now);
  }

  Future<Map<String, dynamic>> editProduct(Map<String, dynamic> data) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        final String formattedTime = formatCurrentTime(); // Get the current timestamp
        CollectionReference productsRef = firestore.collection("/users/${user.uid}/products/${data["id"]}/updateHistory");

        DocumentReference productRef = firestore.collection("/users/${user.uid}/products").doc(data["id"]);
        
        await firestore.runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(productRef);
          
          if (!snapshot.exists) {
            throw Exception("Product does not exist!");
          }

            List<dynamic> updateHistory = (snapshot.data() as Map<String, dynamic>)['updateHistory'] ?? [];
          updateHistory.add({
            "qty": data["qty"],
            "updatedAt": formattedTime,
          });

          transaction.update(productRef, {
            "name": data["name"],
            "qty": data["qty"],
            "updateHistory": updateHistory,
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

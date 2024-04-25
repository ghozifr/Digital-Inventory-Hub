import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailProductController extends GetxController {
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingDelete = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> editProduct(Map<String, dynamic> data) async {
    try {
      await firestore.collection("productions").doc(data["id"]).update({
        "name": data["name"],
        "qty": data["qty"],
      });

      return {
        "error": false,
        "message": "Product updated successfully.",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Updating product was unsuccessfull.",
      };
    }
  }

  Future<Map<String, dynamic>> deleteProduct(String id) async {
    try {
      await firestore.collection("productions").doc(id).delete();
      return {
        "error": false,
        "message": "Product deleted.",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Can not delete the product.",
      };
    }
  }
}
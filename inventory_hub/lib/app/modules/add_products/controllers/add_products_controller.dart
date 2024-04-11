import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddProductsController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> addProduct(Map<String, dynamic> data) async {
    try {
      await firestore.collection("productions").add(data);
      return {
        "error": false,
        "message": "can add product",
      };
    } catch (e) {
      //general error
      return {
        "error": true,
        "message": "cannot add product",
      };
    }
  }
}

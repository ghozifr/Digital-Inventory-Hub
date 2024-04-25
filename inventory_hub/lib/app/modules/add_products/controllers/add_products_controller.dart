import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddProductsController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> addProduct(Map<String, dynamic> data) async {
    try {
      var result = await firestore.collection("productions").add(data);
      await firestore.collection("productions").doc(result.id).update({
        "productsId": result.id,
      });
      return {
        "error": false,
        "message": "Product added successfully",
      };
    } catch (e) {
      //general error
      return {
        "error": true,
        "message": "Adding product was unsuccessfull.",
      };
    }
  }
}

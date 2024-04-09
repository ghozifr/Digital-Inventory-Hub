import 'package:get/get.dart';

class AddProductsController extends GetxController {
  RxBool isLoading = false.obs;

  Future<Map<String, dynamic>> addProduct(Map<String, dynamic> data) async {
    try {
      //
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

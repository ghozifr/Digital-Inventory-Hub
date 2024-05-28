import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/product_model.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../controllers/detail_product_controller.dart';
import '../../../routes/app_pages.dart';

class DetailProductView extends GetView<DetailProductController> {
  DetailProductView({Key? key}) : super(key: key);

  final ProductModel product = Get.arguments;

  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

@override
Widget build(BuildContext context) {
  // Log the product view
  controller.logProductView(product.productId);

  codeC.text = product.code;
  nameC.text = product.name;
  qtyC.text = "${product.qty}";

  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'DETAIL PRODUCT',
        style: TextStyle(
          color: Color(0xFFffffff),
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0XFF2F2D4E),
      centerTitle: true,
    ),
    backgroundColor: const Color(0XFF2F2D4E),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 180,
              width: 180,
              child: QrImageView(
                data: product.code,
                size: 180.0,
                version: QrVersions.auto,
                foregroundColor: const Color(0xFFFFFFFF), // Set your desired color here
                // backgroundColor: Colors.white, // Optional: Set background color
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 12,
                      offset: const Offset(5, 5), // changes position of shadow
                    ),
                    BoxShadow(
                      color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(-5, -5), // changes position of shadow
                    ),
                  ],
          ),
          child: TextField(
            autocorrect: false,
            controller: codeC,
            keyboardType: TextInputType.number,
            readOnly: true,
            decoration: const InputDecoration(
              labelText: "Product Code",
              filled: true,
              fillColor: Colors.white,
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 12,
                      offset: const Offset(5, 5), // changes position of shadow
                    ),
                    BoxShadow(
                      color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(-5, -5), // changes position of shadow
                    ),
                  ],
          ),
          child: TextField(
            autocorrect: false,
            controller: nameC,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: "Product Name",
              filled: true,
              fillColor: Colors.white,
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 12,
                      offset: const Offset(5, 5), // changes position of shadow
                    ),
                    BoxShadow(
                      color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(-5, -5), // changes position of shadow
                    ),
                  ],
          ),
          child: TextField(
            autocorrect: false,
            controller: qtyC,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Quantity",
              filled: true,
              fillColor: Colors.white,
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15),
            ),
          ),
        ),
        const SizedBox(height: 35),
        ElevatedButton(
          onPressed: () async {
            if (controller.isLoadingUpdate.isFalse) {
              if (nameC.text.isNotEmpty && qtyC.text.isNotEmpty) {
                controller.isLoadingUpdate(true);
                Map<String, dynamic> hasil = await controller.editProduct({
                  "id": product.productId,
                  "name": nameC.text,
                  "qty": int.tryParse(qtyC.text) ?? 0,
                });
                controller.isLoadingUpdate(false);

                Get.snackbar(
                  hasil["error"] == true ? "Error" : "Success",
                  hasil["message"],
                  duration: const Duration(seconds: 2),
                );
              } else {
                Get.snackbar(
                  "Error",
                  "All data must be filled in.",
                  duration: const Duration(seconds: 2),
                );
              }
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            elevation: 5,
          ),
          child: Obx(
            () => Text(controller.isLoadingUpdate.isFalse
                ? "UPDATE PRODUCT"
                : "LOADING..."),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            controller.goToAnalysisView(product);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            backgroundColor: const Color(0xFFFFFFFF),
            elevation: 5,
          ),
          child: const Text("ANALYSIS PRODUCT"),
        ),
        TextButton(
          onPressed: () {
            Get.defaultDialog(
              title: "Delete Product",
              middleText: "Are you sure to delete this product?",
              actions: [
                OutlinedButton(
                  onPressed: () => Get.back(),
                  child: const Text("CANCEL"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    controller.isLoadingDelete(true);
                    Map<String, dynamic> hasil =
                        await controller.deleteProduct(product.productId);
                    controller.isLoadingDelete(false);

                    Get.back(); // Close dialog
                    Get.back(); // Navigate back to all products

                    Get.snackbar(
                      hasil["error"] == true ? "Error" : "Success",
                      hasil["message"],
                      duration: const Duration(seconds: 2),
                    );
                  },
                  child: Obx(
                    () => controller.isLoadingDelete.isFalse
                        ? const Text("DELETE")
                        : Container(
                            padding: const EdgeInsets.all(2),
                            height: 10,
                            width: 15,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1,
                            ),
                          ),
                  ),
                ),
              ],
            );
          },
          child: Text(
            "DELETE PRODUCT",
            style: TextStyle(
              color: Colors.red.shade900, fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  );
}


}

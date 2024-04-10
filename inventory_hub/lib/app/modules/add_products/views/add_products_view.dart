import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_products_controller.dart';

class AddProductsView extends GetView<AddProductsController> {
  AddProductsView({Key? key}) : super(key: key);
  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ADD PRODUCTS'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              autocorrect: false,
              controller: codeC,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                labelText: 'Product Code',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              autocorrect: false,
              controller: nameC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              autocorrect: false,
              controller: qtyC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Product Quantity',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ),
            const SizedBox(height: 35),
            ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  if (codeC.text.isNotEmpty ||
                      nameC.text.isNotEmpty ||
                      qtyC.text.isNotEmpty) {
                    controller.isLoading(true);
                    //login process
                    Map<String, dynamic> result = await controller.addProduct({
                      "code": codeC.text,
                      "name": nameC.text,
                      "qty": int.tryParse(qtyC.text) ?? 0,
                    });
                    controller.isLoading(false);
                    Get.snackbar(result["error"] == true ? "Error" : "Success",
                        result["message"]);
                  } else {
                    Get.snackbar('Error', 'Please fill all data');
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              // Get.offNamed('/home');
              child: Obx(
                () => Text(controller.isLoading.isFalse
                    ? "ADD PRODUCT"
                    : "LOADING..."),
              ),
            ),
          ],
        ));
  }
}

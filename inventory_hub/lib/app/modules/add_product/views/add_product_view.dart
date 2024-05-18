import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  AddProductView({Key? key}) : super(key: key);
  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();
  final AddProductController controllerR = Get.put(AddProductController());
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'ADD PRODUCT',
        style: TextStyle(
          color: Color(0xFF5B0888),
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: const Color(0xFFF1EAFF),
    ),
    backgroundColor: const Color(0xFFF1EAFF),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // TextField(
        //   autocorrect: false,
        //   controller: codeC,
        //   keyboardType: TextInputType.number,
        //   maxLength: 10,
        //   decoration: InputDecoration(
        //     labelText: "Product Code",
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(9),
        //       borderSide: const BorderSide(color: Color(0xFFD0A2F7)), // Change border color
        //     ),
        //     focusedBorder: OutlineInputBorder( // Change border color when focused
        //       borderRadius: BorderRadius.circular(9),
        //       borderSide: const BorderSide(color: Color(0xFF5B0888)), // Change border color when focused
        //     ),
        //   ),
        // ),
        Text('Product ID:'),
            TextField(
              controller: controllerR.textController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                // Update the productId in the controller whenever the value changes
                controllerR.productId.value = int.tryParse(value) ?? 0;
              },
            ),
            Obx(() => Text('Current Value: ${controllerR.productId}')),
        const SizedBox(height: 20),
        TextField(
          autocorrect: false,
          controller: nameC,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: "Product Name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(color: Color(0xFFD0A2F7)), // Change border color
            ),
            focusedBorder: OutlineInputBorder( // Change border color when focused
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(color: Color(0xFF5B0888)), // Change border color when focused
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          autocorrect: false,
          controller: qtyC,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Quantity",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(color: Color(0xFFD0A2F7)), // Change border color
            ),
            focusedBorder: OutlineInputBorder( // Change border color when focused
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(color: Color(0xFF5B0888)), // Change border color when focused
            ),
          ),
        ),
        const SizedBox(height: 35),
        ElevatedButton(
          onPressed: () async {
            codeC.text = controllerR.textController.value.text;
            if (controller.isLoading.isFalse) {
              if (
                //codeC.text.isNotEmpty &&
                  nameC.text.isNotEmpty &&
                  qtyC.text.isNotEmpty) {
                controller.isLoading(true);
                Map<String, dynamic> hasil = await controller.addProduct({
                  "code": codeC.text,
                  "name": nameC.text,
                  "qty": int.tryParse(qtyC.text) ?? 0,
                });
                controller.isLoading(false);

                Get.back();

                Get.snackbar(
                    hasil["error"] == true ? "Error" : "Success",
                    hasil["message"]);
              } else {
                Get.snackbar("Error", "All data must be filled in.");
              }
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
          child: Obx(
            () => Text(
                controller.isLoading.isFalse ? "ADD PRODUCT" : "LOADING..."),
          ),
        ),
      ],
    ),
  );
}
}
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
      backgroundColor: const Color(0XFFF8F9FF),
    ),
    backgroundColor: const Color(0XFFF8F9FF),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white, // Fill color
            borderRadius: BorderRadius.circular(9),
            boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0D2750).withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(6, 6), // changes position of shadow
                    ),
                    BoxShadow(
                      color: const Color.fromARGB(255, 255, 255, 255).withOpacity(1),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(-6, -6), // changes position of shadow
                    ),
                  ],
          ),
          child: TextField(
            autocorrect: false,
            controller: codeC,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: const InputDecoration(
              labelText: "Product Code",
              border: InputBorder.none, // Remove border
              focusedBorder: InputBorder.none, // Remove focused border
              enabledBorder: InputBorder.none, // Remove enabled border
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            ),
          ),
        ),
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
        Container(
          decoration: BoxDecoration(
            color: Colors.white, // Fill color
            borderRadius: BorderRadius.circular(9),
            boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0D2750).withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(6, 6), // changes position of shadow
                    ),
                    BoxShadow(
                      color: const Color.fromARGB(255, 255, 255, 255).withOpacity(1),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(-6, -6), // changes position of shadow
                    ),
                  ],
          ),
          child: TextField(
            autocorrect: false,
            controller: nameC,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: "Product Name",
              border: InputBorder.none, // Remove border
              focusedBorder: InputBorder.none, // Remove focused border
              enabledBorder: InputBorder.none, // Remove enabled border
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white, // Fill color
            borderRadius: BorderRadius.circular(9),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0D2750).withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(6, 6), // changes position of shadow
              ),
              BoxShadow(
                color: const Color.fromARGB(255, 255, 255, 255).withOpacity(1),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(-6, -6), // changes position of shadow
              ),
            ],
          ),
          child: TextField(
            autocorrect: false,
            controller: qtyC,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Quantity",
              border: InputBorder.none, // Remove border
              focusedBorder: InputBorder.none, // Remove focused border
              enabledBorder: InputBorder.none, // Remove enabled border
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            ),
          ),
        ),
        const SizedBox(height: 35),
        ElevatedButton(
          onPressed: () async {
            codeC.text = controllerR.textController.value.text;
            if (controller.isLoading.isFalse) {
              if (
                codeC.text.isNotEmpty &&
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
            foregroundColor: const Color(0xFF5B0888), backgroundColor: Colors.white,
            elevation: 5, // Text color
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
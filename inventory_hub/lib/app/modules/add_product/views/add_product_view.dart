import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  AddProductView({Key? key}) : super(key: key);
  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();
  final AddProductController controllerR = Get.put(AddProductController());
  final AddProductController timecontroller = Get.put(AddProductController());

  Future pickImage() async {
    
    // final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    // if (pickedFile != null) {
    //   final File file = File(pickedFile.path);
    //   final String fileName = basename(file.path);
    //   final Reference ref = FirebaseStorage.instance.ref().child(fileName);
    //   final UploadTask uploadTask = ref.putFile(file);
    //   final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    //   final String url = await taskSnapshot.ref.getDownloadURL();
    //   return url;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ADD PRODUCT',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0XFF2F2D4E),
      ),
      backgroundColor: const Color(0XFF2F2D4E),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
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
          ),
          const Text(
          'Product ID',
              style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, // Change this to your desired color
              ),
            ),
        Obx(() => Text(
          'Current Value: ${controllerR.productId}',
          style: const TextStyle(
            color: Colors.white, // Change this to your desired color
          ),
        )),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
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
                BoxShadow(
                  color: const Color(0xFF0D2750).withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(6, 6),
                ),
                BoxShadow(
                  color: const Color.fromARGB(255, 255, 255, 255).withOpacity(1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(-6, -6),
                ),
              ],
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
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
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
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
            ),
          ),
          const SizedBox(height: 35),
          ElevatedButton(
            onPressed: () async {
              final String formattedTime = await timecontroller.timeRecordToFirestore();
              codeC.text = controllerR.productId.toString();

              if (controller.isLoading.isFalse) {
                if (nameC.text.isNotEmpty && qtyC.text.isNotEmpty) {
                  controller.isLoading(true);
                  Map<String, dynamic> hasil = await controller.addProduct({
                    "code": codeC.text,
                    "name": nameC.text,
                    "time": formattedTime,
                    "qty": int.tryParse(qtyC.text) ?? 0,
                  });
                  controller.isLoading(false);

                  Get.back();

                  Get.snackbar(
                    hasil["error"] == true ? "Error" : "Success",
                    hasil["message"]
                  );
                } else {
                  Get.snackbar("Error", "All data must be filled in.");
                }
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFF2F2D4E),
              backgroundColor: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
            child: Obx(
              () => Text(
                controller.isLoading.isFalse ? "ADD PRODUCT" : "LOADING..."
              ),
            ),
          ),
          const SizedBox(height: 35),
          ElevatedButton(
            onPressed: () async {
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFF2F2D4E),
              backgroundColor: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
            child: Obx(
              () => Text(
                controller.isLoading.isFalse ? "ADD IMAGE" : "LOADING..."
              ),
            ),
          ),
        ],
      ),
    );
  }
}
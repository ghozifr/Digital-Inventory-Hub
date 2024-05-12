import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final AuthController authC = Get.find<AuthController>();
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      flexibleSpace: Center( // Center the image horizontally
        child: Image.asset(
          'lib/assets/images/ihLogo.png',
          width: 50, // Adjust width as needed
          height: 50, // Adjust height as needed
        ),
      ),
      backgroundColor: const Color(0xFFF1EAFF),
    ),
    backgroundColor: const Color(0xFFF1EAFF),
    body: SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(5, (index) {
            late String title;
            late String imagePath;
            late VoidCallback onTap;
            late String description;

            switch (index) {
              case 0:
                title = "Add Product";
                imagePath = "lib/assets/images/add.png";
                onTap = () => Get.toNamed(Routes.addProduct);
                description =
                    "Add a new product by adding product code, name, and quantity.";
                break;
              case 1:
                title = "Products";
                imagePath = "lib/assets/images/list.png";
                onTap = () => Get.toNamed(Routes.products);
                description = "View all products that have been added.";
                break;
              case 2:
                title = "QR Code";
                imagePath = "lib/assets/images/qr.png";
                onTap = () async {
                  String barcode = await FlutterBarcodeScanner.scanBarcode(
                    "#000000",
                    "CANCEL",
                    true,
                    ScanMode.QR,
                  );

                  // Get data dari firebase search by product id
                  Map<String, dynamic> hasil =
                      await controller.getProductById(barcode);
                  if (hasil["error"] == false) {
                    Get.toNamed(Routes.detailProduct,
                        arguments: hasil["data"]);
                  } else {
                    Get.snackbar(
                      "Error",
                      hasil["message"],
                      duration: const Duration(seconds: 2),
                    );
                  }
                };
                description = "Scan QR code to view product details";
                break;
              case 3:
                title = "Dowload";
                imagePath = "lib/assets/images/file.png";
                onTap = () {
                  controller.downloadCatalog();
                };
                description = "Download product list";
                break;

                case 4:
                title = "Analysis";
                imagePath = "lib/assets/images/graph.png";
                onTap = () {
                  //link webview
                };
                description = "View analysis of the products";
                break;
            }

            return SizedBox(
              height: 120, // Adjust the height as needed
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1EAFF),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5B0888).withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  onTap: onTap,
                  leading: SizedBox(
                    width: 60,
                    height: 60,
                    child: Image.asset(imagePath),
                  ),
                  title: Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF5B0888), // Change color
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      description,
                      style: const TextStyle(
                        color: Color(0xFF5B0888), // Change color
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () async {
        Map<String, dynamic> hasil = await authC.logout();
        if (hasil["error"] == false) {
          Get.offAllNamed(Routes.login);
        } else {
          Get.snackbar("Error", hasil["error"]);
        }
      },
      backgroundColor: const Color(0xFFDCBFFF),
      child: Icon(Icons.logout),
    ),
  );
}
<<<<<<< HEAD
<<<<<<< HEAD

//try change this on a new branch
//try after finished the pull request and merge it with same branch
// no contribution they said
//apa kek joining
// back to main branch
//branch baru cabang tiga
=======
>>>>>>> blurryy
=======
}
>>>>>>> blurryy

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
        title: const Text('Menu'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF1EAFF),
      ),
      backgroundColor: const Color(0xFFF1EAFF),
      body: GridView.builder(
        itemCount: 4,
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          late String title;
          late IconData icon;
          late VoidCallback onTap;

          switch (index) {
            case 0:
              title = "Add Product";
              icon = Icons.post_add_rounded;
              onTap = () => Get.toNamed(Routes.addProduct);
              break;
            case 1:
              title = "Products";
              icon = Icons.list_alt_outlined;
              onTap = () => Get.toNamed(Routes.products);
              break;
            case 2:
              title = "QR Code";
              icon = Icons.qr_code;
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
                  Get.toNamed(Routes.detailProduct, arguments: hasil["data"]);
                } else {
                  Get.snackbar(
                    "Error",
                    hasil["message"],
                    duration: const Duration(seconds: 2),
                  );
                }
              };
              break;
            case 3:
              title = "Catalog";
              icon = Icons.document_scanner_outlined;
              onTap = () {
                controller.downloadCatalog();
              };
              break;
          }

          return Material(
            color: const Color(0xFFD0A2F7),
            borderRadius: BorderRadius.circular(9),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(icon, size: 50),
                  ),
                  const SizedBox(height: 10),
                  Text(title),
                ],
              ),
            ),
          );
        },
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
}
<<<<<<< HEAD

//try change this on a new branch
//try after finished the pull request and merge it with same branch
// no contribution they said
//apa kek joining
// back to main branch
//branch baru cabang tiga
=======
>>>>>>> blurryy

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inventory_hub/app/controllers/auth_controller.dart';
import 'package:inventory_hub/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final AuthController authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: 4,
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          // ignore: unused_local_variable
          late String title;
          late IconData icon;
          late VoidCallback onTap;
          switch (index) {
            case 0:
              title = "Add Products";
              icon = Icons.post_add_rounded;
              onTap = () => Get.toNamed(Routes.add_products);
              break;
            case 1:
              title = "Product List";
              icon = Icons.list;
              onTap = () => Get.toNamed(Routes.product_list);
              break;
            case 2:
              title = "QR Scan";
              icon = Icons.qr_code;
              onTap = () {
                print("open qr scan");
              };
              break;
            case 3:
              title = "Report";
              icon = Icons.report;
              onTap = () {
                print("open pdf");
              };
              break;
          }

          return Material(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(9),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    // color: Colors.red,
                    child: Icon(
                      icon,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("Title"),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, dynamic> result = await authC.logout();
          if (result['error'] == false) {
            Get.offAllNamed(Routes.login);
          } else {
            Get.snackbar('Error', result['error']);
          }
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}

//try change this on a new branch
//try after finished the pull request and merge it with same branch
// no contribution they said
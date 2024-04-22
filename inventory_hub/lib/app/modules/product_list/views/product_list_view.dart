import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:inventory_hub/app/routes/app_pages.dart';

import '../controllers/product_list_controller.dart';

class ProductListView extends GetView<ProductListController> {
  const ProductListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PRODUCTS LIST'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 5,
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) {
          return Card(
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.detail_product);
                },
                borderRadius: BorderRadius.circular(9),
                child: Container(
                    height: 100,
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "28374298213346",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text("Indomie"),
                              Text("Quantity: 8"),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          color: Colors.green,
                        ),
                      ],
                    )),
              ));
        },
      ),
    );
  }
}

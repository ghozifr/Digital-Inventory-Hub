import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../data/models/product_model.dart';
import '../../../routes/app_pages.dart';
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.productListStream(),
        builder: (context, snapProductList) {
          if (snapProductList.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapProductList.data!.docs.isEmpty) {
            return const Center(
              child: Text("No products found"),
            );
          }
          List<ProductModel> allProducts = [];
          for (var element in snapProductList.data!.docs) {
            allProducts.add(ProductModel.fromJson(element.data()));
          }

          return ListView.builder(
            itemCount: allProducts.length,
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) {
              ProductModel product = allProducts[index];
              return Card(
                  elevation: 5,
                  margin: const EdgeInsets.only(bottom: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.detail_product, arguments: product);
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
                                    product.code,
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(product.name),
                                  Text("Quantity: ${product.qty}"),
                                ],
                              ),
                            ),
                            SizedBox(
                                height: 50,
                                width: 50,
                                child: QrImageView(
                                  data: product.code,
                                  size: 50,
                                )
                                // child: QrImage(
                                //   data: product.code,
                                //   size: 200.0,
                                //   version: QrVersions.auto,
                                // ),
                                ),
                          ],
                        )),
                  ));
            },
          );
        },
      ),
    );
  }
}

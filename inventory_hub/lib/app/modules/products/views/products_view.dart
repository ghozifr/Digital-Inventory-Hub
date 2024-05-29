import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../data/models/product_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({Key? key}) : super(key: key);
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'PRODUCT',
        style: TextStyle(
          color: Color(0xFFffffff),
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0XFF2F2D4E),
      centerTitle: true,
    ),
    backgroundColor: const Color(0XFF2F2D4E),
    body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: controller.streamProducts(),
      builder: (context, snapProducts) {
        if (snapProducts.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapProducts.data!.docs.isEmpty) {
          return const Center(
            child: Text("No products"),
          );
        }

        List<ProductModel> allProducts = [];

        for (var element in snapProducts.data!.docs) {
          allProducts.add(ProductModel.fromJson(element.data()));
        }

        return ListView.builder(
          itemCount: allProducts.length,
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, index) {
            ProductModel product = allProducts[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 20),
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
              child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.detailProduct, arguments: product);
                },
                borderRadius: BorderRadius.circular(9),
                child: Container(
                  height: 127,
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.code,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2F2D4E),
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product.name,
                              style: const TextStyle(
                                color: Color(0xFF2F2D4E),
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Quantity : ${product.qty}",
                              style: const TextStyle(
                                color: Color(0xFF2F2D4E),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              "Tap here to see more details",
                              style: TextStyle(
                                color: Color(0xFF2F2D4E),
                                fontSize: 14,
                                fontStyle:FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: QrImage(
                          data: product.code,
                          size: 200.0,
                          version: QrVersions.auto,
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: QrImageView(
                            data: product.code,
                            size: 200.0,
                            version: QrVersions.auto,
                          ),
                        ),
                      ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ),
  );
}

}
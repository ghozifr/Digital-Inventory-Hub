import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
          color: Color(0xFF5B0888),
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xFFF1EAFF),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF1EAFF),
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
              return Card(
                elevation: 5,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                color: const Color.fromARGB(255, 255, 255, 255),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.detailProduct, arguments: product);
                  },
                  borderRadius: BorderRadius.circular(9),
                  child: Container(
                    height: 112,
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
                                  fontWeight: FontWeight.bold, color: Color(0xFF5B0888), fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(product.name,
                              style: const TextStyle(
                                  color: Color(0xFF5B0888), fontSize: 16,
                                ),),
                              Text("Quantity : ${product.qty}",
                              style: const TextStyle(
                                  color: Color(0xFF5B0888), fontSize: 14,
                                ),),
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
                          ),
                        ),
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

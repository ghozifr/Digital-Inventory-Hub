import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
            child: Container(
              height: 200,
              color: Colors.grey.shade300,
            ),
          );
        },
      ),
    );
  }
}

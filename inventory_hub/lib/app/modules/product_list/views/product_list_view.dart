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
      body: ListView.builder(itemBuilder: itemBuilder: (context, index){
        return Container(
          height: 200,
          margin: EdgeInsets.all(bottom: 20),
          color: grey.shade300,
        );
      },
      ),
    );
  }
}

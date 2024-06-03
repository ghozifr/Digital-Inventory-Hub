import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
              return ProductItem(product: product);
            },
          );
        },
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  final ProductModel product;

  const ProductItem({required this.product, Key? key}) : super(key: key);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;

      setState(() {
        image = File(pickedImage.path);
      });
    } on Exception catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
          Get.toNamed(Routes.detailProduct, arguments: widget.product);
        },
        borderRadius: BorderRadius.circular(9),
        child: Container(
          height: 140, // Adjusted height to fit the button and image
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.code,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2F2D4E),
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                        color: Color(0xFF2F2D4E),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Quantity : ${widget.product.qty}",
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
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  if (image != null)
                    Image.file(
                      image!,
                      height: 60,
                      width: 60,
                    )
                  else
                    Container(
                      height: 60,
                      width: 60,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, color: Colors.grey),
                    ),
                  const SizedBox(height: 2), // Space between image and buttons
                  TextButton(
                    onPressed: () => showImageSourceActionSheet(context),
                    child: const Text("Add Image"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductsController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();

  Stream<QuerySnapshot<Map<String, dynamic>>> streamProducts() async* {
    User? user = _auth.currentUser;
    if (user != null) {
      yield* firestore.collection("/users/${user.uid}/products").snapshots();
    }
  }

  Future<String?> uploadImage(String productId) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    }

    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('products')
          .child(productId)
          .child('product_image_${DateTime.now().millisecondsSinceEpoch}.jpg');

      final UploadTask uploadTask = storageReference.putFile(File(image.path));
      final TaskSnapshot taskSnapshot = await uploadTask;

      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print('Image upload error: $e');
      return null;
    }
  }

  Future<void> addProductImage(String productId) async {
    final imageUrl = await uploadImage(productId);
    if (imageUrl != null) {
      User? user = _auth.currentUser;
      if (user != null) {
        await firestore
            .collection("/users/${user.uid}/products")
            .doc(productId)
            .update({
          'imageUrl': imageUrl,
        });
      }
    }
  }
}

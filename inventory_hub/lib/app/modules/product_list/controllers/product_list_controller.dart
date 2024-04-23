import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController {
  //TODO: Implement ProductListController

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> productListStream() async* {
    yield* firestore.collection('productions').snapshots();
  }
}

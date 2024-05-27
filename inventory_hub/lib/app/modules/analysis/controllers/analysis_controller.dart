import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnalysisController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Map<String, dynamic>> updateHistory = <Map<String, dynamic>>[].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getChartData(String userUid, String productId) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(userUid)
      .collection('products')
      .doc(productId)
      .collection('timedate')
      .snapshots(includeMetadataChanges: true);
}

}


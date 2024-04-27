import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductsController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamProducts() async* {
    
    User? user = _auth.currentUser;
      if (user != null) {
    // Obtain a reference to the main document containing the subcollection
  DocumentReference mainDocumentRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

  // Obtain a reference to the subcollection
  CollectionReference subcollectionRef = mainDocumentRef.collection('subcollection');

  // Yield snapshots of the subcollection
  yield* firestore.collection("/users/${user.uid}/products").snapshots();
      }
  }
}
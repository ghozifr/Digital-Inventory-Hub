import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // CHECK CONDITON FOR AUTO LOGIN
  // NULL -> LOGIN
  // UID -> HOME
  String? uid;

  late FirebaseAuth auth;

  Future<Map<String, dynamic>> login(String email, String pass) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pass);
      return {
        "error": false,
        "message": "can login",
      };
    } on FirebaseAuthException catch (e) {
      //excepton from firebase
      return {
        "error": true,
        "message": "${e.message}",
      };
    } catch (e) {
      //general error
      return {
        "error": true,
        "message": "cannot login",
      };
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      await auth.signOut();
      return {
        "error": false,
        "message": "can logout",
      };
    } on FirebaseAuthException catch (e) {
      //excepton from firebase
      return {
        "error": true,
        "message": "${e.message}",
      };
    } catch (e) {
      //general error
      return {
        "error": true,
        "message": "cannot logout",
      };
    }
  }

  @override
  void onInit() {
    auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((event) {
      uid = event?.uid;
    });

    super.onInit();
  }
}

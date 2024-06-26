// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAdUVXqrtp8ww8nY2eL5HE3YyJkAawXdQs',
    appId: '1:1040054663068:web:340b7b80b33e1066df7a59',
    messagingSenderId: '1040054663068',
    projectId: 'digital-inventory-hub',
    authDomain: 'digital-inventory-hub.firebaseapp.com',
    storageBucket: 'digital-inventory-hub.appspot.com',
    measurementId: 'G-EVMW3RFXPL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC468eUmfStAcECUQAXB7VYVVfDMwJNUaQ',
    appId: '1:1040054663068:android:74703641877a6772df7a59',
    messagingSenderId: '1040054663068',
    projectId: 'digital-inventory-hub',
    storageBucket: 'digital-inventory-hub.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCyjx4g8KOoaBUXAQBC7EKe2zuFtHNDIww',
    appId: '1:1040054663068:ios:c9b1857241ba2f36df7a59',
    messagingSenderId: '1040054663068',
    projectId: 'digital-inventory-hub',
    storageBucket: 'digital-inventory-hub.appspot.com',
    iosClientId:
        '1040054663068-couti29ir0kl63lf30sqmobctjqmrmjj.apps.googleusercontent.com',
    iosBundleId: 'com.kuldiiproject.qrCode',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCyjx4g8KOoaBUXAQBC7EKe2zuFtHNDIww',
    appId: '1:1040054663068:ios:c9b1857241ba2f36df7a59',
    messagingSenderId: '1040054663068',
    projectId: 'digital-inventory-hub',
    storageBucket: 'digital-inventory-hub.appspot.com',
    iosClientId:
        '1040054663068-couti29ir0kl63lf30sqmobctjqmrmjj.apps.googleusercontent.com',
    iosBundleId: 'com.kuldiiproject.qrCode',
  );
}

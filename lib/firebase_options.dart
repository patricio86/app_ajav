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
    apiKey: 'AIzaSyALZMgcL08VwwDYbByIrF3ZG9Z-1O0JvJ4',
    appId: '1:306444008917:web:a92998b9746f391766915c',
    messagingSenderId: '306444008917',
    projectId: 'bdajav',
    authDomain: 'bdajav.firebaseapp.com',
    databaseURL: 'https://bdajav-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'bdajav.appspot.com',
    measurementId: 'G-JCGY09VMKF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDBy02CHGRmMcGJf8lIRbiU7mkHwWPlgAc',
    appId: '1:306444008917:android:2527572fdb07fa0366915c',
    messagingSenderId: '306444008917',
    projectId: 'bdajav',
    databaseURL: 'https://bdajav-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'bdajav.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0FKQlQFk9s4rqi7NQS0hWox0xB5rwMqk',
    appId: '1:306444008917:ios:561970eb90d5ca2266915c',
    messagingSenderId: '306444008917',
    projectId: 'bdajav',
    databaseURL: 'https://bdajav-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'bdajav.appspot.com',
    iosClientId: '306444008917-ig9srnvk9o3clj39dvn7cacjd4ns5i27.apps.googleusercontent.com',
    iosBundleId: 'com.example.appajav',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD0FKQlQFk9s4rqi7NQS0hWox0xB5rwMqk',
    appId: '1:306444008917:ios:561970eb90d5ca2266915c',
    messagingSenderId: '306444008917',
    projectId: 'bdajav',
    databaseURL: 'https://bdajav-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'bdajav.appspot.com',
    iosClientId: '306444008917-ig9srnvk9o3clj39dvn7cacjd4ns5i27.apps.googleusercontent.com',
    iosBundleId: 'com.example.appajav',
  );
}

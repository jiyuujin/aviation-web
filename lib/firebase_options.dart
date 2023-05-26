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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAV7kCXzIPqtKeFnaNz-ywA3NEBUBw7S24',
    appId: '1:640788022391:web:cf7378c17974c1c0033272',
    messagingSenderId: '640788022391',
    projectId: 'nuxt-admin-tokyo',
    authDomain: 'nuxt-admin-tokyo.firebaseapp.com',
    databaseURL: 'https://nuxt-admin-tokyo.firebaseio.com',
    storageBucket: 'nuxt-admin-tokyo.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC4-SqhqZceynJGq_0twgXs1mJpLtdtbO4',
    appId: '1:640788022391:android:7c764b61bcf8a80e033272',
    messagingSenderId: '640788022391',
    projectId: 'nuxt-admin-tokyo',
    databaseURL: 'https://nuxt-admin-tokyo.firebaseio.com',
    storageBucket: 'nuxt-admin-tokyo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyATdMKB6h6QuzqPknm_ru5EP4-fbVBHQ_s',
    appId: '1:640788022391:ios:8b50b2b290576679033272',
    messagingSenderId: '640788022391',
    projectId: 'nuxt-admin-tokyo',
    databaseURL: 'https://nuxt-admin-tokyo.firebaseio.com',
    storageBucket: 'nuxt-admin-tokyo.appspot.com',
    iosClientId: '640788022391-d5g8q1ddol3ke11fqrdn5ve0bh1na69h.apps.googleusercontent.com',
    iosBundleId: 'com.example.authWeb',
  );
}

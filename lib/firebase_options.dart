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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCIEtnrxlgqqlgMQXKALagiAaqnOCReLSg',
    appId: '1:662188001048:android:0c1f89555ecb5f03ddc06d',
    messagingSenderId: '662188001048',
    projectId: 'todo-app-77008',
    storageBucket: 'todo-app-77008.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAsSdr8I2x7Uu7HHYe22WCaZK-0E-KICyc',
    appId: '1:662188001048:ios:d4cf5d47999a9d7bddc06d',
    messagingSenderId: '662188001048',
    projectId: 'todo-app-77008',
    storageBucket: 'todo-app-77008.appspot.com',
    androidClientId: '662188001048-62mj8g5ujd59i06fug8jn06anjtms8kk.apps.googleusercontent.com',
    iosClientId: '662188001048-8gvt12dc0eln2m9i3k3clcum44g2qng7.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoApp',
  );
}

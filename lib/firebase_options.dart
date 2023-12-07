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
    apiKey: 'AIzaSyB7M1heoDlaW4_LFIiYi4Outx4neW5lTp0',
    appId: '1:601153263178:web:9e4e2b73c1a9cc9ebe38b3',
    messagingSenderId: '601153263178',
    projectId: 'stopwatch-flutter-bc0cf',
    authDomain: 'stopwatch-flutter-bc0cf.firebaseapp.com',
    storageBucket: 'stopwatch-flutter-bc0cf.appspot.com',
    measurementId: 'G-6TGJPNYMRN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCi4gQjtWop_BdueAcDUdefikVaILREazE',
    appId: '1:601153263178:android:386456cbe8d24eafbe38b3',
    messagingSenderId: '601153263178',
    projectId: 'stopwatch-flutter-bc0cf',
    storageBucket: 'stopwatch-flutter-bc0cf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDE8SYgxRKr3KyqnN0zdvtgUf-u7ngatco',
    appId: '1:601153263178:ios:8da19a97c65adc9abe38b3',
    messagingSenderId: '601153263178',
    projectId: 'stopwatch-flutter-bc0cf',
    storageBucket: 'stopwatch-flutter-bc0cf.appspot.com',
    iosBundleId: 'com.example.stopwatchApp',
  );
}

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
    apiKey: 'AIzaSyBEFF0jtLKfiSSE8gZBew5kveRlZL9Jq0o',
    appId: '1:681634498746:web:a8a83faedee70cc3649a83',
    messagingSenderId: '681634498746',
    projectId: 'appventure-a983b',
    authDomain: 'appventure-a983b.firebaseapp.com',
    storageBucket: 'appventure-a983b.appspot.com',
    measurementId: 'G-14M78WPMYN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCjHE66yU2rSuVlKAcLqtmihIahYcnZjyE',
    appId: '1:681634498746:android:ab8504f362d29262649a83',
    messagingSenderId: '681634498746',
    projectId: 'appventure-a983b',
    storageBucket: 'appventure-a983b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBstkiBAbdgLm89qyEvyIUUtvhlNCxDcyc',
    appId: '1:681634498746:ios:5972c7dd698d280a649a83',
    messagingSenderId: '681634498746',
    projectId: 'appventure-a983b',
    storageBucket: 'appventure-a983b.appspot.com',
    iosClientId: '681634498746-oiqn6gjpp113o0th1vq2r5csan8cq444.apps.googleusercontent.com',
    iosBundleId: 'de.myappventure.appventure',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBstkiBAbdgLm89qyEvyIUUtvhlNCxDcyc',
    appId: '1:681634498746:ios:5972c7dd698d280a649a83',
    messagingSenderId: '681634498746',
    projectId: 'appventure-a983b',
    storageBucket: 'appventure-a983b.appspot.com',
    iosClientId: '681634498746-oiqn6gjpp113o0th1vq2r5csan8cq444.apps.googleusercontent.com',
    iosBundleId: 'de.myappventure.appventure',
  );
}

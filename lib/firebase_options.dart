// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDOf3QU3TCYQf1LkPynXmrij1bUyEA5w5w',
    appId: '1:761321428636:web:784edc6bdb3da5c25e7f59',
    messagingSenderId: '761321428636',
    projectId: 'finallyloan-a34ea',
    authDomain: 'finallyloan-a34ea.firebaseapp.com',
    storageBucket: 'finallyloan-a34ea.appspot.com',
    measurementId: 'G-7LE6RRH5P9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA97iZXbFhPu0d-ruftbHNN5-BKIkgaVDk',
    appId: '1:761321428636:android:6e5350d4e45a1aba5e7f59',
    messagingSenderId: '761321428636',
    projectId: 'finallyloan-a34ea',
    storageBucket: 'finallyloan-a34ea.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAmWF1xSoyozoKm2JBagG3Cx_hdnGtif7A',
    appId: '1:761321428636:ios:1a73e9753db8317f5e7f59',
    messagingSenderId: '761321428636',
    projectId: 'finallyloan-a34ea',
    storageBucket: 'finallyloan-a34ea.appspot.com',
    androidClientId: '761321428636-8vimbejo68nno556oshkgj6i5ea0toih.apps.googleusercontent.com',
    iosClientId: '761321428636-pcm107d07mfo4lvuskce8b42mtg7mven.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAmWF1xSoyozoKm2JBagG3Cx_hdnGtif7A',
    appId: '1:761321428636:ios:1a73e9753db8317f5e7f59',
    messagingSenderId: '761321428636',
    projectId: 'finallyloan-a34ea',
    storageBucket: 'finallyloan-a34ea.appspot.com',
    androidClientId: '761321428636-8vimbejo68nno556oshkgj6i5ea0toih.apps.googleusercontent.com',
    iosClientId: '761321428636-pcm107d07mfo4lvuskce8b42mtg7mven.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDOf3QU3TCYQf1LkPynXmrij1bUyEA5w5w',
    appId: '1:761321428636:web:d3a3d4f38997c7395e7f59',
    messagingSenderId: '761321428636',
    projectId: 'finallyloan-a34ea',
    authDomain: 'finallyloan-a34ea.firebaseapp.com',
    storageBucket: 'finallyloan-a34ea.appspot.com',
    measurementId: 'G-RXZLK7BBYX',
  );

}
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login/loginpage.dart';
import 'package:flutter_application_1/pages/apply_loan.dart';
import 'package:flutter_application_1/pages/bottomnavigatinbar.dart';
import 'package:flutter_application_1/pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (kIsWeb) {
    await Firebase.initializeApp(options: const FirebaseOptions(apiKey: "AIzaSyDOf3QU3TCYQf1LkPynXmrij1bUyEA5w5w",
  authDomain: "finallyloan-a34ea.firebaseapp.com",
  projectId: "finallyloan-a34ea",
  storageBucket: "finallyloan-a34ea.appspot.com",
  messagingSenderId: "761321428636",
  appId: "1:761321428636:web:784edc6bdb3da5c25e7f59",
  measurementId: "G-7LE6RRH5P9"));
  } else {
    await Firebase.initializeApp();
  }
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Applyloan(),
    );
  }
}
// how to report a scammer?
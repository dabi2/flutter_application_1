import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin/Loan_request.dart';
import 'package:flutter_application_1/borrower/lun.dart';
import 'package:flutter_application_1/borrower/notifications.dart';
import 'package:flutter_application_1/cloudMessaging/fcm.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/login/loginpage.dart';
import 'package:flutter_application_1/borrower/AccountInformation.dart';
import 'package:flutter_application_1/borrower/apply_loan.dart';
import 'package:flutter_application_1/borrower/bottomnavigatinbar.dart';
import 'package:flutter_application_1/borrower/form_to_apply.dart';
import 'package:flutter_application_1/borrower/homepage.dart';
import 'package:flutter_application_1/borrower/interest_rate_page.dart';
import 'package:flutter_application_1/borrower/loanpage.dart';
import 'package:flutter_application_1/borrower/profilepage.dart';
import 'package:flutter_application_1/borrower/test2.dart';
import 'package:flutter_application_1/razor_pay/razorpay.dart';

final navigatorKey = GlobalKey<NavigatorState>();
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
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.subscribeToTopic('sample');
  await FirebaseCm().initNotifictaions();
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home:  const LogIn(),
      navigatorKey: navigatorKey,
      routes: {
        '/notification_screen':(context) => NotificationsPage(),
      },
    );
  }
}
// Sure, let's calculate the COCOMO model for an organic type project based on the total lines of code (LOC) you provided.

// Given:
// Total Lines of Code (LOC) = 2852

// Since the Basic COCOMO model for organic type projects uses the formula:

// \[ Effort = a \times (KLOC)^b \]

// We need to determine the values of \( a \) and \( b \) for organic projects. For organic projects, typical values are \( a = 2.4 \) and \( b = 1.05 \).

// Using the provided LOC, we first convert it to KLOC:
// \[ KLOC = \frac{2852}{1000} = 2.852 \]

// Now, we can calculate the effort:
// \[ Effort = 2.4 \times (2.852)^{1.05} \]

// \[ Effort \approx 2.4 \times (3.089)^{1.05} \]

// \[ Effort \approx 2.4 \times 3.409 \]

// \[ Effort \approx 8.181 person-months \]

// So, based on the provided LOC and the Basic COCOMO model for organic type projects, the estimated effort required for your project is approximately 8.181 person-months.
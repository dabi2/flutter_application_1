import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/login/loginpage.dart';
import 'package:flutter_application_1/pages/AccountInformation.dart';
import 'package:flutter_application_1/pages/apply_loan.dart';
import 'package:flutter_application_1/pages/bottomnavigatinbar.dart';
import 'package:flutter_application_1/pages/form_to_apply.dart';
import 'package:flutter_application_1/pages/homepage.dart';
import 'package:flutter_application_1/razor_pay/razorpay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      home: const RazorpayScreen(),
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
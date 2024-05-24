import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login/loginpage.dart';

void _logout(BuildContext context) async{
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LogIn()));
}
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';

// class DisplayImagesPage extends StatefulWidget {
//   const DisplayImagesPage({super.key});

//   @override
//   State<DisplayImagesPage> createState() => DisplayImagesPageState();
// }

// class DisplayImagesPageState extends State<DisplayImagesPage> {
//   User? user;
//   final userId = user!.uid;
//   late String imageUrl;
//   final storage = FirebaseStorage.instance;
//   void initState(){
//     super.initState();
//     imageUrl = '';
//     getImageUrl();
//   }
//   Future<void> getImageUrl()async{
//     final ref = storage.ref().child('LOAN_DOCUMENTS/$userId/$category/$fileName')
//   }
//   @override

//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
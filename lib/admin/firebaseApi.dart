import 'dart:io';

// import 'package:FirebaseApi';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// class FirebaseApi {
//   static UploadTask? uploadFile(String destination, File file) {
//     try {
//       final ref = FirebaseStorage.instance.ref(destination);
//     return ref.putFile(file);
//     } catch(e) {
//       debugPrint('FAILED TO UPLOAD FILE: $e');
//     }
    
//   }
// }
// class FirebaseApi {
//   static Future<List<String>> listFiles(String path) async {
//     final ref = FirebaseStorage.instance.ref(path);
//     final result = await ref.listAll();
//     final urls = await Future.wait(result.items.map((ref) => ref.getDownloadURL()).toList());
//     return urls;
//   }
// }

class FirebaseApi {
  static Future<UploadTask?> uploadFile(String destination, File file) async {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } catch (e) {
      debugPrint('FAILED TO UPLOAD FILE: $e');
      return null;
    }
  }

  static Future<List<String>> listFiles(String path) async {
    try {
      final ref = FirebaseStorage.instance.ref(path);
      final result = await ref.listAll();
      final urls = await Future.wait(result.items.map((ref) => ref.getDownloadURL()).toList());
      return urls;
    } catch (e) {
      print('FAILED TO LIST FILES: $e');
      return [];
    }
  }
}


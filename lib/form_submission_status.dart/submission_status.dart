import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void checkFormSubmissionStatus(BuildContext context, VoidCallback proceedToSubmit) async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final existingForms = await FirebaseFirestore.instance
        .collection('Applicant_name')
        .where('userId', isEqualTo: userId)
        .get();

    if (existingForms.docs.isNotEmpty) {
      // If the user already has a submitted form, show a dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Form Already Submitted"),
            content: Text(
                "Your loan application is already in progress. We will notify you through email and SMS once processed."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      // If the user hasn't submitted a form yet, proceed with submission
      proceedToSubmit();
    }
  } catch (e) {
    // Handle errors
    print('Error checking form submission status: $e');
    // Show an error message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Error checking form submission status. Please try again later')),
    );
  }
}

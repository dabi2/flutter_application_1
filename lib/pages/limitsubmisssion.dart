import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> hasUserSubmittedFormOnce(String userId) async {
  try {
    // Query Firestore to check if the user has submitted the form
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('Applicant_name')
        .where('userId', isEqualTo: userId)
        .get();

    // Check if any documents are returned
    return querySnapshot.docs.isNotEmpty;
  } catch (e) {
    // Handle any errors
    print('Error checking form submission status: $e');
    return false; // Assume submission status as false in case of error
  }
}


void updateFormSubmissionStatusInDatabase() async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User is not authenticated, handle accordingly
      print('User is not authenticated');
      return;
    }

    String userId = user.uid;

    // Update the user's document in Firestore to indicate that the form has been submitted
    await FirebaseFirestore.instance.collection('Users').doc(userId).update({
      'formSubmitted': true,
    });
  } catch (e) {
    // Handle any errors
    print('Error updating form submission status in database: $e');
  }
}



import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:flutter_application_1/pages/AccountInformation.dart';
import 'package:flutter_application_1/pages/apply_loan.dart';
import 'package:flutter_application_1/pages/limitsubmisssion.dart';

class Personalinformation extends StatefulWidget {
  const Personalinformation({super.key});

  @override
  State<Personalinformation> createState() => _PersonalinformationState();
}

class _PersonalinformationState extends State<Personalinformation> {
  bool isFormSubmitted = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();


void _submitForm() async {
  // Check if the user is authenticated
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    // User is not authenticated, handle accordingly
    print('User is not authenticated');
    return;
  }

  String userId = user.uid;

  // Check if the form has already been submitted
  bool formSubmitted = await hasUserSubmittedFormOnce(userId);

  if (formSubmitted) {
    // Form has already been submitted, show warning message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text('You have already submitted the form. You can only submit it once.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Applyloan(),));
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } else {
    // Form has not been submitted, proceed with form submission
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed to save data to Firebase
      try {
        await FirebaseFirestore.instance.collection('Applicant_name').add({
          'userId': userId, // Include the userId in the document
          'name': _nameController.text,
          'Gender': _genderController.text,
          'Address': _addressController.text,
          'Father_name': _fatherNameController.text,
          'dob': _dobController.text,
          'aadhar': _aadharController.text,
          'Loan Amount': _loanAmountController.text,
          'ifsc': _ifscController.text,
        });

        // Clear form fields after successful submission
        _nameController.clear();
        _genderController.clear();
        _addressController.clear();
        _dobController.clear();
        _aadharController.clear();
        _loanAmountController.clear();
        _ifscController.clear();
        _fatherNameController.clear();

        // Navigate to the next page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AccountInformation(isFormSubmitted: true),
          ),
        );

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form submitted successfully')),
        );
      } catch (e) {
        // Handle errors
        print('Error submitting form: $e');
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error submitting form. Please try again later'),
          ),
        );
      }
    }
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.body,
      // male.name.address.fathername.dob.adharnumber.loanamount.IFSC code.
      appBar: AppBar(
        backgroundColor: MainColors.appbar,
        title: const Text(
          "PERSONAL INFORMATION",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountInformation(isFormSubmitted: isFormSubmitted,),
                    ));
              },
              icon: Icon(Icons.notification_important))
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _genderController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your gender';
                        }
                        return null;
                      },
                      // ,hintStyle: TextStyle(color: Colors.white),
                      // labelStyle: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 77, 68, 68))),
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.person_2,
                            color: Colors.white,
                          ),
                          labelText: "Gender",
                          hintText: 'Male',
                          hintStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 77, 68, 68))),
                          hintStyle: TextStyle(color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          // labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Your Name',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _addressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 77, 68, 68))),
                          hintStyle: TextStyle(color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Your address',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _fatherNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your father name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 77, 68, 68))),
                          hintStyle: TextStyle(color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Father\'s Name',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _dobController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your date of birth';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 77, 68, 68))),
                          hintStyle: TextStyle(color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Date of Birth',
                          hintText: 'dd/mm/yy',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _aadharController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Adhar';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 77, 68, 68))),
                          hintStyle: TextStyle(color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Aadhar',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _loanAmountController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Loan Amount';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 77, 68, 68))),
                          hintStyle: TextStyle(color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Loan Amount',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _ifscController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter IFSC';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'IFSC',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MainColors.lightgreen,
                        shape: RoundedRectangleBorder(),
                      ),
                      onPressed: _submitForm,
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    //   ElevatedButton(
                    //   style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)) ),
                    //   onPressed: _submitForm,
                    //   child: const Text('Submit'),
                    // ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}

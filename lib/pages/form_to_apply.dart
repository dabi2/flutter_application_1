import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/AccountInformation.dart';
import 'package:flutter_application_1/pages/apply_loan.dart';
import 'package:google_fonts/google_fonts.dart';

class Personalinformation extends StatefulWidget {
  const Personalinformation({super.key});

  @override
  State<Personalinformation> createState() => PersonalinformationState();
}

class PersonalinformationState extends State<Personalinformation> {
  String fullname = "", dob = "", fatherName = "", address = "", gender = "", aadhar = "",ifsc = "",passport = "",loanAmount = "";
  TextEditingController fullmamecontroller = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();
  TextEditingController fatherNamecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController gendercontroller = TextEditingController();
  TextEditingController aadharcontroller = TextEditingController();
  TextEditingController ifsccontroller = TextEditingController();
  TextEditingController passportSizecontroller = TextEditingController();
  TextEditingController loanAmountcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PERSONAL INFORMATION",
          style: GoogleFonts.lato(fontSize: 16),
        ),
      ),
      body:ListView(
        children: [
          Column(
        children: [
          const Text(
              "here should have a male and female pincode also pan number and adhar"),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 30.0),
                    decoration: BoxDecoration(
                        color: const Color(0xFFedf0f8),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Choose your Gender';
                        }
                        return null;
                      },
                      controller: gendercontroller,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Male",
                          hintStyle: TextStyle(
                              color: Color(0xFFb2b7bf), fontSize: 18.0)),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 30.0),
                    decoration: BoxDecoration(
                        color: const Color(0xFFedf0f8),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Fullname';
                        }
                        return null;
                      },
                      controller: fullmamecontroller,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Name",
                          hintStyle: TextStyle(
                              color: Color(0xFFb2b7bf), fontSize: 18.0)),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 30.0),
                    decoration: BoxDecoration(
                        color: const Color(0xFFedf0f8),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter dob';
                        }
                        return null;
                      },
                      controller: addresscontroller,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "address",
                          hintStyle: TextStyle(
                              color: Color(0xFFb2b7bf), fontSize: 18.0)),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                     Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 30.0),
                    decoration: BoxDecoration(
                        color: const Color(0xFFedf0f8),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter father name';
                        }
                        return null;
                      },
                      controller: fatherNamecontroller,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "farher name",
                          hintStyle: TextStyle(
                              color: Color(0xFFb2b7bf), fontSize: 18.0)),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 30.0),
                    decoration: BoxDecoration(
                        color: const Color(0xFFedf0f8),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please Enter father name';
                      //   }
                      //   return null;
                      // },
                      controller: dobcontroller,
                      decoration: const InputDecoration(
                          filled: true,
                          prefixIcon: Icon(Icons.calendar_today),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          border: InputBorder.none,
                          hintText: "dob",
                          hintStyle: TextStyle(
                              color: Color(0xFFb2b7bf), fontSize: 18.0)),
                      readOnly: true,
                      onTap: () {
                        _selectDate();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                   Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 30.0),
                    decoration: BoxDecoration(
                        color: const Color(0xFFedf0f8),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Aadhar Number';
                        }
                        return null;
                      },
                      controller: aadharcontroller,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Aadhar Number",
                          hintStyle: TextStyle(
                              color: Color(0xFFb2b7bf), fontSize: 18.0)),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                   Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 30.0),
                    decoration: BoxDecoration(
                        color: const Color(0xFFedf0f8),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter THE Correct IFSC code';
                        }
                        return null;
                      },
                      controller: ifsccontroller,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Loan Amount",
                          hintStyle: TextStyle(
                              color: Color(0xFFb2b7bf), fontSize: 18.0)),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                   Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 30.0),
                    decoration: BoxDecoration(
                        color: const Color(0xFFedf0f8),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Loan Amount';
                        }
                        return null;
                      },
                      controller: loanAmountcontroller,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Loan Amount",
                          hintStyle: TextStyle(
                              color: Color(0xFFb2b7bf), fontSize: 18.0)),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                   
                  
                  FloatingActionButton(
                    onPressed: _submitForm,
                    child: const Icon(Icons.arrow_forward_ios_rounded),
                  )
                ],
              ),
            ),
          )
        ],
      ),
        ],
      ) 
      
    );
  }
  


  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (picked != null) {
      setState(() {
        dobcontroller.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formkey.currentState!.validate()) {
      // Form is valid, proceed to save data to Firebase
      try {
        showDialog(
          context: context,
          barrierDismissible: false, 
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );

        String? userId = FirebaseAuth.instance.currentUser?.uid;

        // Perform form submission asynchronously
        await Future.delayed(const Duration(seconds: 2));
        await FirebaseFirestore.instance.collection('Applicant').add({
          'userId':userId,
          'fullName': fullmamecontroller.text,
          'dob': dobcontroller.text,
          'fatherName': fatherNamecontroller.text,
          'address': addresscontroller.text,
          'gender': gendercontroller.text,
          'aadhar': aadharcontroller.text,
          'ifsc': ifsccontroller.text,
          'loanAmount': loanAmountcontroller.text,
        });
        // Clear form fields after successful submission
        fullmamecontroller.clear();
        dobcontroller.clear();
        fatherNamecontroller.clear();
        addresscontroller.clear();
        gendercontroller.clear();
        aadharcontroller.clear();
        ifsccontroller.clear();
        loanAmountcontroller.clear();
        // navigate to a bank info
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AccountInformation()));
        // navigate to a bank info

        // Optionally show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form submitted successfully')),
        );
      } catch (e) {
        // Handle errors
        print('Error submitting form: $e');
        // Optionally show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Error submitting form. Please try again later')),
        );
      }
    }
  }
}

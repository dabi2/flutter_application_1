import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/AccountInformation.dart';
import 'package:google_fonts/google_fonts.dart';

class Personalinformation extends StatefulWidget {
  const Personalinformation({super.key});

  @override
  State<Personalinformation> createState() => PersonalinformationState();
}

class PersonalinformationState extends State<Personalinformation> {
  String fullname = "", dob = "", fatherName = "", address = "";
  TextEditingController fullmamecontroller = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();
  TextEditingController fatherNamecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();

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
      body: Column(
        children: [
          Form(
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
                FloatingActionButton(
                  onPressed: _submitForm,
                  child: Icon(Icons.arrow_forward_ios_rounded),
                )
              ],
            ),
          )
        ],
      ),
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
          barrierDismissible: false, // Prevent user from dismissing dialog
          builder: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator(
                // semanticsLabel: "please wait for a minute",
              ),
            );
          },
        );

        // Perform form submission asynchronously
        await Future.delayed(Duration(seconds: 2));
        await FirebaseFirestore.instance.collection('personal_info').add({
          'fullName': fullmamecontroller.text,
          'dob': dobcontroller.text,
          'fatherName': fatherNamecontroller.text,
          'address': addresscontroller.text,
        });
        // Clear form fields after successful submission
        fullmamecontroller.clear();
        dobcontroller.clear();
        fatherNamecontroller.clear();
        addresscontroller.clear();
        // navigate to a bank info
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AccountInformation()));

        // navigate to a bank info

        // Optionally show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Form submitted successfully')),
        );
      } catch (e) {
        // Handle errors
        print('Error submitting form: $e');
        // Optionally show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error submitting form. Please try again later')),
        );
      }
    }
  }
}

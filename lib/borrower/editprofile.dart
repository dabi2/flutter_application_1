import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditPersonalInformation extends StatefulWidget {
  const EditPersonalInformation({Key? key}) : super(key: key);

  @override
  _EditPersonalInformationState createState() =>
      _EditPersonalInformationState();
}

class _EditPersonalInformationState extends State<EditPersonalInformation> {
  List<int> items = List.generate(20, (i) => i);

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      items = List.generate(20, (i) => i + 20); // Update with new data
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? loanType;
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<Map<String, dynamic>?> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      debugPrint('User is not authenticated');
      return null;
    }

    String userId = user.uid;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Applicant_name')
        .where('userId', isEqualTo: userId)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data() as Map<String, dynamic>;
    }

    return null;
  }

  Future<void> _loadUserData() async {
    Map<String, dynamic>? userData = await _fetchUserData();
    if (userData != null) {
      setState(() {
        loanType = userData['loanType'];
        _nameController.text = userData['name'];
        _genderController.text = userData['Gender'];
        _addressController.text = userData['Address'];
        _accountNumberController.text = userData['AccountNumber'];
        _fatherNameController.text = userData['Father_name'];
        _phoneNumberController.text = userData['phone number'];
        _loanAmountController.text = userData['Loan Amount'];
        _ifscController.text = userData['ifsc'];
      });
    }
  }

  Future<void> _updateUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      debugPrint('User is not authenticated');
      return;
    }

    String userId = user.uid;

    if (_formKey.currentState!.validate()) {
      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('Applicant_name')
            .where('userId', isEqualTo: userId)
            .get();

        if (snapshot.docs.isNotEmpty) {
          String docId = snapshot.docs.first.id;

          await FirebaseFirestore.instance
              .collection('Applicant_name')
              .doc(docId)
              .update({
            'loanType': loanType,
            'name': _nameController.text,
            'Gender': _genderController.text,
            'Address': _addressController.text,
            'AccountNumber': _accountNumberController.text,
            'Father_name': _fatherNameController.text,
            'phone number': _phoneNumberController.text,
            'Loan Amount': _loanAmountController.text,
            'ifsc': _ifscController.text,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Information updated successfully')),
          );
        }
      } catch (e) {
        debugPrint('Error updating user data: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error updating information. Please try again later'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MainColors.body,
        appBar: AppBar(
          backgroundColor: MainColors.appbar,
          title: const Text(
            "EDIT PERSONAL INFORMATION",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          color: MainColors.lightgreen,
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: loanType,
                      decoration: const InputDecoration(
                        labelText: "Loan Type",labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "Car Loan",
                          child: Text("Car Loan"),
                        ),
                        DropdownMenuItem(
                          value: "Home Loan",
                          child: Text("Home Loan"),
                        ),
                        DropdownMenuItem(
                          value: "Instant Loan",
                          child: Text("Instant Loan"),
                        ),
                        DropdownMenuItem(
                          value: "Personal Loan",
                          child: Text("Personal Loan"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          loanType = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a loan type*';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _genderController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your gender';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Gender",labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Your Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _addressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Your address',labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _fatherNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your father\'s name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Father\'s Name',labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _accountNumberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your valid Account Number';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Account Number',labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _loanAmountController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Loan Amount';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Loan Amount',labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _ifscController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter IFSC';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'IFSC',labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _phoneNumberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Phone Number';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _updateUserData,
                      child: const Text('Update Profile'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

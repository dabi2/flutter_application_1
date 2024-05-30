import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/borrower/homepage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:flutter_application_1/borrower/AccountInformation.dart';
import 'package:flutter_application_1/borrower/apply_loan.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Personalinformation extends StatefulWidget {
  const Personalinformation({super.key});

  @override
  State<Personalinformation> createState() => _PersonalinformationState();
}

class _PersonalinformationState extends State<Personalinformation> {
  List<int> items = List.generate(20, (i) => i);

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      items = List.generate(20, (i) => i + 20);  // Update with new data
    });
  }
  bool isFormSubmitted = false;
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

  // image picker start
  final ImagePicker _picker = ImagePicker();
  String? imageUrl;

  Future<void> _pickAndUploadImage(String docType) async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);

    if (file == null) return;

    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();

      await _saveImageUrlToFirestore(imageUrl!, docType);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$docType uploaded successfully')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload $docType')),
      );
    }
  }

  Future<void> _saveImageUrlToFirestore(String imageUrl, String docType) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User is not authenticated');
      return;
    }

    String userId = user.uid;

    await FirebaseFirestore.instance.collection('UserDocuments').add({
      'userId': userId,
      'documentType': docType,
      'downloadURL': imageUrl,
      'uploadedAt': Timestamp.now(),
    });
  }

  Future<bool> hasUserSubmittedFormOnce(String userId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Applicant_name')
        .where('userId', isEqualTo: userId)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  void _submitForm() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      debugPrint('User is not authenticated');
      return;
    }

    String userId = user.uid;

    bool formSubmitted = await hasUserSubmittedFormOnce(userId);

    if (formSubmitted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.warning_amber_rounded),
                Title(color: Colors.red, child: const  Text("Warning!"))
              ],
            ),
            content: const Text(
                'You have already submitted the form. You can only submit it once.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(),
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      if (_formKey.currentState!.validate()) {
        try {
          await FirebaseFirestore.instance.collection('Applicant_name').add({
            'loanType': loanType,
            'userId': userId,
            'name': _nameController.text,
            'Gender': _genderController.text,
            'Address': _addressController.text,
            'AccountNumber': _accountNumberController.text,
            'Father_name': _fatherNameController.text,
            'phone number': _phoneNumberController.text,
            // 'dob': _dobController.text,
            // 'aadhar': _aadharController.text,
            'Loan Amount': _loanAmountController.text,
            'ifsc': _ifscController.text,
          });

          _nameController.clear();
          _accountNumberController.clear();
          _genderController.clear();
          _addressController.clear();
          // _dobController.clear();
          // _aadharController.clear();
          _loanAmountController.clear();
          _ifscController.clear();
          _fatherNameController.clear();
          _phoneNumberController.clear();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AccountInformation(isFormSubmitted: true),
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Form submitted successfully')),
          );
        } catch (e) {
          print('Error submitting form: $e');
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
                  builder: (context) => AccountInformation(
                    isFormSubmitted: isFormSubmitted,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.notification_important),
          ),
        ],
      ),
      body: RefreshIndicator(child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: loanType,
                    decoration: const InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(style: BorderStyle.solid),
                      ),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 16),
                      labelText: "Loan Type",
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 77, 68, 68)),
                      ),
                      focusColor: Colors.black,
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
                    keyboardType: TextInputType.name,
                    controller: _genderController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your gender';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 77, 68, 68)),
                      ),
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.person_2, color: Colors.white),
                      labelText: "Gender",
                      hintText: 'Male',
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
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
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 77, 68, 68)),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Your Name',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
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
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 77, 68, 68)),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Your address',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
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
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 77, 68, 68)),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Father\'s Name',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
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
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 77, 68, 68)),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Account Number',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // TextFormField(
                  //   controller: _dobController,
                  //   readOnly: true,
                  //   onTap: () async {
                  //     DateTime? picked = await showDatePicker(
                  //       context: context,
                  //       initialDate: DateTime.now(),
                  //       firstDate: DateTime(1900),
                  //       lastDate: DateTime(2100),
                  //     );
                  //     if (picked != null) {
                  //       setState(() {
                  //         _dobController.text = picked.toString().split(" ")[0];
                  //       });
                  //     }
                  //   },
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter your date of birth';
                  //     }
                  //     return null;
                  //   },
                  //   decoration: const InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderSide:
                  //           BorderSide(color: Color.fromARGB(255, 77, 68, 68)),
                  //     ),
                  //     hintStyle: TextStyle(color: Colors.white),
                  //     labelStyle: TextStyle(color: Colors.white),
                  //     labelText: 'Date of Birth',
                  //     hintText: 'dd/mm/yy',
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // TextFormField(
                  //   controller: _aadharController,
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter Aadhar';
                  //     }
                  //     return null;
                  //   },
                  //   decoration: const InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderSide:
                  //           BorderSide(color: Color.fromARGB(255, 77, 68, 68)),
                  //     ),
                  //     hintStyle: TextStyle(color: Colors.white),
                  //     labelStyle: TextStyle(color: Colors.white),
                  //     labelText: 'Aadhar',
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     ),
                  //   ),
                  // ),
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
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 77, 68, 68)),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Loan Amount',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
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
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'IFSC',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _phoneNumberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Phone Number';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MainColors.lightgreen,
                      shape: RoundedRectangleBorder(),
                    ),
                    onPressed: _submitForm,
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ), onRefresh: _refresh));
  }
}

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin/firebaseApi.dart';
import 'package:flutter_application_1/borrower/homepage.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({Key? key, required bool isFormSubmitted})
      : super(key: key);

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  File? aadharFile;
  File? panFile;
  File? categoryFile;
  File? dobFile;
  File? accountProofFile;

  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Handle the case when user is not logged in
      // For example, you can navigate to the login page
    }
  }

  @override
  Widget build(BuildContext context) {
    final aadharFileName =
        aadharFile != null ? basename(aadharFile!.path) : 'No file selected';
    final panFileName =
        panFile != null ? basename(panFile!.path) : 'No file selected';
    final categoryFileName = categoryFile != null
        ? basename(categoryFile!.path)
        : 'No file selected';
    final dobFileName =
        dobFile != null ? basename(dobFile!.path) : 'No file selected';
    final accountProofFileName = accountProofFile != null
        ? basename(accountProofFile!.path)
        : 'No file selected';

    return Scaffold(
      backgroundColor: MainColors.body,
      appBar: AppBar(
        backgroundColor: MainColors.appbar,
        title: Text(
          "UPLOAD YOUR DOCUMENTS",
          style: GoogleFonts.audiowide(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          buildFileUploadSection(context, "Upload Aadhar Card", aadharFileName,
              () => selectFile((file) => setState(() => aadharFile = file))),
          buildFileUploadSection(context, "Upload PAN Card", panFileName,
              () => selectFile((file) => setState(() => panFile = file))),
          buildFileUploadSection(
              context,
              "Upload Category Certificate",
              categoryFileName,
              () => selectFile((file) => setState(() => categoryFile = file))),
          buildFileUploadSection(
              context,
              "Upload Date of Birth Proof",
              dobFileName,
              () => selectFile((file) => setState(() => dobFile = file))),
          buildFileUploadSection(
              context,
              "Upload Account Proof",
              accountProofFileName,
              () => selectFile(
                  (file) => setState(() => accountProofFile = file))),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: uploadFiles,
            child: Text(
              "Upload All Files",
              style:
                  GoogleFonts.inter(fontSize: 16, color: MainColors.lightgreen),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFileUploadSection(BuildContext context, String title,
      String fileName, VoidCallback onPressed) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(fileName),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: onPressed,
          child: Text(
            "Select File",
            style:
                GoogleFonts.inter(fontSize: 16, color: MainColors.lightgreen),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Future selectFile(Function(File) onFileSelected) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;

    final path = result.files.single.path!;
    onFileSelected(File(path));
  }

  Future uploadFiles() async {
    if (user == null) return;

    if (aadharFile == null ||
        panFile == null ||
        categoryFile == null ||
        dobFile == null ||
        accountProofFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select all required files')),
      );
      return;
    }

    final userId = user!.uid;

    if (aadharFile != null) await uploadFile(aadharFile!, userId, 'aadhar');
    if (panFile != null) await uploadFile(panFile!, userId, 'pan');
    if (categoryFile != null)
      await uploadFile(categoryFile!, userId, 'category');
    if (dobFile != null) await uploadFile(dobFile!, userId, 'dob');
    if (accountProofFile != null)
      await uploadFile(accountProofFile!, userId, 'account_proof');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Files uploaded successfully')),
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:  Text('Congratulaions!',style: GoogleFonts.inter(color:Colors.green,fontSize:25),),
        content: const Text('Your Application Has Been Submited'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future uploadFile(File file, String userId, String category) async {
    final fileName = basename(file.path);
    final destination = 'LOAN_DOCUMENTS/$userId/$category/$fileName';
    await FirebaseApi.uploadFile(destination, file);
  }

  String basename(String path) {
    return path.split('/').last;
  }
}

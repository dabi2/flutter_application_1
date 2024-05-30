import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin/firebaseApi.dart';
import 'package:flutter_application_1/borrower/bottomnavigatinbar.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({Key? key, required this.isFormSubmitted})
      : super(key: key);

  final bool isFormSubmitted;

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
  bool isLoading = false;

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
          buildFileUploadSection(context, "Upload Aadhar Card", aadharFile,
              (file) => setState(() => aadharFile = file)),
          buildFileUploadSection(context, "Upload PAN Card", panFile,
              (file) => setState(() => panFile = file)),
          buildFileUploadSection(context, "Upload Category Certificate",
              categoryFile, (file) => setState(() => categoryFile = file)),
          buildFileUploadSection(context, "Upload Date of Birth Proof", dobFile,
              (file) => setState(() => dobFile = file)),
          buildFileUploadSection(context, "Upload Account Proof",
              accountProofFile, (file) => setState(() => accountProofFile = file)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: (aadharFile == null ||
                    panFile == null ||
                    categoryFile == null ||
                    dobFile == null ||
                    accountProofFile == null ||
                    isLoading)
                ? null
                : uploadFiles,
            child: isLoading
                ? CircularProgressIndicator()
                : Text(
                    "Upload All Files",
                    style: GoogleFonts.inter(
                        fontSize: 16, color: MainColors.lightgreen),
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildFileUploadSection(BuildContext context, String title, File? file,
      Function(File) onFileSelected) {
    final fileName = file != null ? basename(file.path) : 'No file selected';
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
          onPressed: () => selectFile(onFileSelected),
          child: Text(
            "Select File",
            style: GoogleFonts.inter(fontSize: 16, color: MainColors.lightgreen),
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

    setState(() {
      isLoading = true;
    });

    try {
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
          title: Text('Congratulations!',
              style: GoogleFonts.inter(color: Colors.green, fontSize: 25)),
          content: const Text('Your Application Has Been Submitted'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => Mybottomnavigationbar()),
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading files: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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

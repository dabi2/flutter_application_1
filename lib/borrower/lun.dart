import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin/loanrequestdu.dart';
import 'package:flutter_application_1/admin/transferfund.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPage1 extends StatefulWidget {
  const AdminPage1({Key? key}) : super(key: key);

  @override
  State<AdminPage1> createState() => _AdminPage1State();
}

class _AdminPage1State extends State<AdminPage1> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  Future<List<Map<String, dynamic>>> _loadFiles() async {
    final List<Map<String, dynamic>> files = [];

    // Get the list of users
    final userDocs = await _storage.ref('LOAN_DOCUMENTS').listAll();

    for (var userFolder in userDocs.prefixes) {
      final userId = userFolder.name;

      // Get the applicant's name from Firestore
      final userDoc = await _firestore.collection('Applicant_name').doc(userId).get();
      final userName = userDoc.exists ? userDoc.data()!['name'] ?? 'N/A' : 'N/A';

      // Get the list of categories for the user
      final categories = await userFolder.listAll();

      for (var category in categories.prefixes) {
        final categoryName = category.name;

        // Get the list of files in the category
        final fileList = await category.listAll();

        for (var fileRef in fileList.items) {
          final fileUrl = await fileRef.getDownloadURL();
          files.add({
            'userId': userId,
            'userName': userName,
            'category': categoryName,
            'fileName': fileRef.name,
            'fileUrl': fileUrl,
          });
        }
      }
    }
    return files;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainColors.appbar,
        title: Text(
          "Admin Page",
          style: GoogleFonts.audiowide(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadFiles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final files = snapshot.data ?? [];
          if (files.isEmpty) {
            return const Center(child: Text('No files found'));
          }

          // Group files by userId
          Map<String, List<Map<String, dynamic>>> groupedFiles = {};
          for (var file in files) {
            if (groupedFiles.containsKey(file['userId'])) {
              groupedFiles[file['userId']]!.add(file);
            } else {
              groupedFiles[file['userId']] = [file];
            }
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20.0),
            itemCount: groupedFiles.keys.length,
            itemBuilder: (context, index) {
              final userId = groupedFiles.keys.elementAt(index);
              final userFiles = groupedFiles[userId]!;
              final userName = userFiles.first['userName'];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminPage2(),
                            ),
                          );
                        },
                        child: Text("ok"),
                      ),
                      Text(
                        'Applicant ${index + 1}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Table(
                        border: TableBorder.all(color: Colors.grey),
                        children: [
                          TableRow(
                            decoration: BoxDecoration(color: MainColors.lightgreen),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Field"),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Data"),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Action"),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Name: "),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(userName),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AdminTransferFund(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  child: const Text(
                                    "Approve Loan",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          for (var file in userFiles) TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(file['category']),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Image.network(
                                  file['fileUrl'],
                                  height: 200,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Add any action you need
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  child: const Text(
                                    "Reject",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

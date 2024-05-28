import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin/transferfund.dart';
import 'package:flutter_application_1/borrower/homepage.dart';
import 'package:flutter_application_1/borrower/loanpage.dart';
import 'package:flutter_application_1/borrower/profilepage.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:flutter_application_1/login/loginpage.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}
class _AdminPageState extends State<AdminPage> {
  Future<List<Map<String, dynamic>>> _fetchAllApplicantData() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('Applicant_name').get();

      if (querySnapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> applicantDataList = [];

        for (var doc in querySnapshot.docs) {
          var applicantData = doc.data() as Map<String, dynamic>;
          var userId = doc.id;
          var documentUrls = await _fetchDocumentUrls(userId);

          applicantData['documents'] = documentUrls;
          applicantDataList.add(applicantData);
        }

        return applicantDataList;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint('Error fetching applicant data: $e');
      return [];
    }
  }

  Future<Map<String, String>> _fetchDocumentUrls(String userId) async {
    final documents = ['aadhar', 'pan', 'category', 'dob', 'account_proof'];
    Map<String, String> documentUrls = {};

    for (var doc in documents) {
      final ref =
          FirebaseStorage.instance.ref().child('LOAN_DOCUMENTS/$userId/$doc');
      try {
        final ListResult result = await ref.listAll();
        for (var item in result.items) {
          final url = await item.getDownloadURL();
          documentUrls[doc] = url;
        }
      } catch (e) {
        debugPrint('Error fetching $doc URL: $e');
      }
    }

    return documentUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    _logout(context);
                    debugPrint("Logging out");
                  },
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
          )
        ],
        title: Text('Admin Panel',
            style: GoogleFonts.audiowide(color: Colors.white)),
        backgroundColor: MainColors.appbar,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        
        future: _fetchAllApplicantData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            var allApplicantData = snapshot.data!;
            return ListView.builder(
              itemCount: allApplicantData.length,
              itemBuilder: (context, index) {
                var applicantData = allApplicantData[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            child: Text("data"),
                          ),
                          Text('Applicant ${index + 1}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 16),
                          Table(
                            border: TableBorder.all(color: Colors.grey),
                            children: [
                              TableRow(
                                decoration:
                                    BoxDecoration(color: MainColors.lightgreen),
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
                                    child: Text(applicantData['name'] ?? 'N/A'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(context,MaterialPageRoute(builder: (context) => AdminTransferFund(),));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
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
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Loan Type: "),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                        applicantData['loanType'] ?? 'N/A'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Add functionality for rejecting loan
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                      ),
                                      child: const Text(
                                        "Reject Loan",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Loan Amount: "),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                        applicantData['Loan Amount'] ?? 'N/A'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _showMessageDialog(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: MainColors.reminder,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                      ),
                                      child: const Text(
                                        "Reminder Message",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Account Number: "),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                        applicantData['AccountNumber'] ??
                                            'N/A'),
                                  ),
                                  const SizedBox(),
                                ],
                              ),
                              _buildDocumentRow("ST/SC/OBC",
                                  applicantData['documents']['category']),
                              _buildDocumentRow("Aadhar card",
                                  applicantData['documents']['aadhar']),
                              _buildDocumentRow("PAN card",
                                  applicantData['documents']['pan']),
                              _buildDocumentRow("Date of Birth Proof",
                                  applicantData['documents']['dob']),
                              _buildDocumentRow("Account Proof",
                                  applicantData['documents']['account_proof']),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  TableRow _buildDocumentRow(String title, String? url) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(title),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: url != null
              ? InkWell(
                  onTap: () {
                    _openDocument(url);
                    debugPrint("Image Open");
                  },
                  child: Row(
                    children: [
                      Text("OPEN"),
                      SizedBox(width: 4),
                      Icon(Icons.folder_open_rounded),
                    ],
                  ),
                )
              : Text('N/A'),
        ),
        const SizedBox(),
      ],
    );
  }
  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LogIn()),
    );
  }
  void _showMessageDialog(BuildContext context) {
    String message = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enter Message"),
          content: TextField(
            onChanged: (value) {
              message = value;
            },
            decoration:
                const InputDecoration(hintText: "Type your message here"),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Process the message
                print("Message: $message");
                Navigator.of(context).pop();
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }
  

  void _openDocument(String url) {}

  // void _showMessageDialog(BuildContext context) {}
}

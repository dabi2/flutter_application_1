import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:flutter_application_1/login/loginpage.dart'; // Corrected import statement
import 'package:google_fonts/google_fonts.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
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
        backgroundColor: Colors.blue, // Change to the desired color
        title: Center(
          child: Text(
            "ADMIN PANEL",
            style: GoogleFonts.audiowide(color: Colors.white),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: ListTile(
                title: const Text('Welcome to the Admin Dashboard'),
                subtitle: const Text('You have full control over the app.'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  // Add navigation or functionality for this card
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                    child: InkWell(
                  onTap: () {},
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.person_2,
                              size: 50,
                            ),
                            Text("Borrowers"),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        indent: 0,
                        endIndent: 0,
                      )
                    ],
                  ),
                )),
                Card(
                    child: InkWell(
                  onTap: () {},
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.request_page,
                              size: 50,
                            ),
                            Text("Loan Request"),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        indent: 0,
                        endIndent: 0,
                      )
                    ],
                  ),
                )),
                Card(
                  child: InkWell(
                    onTap: () {
                      debugPrint("test");
                    },
                    child: const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.request_page,
                                size: 50,
                              ),
                              Text("Loan Return"),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          indent: 0,
                          endIndent: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Table(
              border: TableBorder.all(color: Colors.grey),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: MainColors.lightgreen),
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: const Text("Users "),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Data"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Status"),
                    )
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
                      child: Text("Dabiang"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.green, // Change button color to green
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                2), // Make button rectangular
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
                      child: Text("HOME LOAN"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Add functionality for rejecting loan
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .red, // Change button color to red (danger color)
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                2), // Make button rectangular
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
                      child: Text("50,000"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _showMessageDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MainColors
                              .reminder, // Change button color to red (danger color)
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                2), // Make button rectangular
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
                const TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Account Number: "),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("123456789"),
                    ),
                    const SizedBox(),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("ST/SC/OBC "),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          debugPrint("Open");
                        },
                        child: Row(
                          children: [
                            Text("OPEN"),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(Icons.folder_open_rounded),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Aadhar card "),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          debugPrint("Open");
                        },
                        child: Row(
                          children: [
                            Text("OPEN"),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(Icons.folder_open_rounded),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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
}

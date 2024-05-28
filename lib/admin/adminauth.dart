import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin/Loan_request.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MainColors.body,
        appBar: AppBar(
          backgroundColor: MainColors.appbar,
          title: Text(
            'Admin Login',
            style: GoogleFonts.audiowide(color: Colors.white),
          ),
        ),
        body: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      decoration: const InputDecoration(hintText: 'Email For Admin'),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      obscureText: true,
                      decoration:
                          const InputDecoration(hintText: 'Password for Admin'),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Authenticate admin user
                      if (email == 'admin@example.com' &&
                          password == 'admin123') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                   AdminPage()), // Navigate to admin home screen
                        );
                      } else { 
                        // Display error message
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Invalid credentials',style: TextStyle(color: Colors.red),),
                        ));
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8.0), // Set border radius
                          side: const BorderSide(
                              color: Colors.blue), // Set border color
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue), // Set background color
                    ),
                    child: Text('Login',style: GoogleFonts.inter(fontSize:16,color:Colors.black),),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

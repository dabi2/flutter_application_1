import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:flutter_application_1/pages/drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {

  String _displayName = '';
  String _email = '';
  String _phoneNumber = '';
  String _fullname = '';

  @override
  Widget build(BuildContext context) {
    String initials =
        _displayName.isEmpty ? _displayName.substring(0).toUpperCase() : "??";
    return Scaffold(
      backgroundColor: MainColors.body,
      appBar: AppBar(
        backgroundColor: MainColors.appbar,
        title: Center(
            child: Text(
          'Profile',
          style: GoogleFonts.audiowide(
            color: Colors.white,
            fontSize: 25,
          ),
        )),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const Notifications()));
            },
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const Languagepage()));
            },
            icon: const Icon(
              Icons.language,
              color: Colors.white,
            ),
          ),
        ],
        elevation: 100,
      ),
      drawer: Drawerclass().buildDrawer(context),
      body: Container(
        color: MainColors.body,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[800],
                child: const Icon(
                  Icons.person_2,
                  color: Colors.white,
                ),
              ),
              Text(
                "Name: $_fullname",
                style: GoogleFonts.merriweather(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Daia@gmail.com
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    initials,
                    style: GoogleFonts.merriweather(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  // ₹
                  Text(
                    "Your Total Loan Amount is: \u20B9 10,000: $_email",
                    style: GoogleFonts.merriweather(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const Divider(
                endIndent: 50,
                indent: 50,
                color: Colors.blueGrey,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      
                      "Full Name: $_displayName",
                      style: GoogleFonts.merriweather(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(
                      endIndent: 50,
                      color: Colors.blueGrey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Email:$_email",
                      style: GoogleFonts.merriweather(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Password:$_displayName",
                      style: GoogleFonts.merriweather(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Account Number:$_displayName",
                      style: GoogleFonts.merriweather(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Adress:$_displayName",
                      style: GoogleFonts.merriweather(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Pan Number:$_displayName",
                      style: GoogleFonts.merriweather(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _displayName = user.displayName ?? '';
        _email = user.email ?? '';
        _phoneNumber = user.phoneNumber ?? '';
      });
    }
  }
}

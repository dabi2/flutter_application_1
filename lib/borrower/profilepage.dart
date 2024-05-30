import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/borrower/helpandfaq.dart';
import 'package:flutter_application_1/borrower/setting.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:flutter_application_1/borrower/drawer.dart';
import 'package:flutter_application_1/borrower/editprofile.dart';
import 'package:flutter_application_1/login/loginpage.dart';
import 'package:google_fonts/google_fonts.dart';

class Profilepagez extends StatefulWidget {
  const Profilepagez({
    super.key,
  });

  @override
  State<Profilepagez> createState() => _ProfilepagezState();
}

class _ProfilepagezState extends State<Profilepagez> {
  List<int> items = List.generate(20, (i) => i);

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      items = List.generate(20, (i) => i + 20);  // Update with new data
    });
  }
  String userId = "";
  String currentUserName = "User";

  void _getCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUserName = user.displayName ?? "User";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _getCurrentUser();
  }

  void getCurrentUser() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        userId = currentUser.uid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    Size screenSize = mediaQueryData.size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

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
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.language,
              color: Colors.white,
            ),
          ),
        ],
        elevation: 100,
      ),
      drawer: Drawerclass().buildDrawer(context),
      body: RefreshIndicator(onRefresh: _refresh,color: MainColors.lightgreen,child: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: Column(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    maxRadius: 40,
                    child: Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Text(currentUserName,style: GoogleFonts.lato(fontSize:20,color:Colors.grey),),
                  const SizedBox(
                    height: 20,
                  ),
                  // Text(
                  //   "MY ACCOUNT",
                  //   style: GoogleFonts.inter(color: Colors.white, fontSize: 20),
                  // ),
                  const Divider(
                    color: Colors.grey,
                    indent: 40,
                    endIndent: 40,
                  )
                ],
              )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EditPersonalInformation()));
                        },
                        icon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        label: Text(
                          "MY PROFILE",
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Settingscreen(),
                              ));
                        },
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        label: Text(
                          "SETTINGS",
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FAQPage(),
                              ));
                        },
                        icon: const Icon(
                          Icons.question_mark_rounded,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Helps & FAQ's",
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          _logout(context);
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.grey,
                        ),
                        label: Text(
                          "LOG OUT",
                          style: GoogleFonts.inter(
                              fontSize: 20, color: Colors.grey),
                        )),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),));
  }

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LogIn()));
  }
}

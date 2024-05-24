import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:flutter_application_1/borrower/drawer.dart';
import 'package:flutter_application_1/borrower/editprofile.dart';
// import 'package:flutter_application_1/pages/editable_personal_info.dart';
import 'package:google_fonts/google_fonts.dart';

class Profilepagez extends StatefulWidget {
  const Profilepagez({super.key});

  @override
  State<Profilepagez> createState() => _ProfilepagezState();
}

class _ProfilepagezState extends State<Profilepagez> {
  String userId = "";

  @override
  void initState() {
    super.initState();
    getCurrentUser();
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
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.person,size: 50,),
                      backgroundColor: Colors.grey,
                      maxRadius: 40,
                    ),
                    SizedBox(height: 20,),
                    Text(
                  "MY ACCOUNT",
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 20),
                ),
                Divider(
                  color: Colors.grey,
                  indent: 40,
                  endIndent: 40,
                )
                  ],
                )
              ),
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
                      builder: (context) => const UserDataPage()));
                        },
                        icon: const Icon(Icons.person,color: Colors.white,),
                        label: Text("MY PROFILE",style: GoogleFonts.inter(fontSize:20,color: Colors.white,),)),
                    const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,)
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.notifications,color: Colors.white,),
                        label: Text(
                          "NOTIFICATION SETTINGS",
                          style: GoogleFonts.inter(fontSize: 20,color: Colors.white,),
                        )),
                    Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.settings,color: Colors.white,),
                        label: Text(
                          "SETTINGS",
                          style: GoogleFonts.inter(fontSize: 20,color: Colors.white,),
                        )),
                    Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.question_mark_rounded,color: Colors.white,),
                        label: Text(
                          "Helps & FACQ's",
                          style: GoogleFonts.inter(fontSize: 20,color: Colors.white,),
                        )),
                    Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.logout,color: Colors.grey,),
                        label: Text(
                          "LOG OUT",
                          style: GoogleFonts.inter(fontSize: 20,color:Colors.grey),
                        )),
                    Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

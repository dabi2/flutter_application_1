import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:flutter_application_1/pages/drawer.dart';
import 'package:flutter_application_1/pages/test2.dart';
import 'package:flutter_application_1/pages/test3.dart';
import 'package:google_fonts/google_fonts.dart';

class Profilepagez extends StatefulWidget {
  const Profilepagez({super.key});

  @override
  State<Profilepagez> createState() => _ProfilepagezState();
}

class _ProfilepagezState extends State<Profilepagez> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    Size screenSize = mediaQueryData.size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    // String initials =
    //     _displayName.isEmpty ? _displayName.substring(0).toUpperCase() : "??";
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
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Applicant_name")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (snapshot.hasData) {
                List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
                if (documents.isEmpty) {
                  return const Center(child: Text('No data available'));
                }
                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                        documents[index].data() as Map<String, dynamic>;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 50,
                              child: Icon(Icons.person,size: 90,),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("${data['name']}",style: const TextStyle(fontSize: 20,color: Colors.white),),const SizedBox(height: 10,),
                            const Divider(
                              indent: 150,
                              endIndent: 150,
                              color: Colors.grey,
                            )

                          ],
                        ),
                        Padding(
                          padding:  const EdgeInsets.only(top: 20),
                          child: Container(
                            width: screenWidth * 0.8,
                            // height: screenHeight * 0.5,
                            decoration: BoxDecoration(
                                color: MainColors.lightcontainer,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Padding(
                              padding:  const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Name : ${data['name']}",style: const TextStyle(fontSize: 20,color: Colors.white),),const SizedBox(height: 10,),
                                  Text("Gender : ${data['Gender']}",style: const TextStyle(fontSize: 20,color: Colors.white),),const SizedBox(height: 10,),
                                  Text("Address : ${data['Address']}",style: const TextStyle(fontSize: 20,color: Colors.white),),const SizedBox(height: 10,),
                                  Text(
                                      "Father\'s Name : ${data['Father_name']}",style: const TextStyle(fontSize: 20,color: Colors.white),),const SizedBox(height: 10,),
                                  Text("DOB : ${data['dob']}",style: const TextStyle(fontSize: 20,color: Colors.white),),const SizedBox(height: 10,),
                                  Text("Aadhar Number : ${data['aadhar']}",style: const TextStyle(fontSize: 20,color: Colors.white),),const SizedBox(height: 10,),
                                  Text("Loan Amount : ${data['Loan Amount']}",style: const TextStyle(fontSize: 20,color: Colors.white),),const SizedBox(height: 10,),
                                  Text("IFSC Code : ${data['ifsc']}",style: const TextStyle(fontSize: 20,color: Colors.white),),const SizedBox(height: 10,),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              }
              return Container();
            }));
  }
}
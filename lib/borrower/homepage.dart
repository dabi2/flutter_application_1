import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:flutter_application_1/borrower/apply_loan.dart';
import 'package:flutter_application_1/borrower/drawer.dart';
import 'package:flutter_application_1/borrower/eligibilities.dart';
import 'package:flutter_application_1/borrower/interest_rate_page.dart';
import 'package:flutter_application_1/borrower/notifications.dart';
import 'package:flutter_application_1/borrower/test.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String currentUserName = "User";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentUser();
  }
  void _getCurrentUser(){
     User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUserName = user.displayName ?? "User"; // Use display name or default to "User"
      });
    }
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.body,
      appBar: AppBar(
        backgroundColor: MainColors.appbar,
        title: Center(
            child: Text(
          'Home',
          style: GoogleFonts.audiowide(
            color: Colors.white,
            fontSize: 25,
          ),
        )),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationsPage()));
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
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              
              const Center(
                child: CircleAvatar(
                  radius: 40,
                  child: Icon(
                    Icons.person,
                    size: 40,
                  ),
                ),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: " Welcome Back $currentUserName",
                    style: GoogleFonts.lato(fontSize: 20, color: Colors.grey)),
                TextSpan(
                    text: " !!",
                    style: GoogleFonts.lato(
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        color: Colors.blueGrey)),
              ])),
              Divider(
                color: MainColors.appbar,
                indent: 50,
                endIndent: 50,
              ),
              
              Container(
                decoration: BoxDecoration(
                  border: const Border(top: BorderSide.none),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: MainColors.containercolor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text("Get Loan Upto \u20B950,0000",
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            color: Colors.white,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                          text: TextSpan(
                              text:
                                  "complete your Profile and work details and get best loan offers",
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                color: Colors.white,
                              ))),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Applyloan()));
                        },
                        icon: const Icon(
                          Icons.monetization_on_rounded,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Apply Loan",
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                MainColors.lightgreen)),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    // boxShadow:List.filled(growable: bool.hasEnvironment(String), fill),
                    border: const Border(top: BorderSide.none),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: MainColors.containercolor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/images/coins.png",
                        height: 100,
                        width: 100,
                      ),
                      Column(
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: "Check Your",
                                  style: GoogleFonts.audiowide(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ))),
                          RichText(
                              text: TextSpan(
                                  text: "Credit Score",
                                  style: GoogleFonts.audiowide(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ))),
                                  ElevatedButton.icon(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  MainColors.lightgreen),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0)))),
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          label: Text("Check Your Score",
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                color: Colors.white,
                              ))),
                        ],
                      ),
                      
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    decoration: BoxDecoration(
                      border: const Border(top: BorderSide.none),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: MainColors.containercolor,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          Text(
                            "Personal Loan - Instant Loan Online",
                            style: GoogleFonts.merriweather(
                                fontSize: 20, color: Colors.white),
                          ),
                          Divider(
                            endIndent: 50,
                            indent: 50,
                            color: MainColors.lightgreen,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Card(
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/images/coins.png",
                                        height: 100,
                                        width: 100,
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            const WidgetSpan(
                                                child: Icon(
                                              Icons.access_time_filled_sharp,
                                              size: 20,
                                              color: Colors.grey,
                                            )),
                                            TextSpan(
                                                text: 'Eligibility',
                                                style: GoogleFonts.lato(
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                )),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      borrowerEligibilityPage(),
                                                ));
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      MainColors.lightgreen),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)))),
                                          icon: const Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          ),
                                          label: Text("Know More1",
                                              style: GoogleFonts.lato(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ))),
                                    ],
                                  ),
                                ),
                                Card(
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/images/coins.png",
                                        height: 100,
                                        width: 100,
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            const WidgetSpan(
                                                child: Icon(
                                              Icons.percent_rounded,
                                              size: 20,
                                              color: Colors.grey,
                                            )),
                                            TextSpan(
                                                text: 'Interest Rate',
                                                style: GoogleFonts.lato(
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                )),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      interestRatePage(),
                                                ));
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      MainColors.lightgreen),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)))),
                                          icon: const Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          ),
                                          label: Text("Know More2",
                                              style: GoogleFonts.lato(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ))),
                                    ],
                                  ),
                                ),
                                // Card(
                                //   child: Column(
                                //     children: [
                                //       Image.asset(
                                //         "images/coins.png",
                                //         height: 100,
                                //         width: 100,
                                //       ),
                                //       Text.rich(
                                //         TextSpan(
                                //           children: [
                                //             const WidgetSpan(child: Icon(Icons.file_copy_rounded,size: 20,color: Colors.grey,)),
                                //             TextSpan(text: 'Documentation',
                                //               style: GoogleFonts.lato(
                                //                 fontSize: 16,
                                //                 color: Colors.black87,
                                //               )),
                                //           ],
                                //         ),
                                //       ),
                                //      const SizedBox(
                                //         height: 10,
                                //       ),
                                //       ElevatedButton.icon(
                                //           onPressed: () {
                                //             Navigator.push(context,MaterialPageRoute(builder: (context) => LoanApplicationForm() ,));
                                //           },
                                //           style: ButtonStyle(
                                //               backgroundColor:
                                //                   MaterialStatePropertyAll(
                                //                       MainColors.lightgreen),
                                //               shape: MaterialStateProperty.all<
                                //                       RoundedRectangleBorder>(
                                //                   RoundedRectangleBorder(
                                //                       borderRadius:
                                //                           BorderRadius.circular(
                                //                               5.0)))),
                                //           icon: const Icon(
                                //             Icons.arrow_forward,
                                //             color: Colors.white,
                                //           ),
                                //           label: Text("Know More",
                                //               style: GoogleFonts.lato(
                                //                 fontWeight:FontWeight.bold,
                                //                 fontSize: 16,
                                //                 color: Colors.white,
                                //               ))),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:flutter_application_1/pages/drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class Applyloan extends StatefulWidget {
  const Applyloan({super.key});

  @override
  State<Applyloan> createState() => ApplyloanState();
}

class ApplyloanState extends State<Applyloan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.body,
      appBar: AppBar(
        backgroundColor: MainColors.appbar,
        title: Center(
            child: Text(
          'Apply Loan',
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
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 90,right: 90),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQemhFo8i7iiUqufN6ELV52w4TEfAKTFYR_mJlRy0S2wQ&s",
                              height: 150,
                            ),
                          ),
                          Text(
                            "Instant Loan",
                            style: GoogleFonts.lato(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQemhFo8i7iiUqufN6ELV52w4TEfAKTFYR_mJlRy0S2wQ&s",
                              height: 150,
                            ),
                          ),
                          Text(
                            "Instant Loan",
                            style: GoogleFonts.lato(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 90,right: 90),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Card(
                          child: Column(
                            children: [
                              Image.network(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQemhFo8i7iiUqufN6ELV52w4TEfAKTFYR_mJlRy0S2wQ&s",
                                height: 150,
                              ),
                              Text(
                                "car loan",
                                style: GoogleFonts.lato(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Card(
                      child: Column(
                        children: [
                          Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQemhFo8i7iiUqufN6ELV52w4TEfAKTFYR_mJlRy0S2wQ&s",
                            height: 150,
                          ),
                          Text(
                            "car loan",
                            style: GoogleFonts.lato(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

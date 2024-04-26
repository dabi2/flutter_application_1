import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:flutter_application_1/pages/drawer.dart';
import 'package:flutter_application_1/pages/form_to_apply.dart';
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
      // drawer: Drawerclass().buildDrawer(context),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Card(
                            child: Column(
                              children: [
                                // Image.network(
                                //   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQemhFo8i7iiUqufN6ELV52w4TEfAKTFYR_mJlRy0S2wQ&s",
                                //   height: 100,
                                //   width: 200,
                                // ),
                                const Icon(Icons.home,size: 100,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "HOME LOAN",
                                    style: GoogleFonts.lato(fontSize: 20,),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll<Color>(MainColors.lightgreen  )
                                  ),
                                    onPressed: () {
                                       Navigator.push(context,MaterialPageRoute(builder: (context) =>const Personalinformation()));
                                    },
                                    child: Text(
                                      "Apply Now",
                                      style: GoogleFonts.lato(fontSize: 16,color:Colors.black),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Card(
                        child: Column(
                          children: [
                            // Image.network(
                            //   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQemhFo8i7iiUqufN6ELV52w4TEfAKTFYR_mJlRy0S2wQ&s",
                            //   height: 100,
                            //   width: 200,
                            // ),
                            const Icon(Icons.school_rounded,size: 100,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "EDUCATION LOAN",
                                style: GoogleFonts.lato(fontSize: 20),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll<Color>(MainColors.lightgreen  )
                                  ),
                                onPressed: () {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) =>const Personalinformation()));
                                },
                                child: Text(
                                  "Apply Now",
                                  style: GoogleFonts.lato(fontSize: 16,color:Colors.black),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Card(
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.car_rental_sharp,size: 100,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "CAR LOAN",
                                    style: GoogleFonts.lato(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll<Color>(MainColors.lightgreen  )
                                  ),
                                      onPressed: () {
                                        Navigator.push(context,MaterialPageRoute(builder: (context) =>const Personalinformation()));
                                      },
                                      child: Text(
                                        "Apply Now",
                                        style: GoogleFonts.lato(fontSize: 16,color:Colors.black),
                                      )),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Card(
                        child: Column(
                          children: [
                            const Icon(Icons.person_pin,size: 100,),
                            // Image.network(
                            //   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQemhFo8i7iiUqufN6ELV52w4TEfAKTFYR_mJlRy0S2wQ&s",
                            //   height: 100,
                            //   width: 200,
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "PERSONAL LOAN",
                                style: GoogleFonts.lato(fontSize: 20),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll<Color>(MainColors.lightgreen  )
                                  ),
                                onPressed: () {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) =>const Personalinformation()));
                                },
                                child: Text(
                                  "Apply Now",
                                  style: GoogleFonts.lato(fontSize: 16,color:Colors.black),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Card(
                            child: Column(
                              children: [
                                const Icon(Icons.money,size: 100,),
                                // Image.network(
                                //   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQemhFo8i7iiUqufN6ELV52w4TEfAKTFYR_mJlRy0S2wQ&s",
                                //   height: 100,
                                //   width: 200,
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "INSTANT LOAN",
                                    style: GoogleFonts.lato(fontSize: 20),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll<Color>(MainColors.lightgreen)
                                  ),
                                    onPressed: () {
                                      Navigator.push(context,MaterialPageRoute(builder: (context) =>const Personalinformation()));
                                    },
                                    child: Text(
                                      "Apply Now",
                                      style: GoogleFonts.lato(fontSize: 16,color:Colors.black),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Card(
                        child: Column(
                          children: [
                            const Icon(Icons.person_2,size: 100,),
                            // Image.network(
                            //   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQemhFo8i7iiUqufN6ELV52w4TEfAKTFYR_mJlRy0S2wQ&s",
                            //   height: 100,
                            //   width: 200,
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "PERSONAL LOAN",
                                style: GoogleFonts.lato(fontSize: 20),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll<Color>(MainColors.lightgreen  )
                                  ),
                                onPressed: () {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) =>const Personalinformation()));
                                },
                                child: Text(
                                  "Apply Now",
                                  style: GoogleFonts.lato(fontSize: 16,color:Colors.black),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

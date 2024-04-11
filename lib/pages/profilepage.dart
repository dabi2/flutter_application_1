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
  // final TextEditingController _fullNameTextController = TextEditingController();
  // final TextEditingController _emailTextController = TextEditingController();
  // final TextEditingController _passwordTextController = TextEditingController();
  // final TextEditingController _accountNumberTextController =
  //     TextEditingController();
  // final TextEditingController _panNumberTextController =
  //     TextEditingController();
  // final TextEditingController _addressTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Hello Username",
                    style: GoogleFonts.merriweather(color:Colors.black,fontWeight:FontWeight.bold,fontSize:20),
                  ),
                  // ₹
                  Text("Your Total Loan Amount is: \u20B9 10,000",style:GoogleFonts.merriweather(color:Colors.black,fontWeight:FontWeight.bold,),)
                ],
              ),
              const Divider(
                endIndent: 50,
                indent: 50,
                color: Colors.blueGrey,
              ),
              Padding(padding: const EdgeInsets.only(left: 20,right: 20),child: Column(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Full Name:",style: GoogleFonts.merriweather(
                    fontSize:16,
                    fontWeight:FontWeight.bold,
                  ),),
                  const Divider(
                    endIndent: 50,
                    color: Colors.blueGrey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   Text("Email:",style: GoogleFonts.merriweather(
                    fontSize:16,
                    fontWeight:FontWeight.bold,
                  ),),
                  const SizedBox(
                    height: 10,
                  ),
                   Text("Password:",style: GoogleFonts.merriweather(
                    fontSize:16,
                    fontWeight:FontWeight.bold,
                  ),),
                  const SizedBox(
                    height: 10,
                  ),
                   Text("Account Number:",style: GoogleFonts.merriweather(
                    fontSize:16,
                    fontWeight:FontWeight.bold,
                  ),),
                  const SizedBox(
                    height: 10,
                  ),
                   Text("Adress:",style: GoogleFonts.merriweather(
                    fontSize:16,
                    fontWeight:FontWeight.bold,
                  ),),
                  const SizedBox(
                    height: 10,
                  ),
                   Text("Pan Number:",style: GoogleFonts.merriweather(
                    fontSize:16,
                    fontWeight:FontWeight.bold,
                  ),),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),)
              
            ],
          ),
        ),
      ),
    );
  }
}

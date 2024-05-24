import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.body,
      appBar: AppBar(
        backgroundColor: MainColors.appbar,
        title: Text("Notifications",style: GoogleFonts.lato(fontSize:20,color:Colors.white),),
      ),
      body: ListView(
        children: [
          SizedBox(height: 50,),
          Center(child: Text("No New Notifications",style: GoogleFonts.lato(fontSize:20),),)
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Personalinformation extends StatefulWidget {
  const Personalinformation({super.key});

  @override
  State<Personalinformation> createState() => PersonalinformationState();
}

class PersonalinformationState extends State<Personalinformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PERSONAL INFORMATION",style: GoogleFonts.lato(fontSize:16),),
      ),
      body: Form(child: ),
    );
  }
}

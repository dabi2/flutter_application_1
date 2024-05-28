import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/color/colors.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.body,
      appBar: AppBar(
        backgroundColor: MainColors.appbar,
        title: Text(
          'Contact Us',
          style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'For any inquiries or assistance, please contact us via:',
              style: GoogleFonts.lato(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.email, color: Colors.white),
              title: Text(
                'Email: abcd@gmail.com',
                style: GoogleFonts.lato(fontSize: 16, color: Colors.white),
              ),
              onTap: () {
                // Open email client
              },
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.white),
              title: Text(
                'Phone: +(91) 12345 25698',
                style: GoogleFonts.lato(fontSize: 16, color: Colors.white),
              ),
              onTap: () {
                // Make a phone call
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.white),
              title: Text(
                'Address: 1234 Shillong Polo Tower, Meghalaya',
                style: GoogleFonts.lato(fontSize: 16, color: Colors.white),
              ),
              onTap: () {
                // Open maps app
              },
            ),
          ],
        ),
      ),
    );
  }
}

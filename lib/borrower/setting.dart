import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Settingscreen extends StatefulWidget {
  const Settingscreen({super.key});

  @override
  State<Settingscreen> createState() => SettingscreenState();
}

class SettingscreenState extends State<Settingscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.body,
      appBar: AppBar(
        backgroundColor: MainColors.appbar,
        title: Center(
          child: Text(
            "Settings",
            style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(Icons.privacy_tip, color: Colors.white),
            title: Text('Privacy Settings', style: GoogleFonts.lato(fontSize: 18, color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.notifications_active, color: Colors.white),
            title: Text('Push Notifications', style: GoogleFonts.lato(fontSize: 18, color: Colors.white)),
            trailing: Switch(value: true, onChanged: (bool value) {}),
          ),
          ListTile(
            leading: Icon(Icons.email, color: Colors.white),
            title: Text('Email Notifications', style: GoogleFonts.lato(fontSize: 18, color: Colors.white)),
            trailing: Switch(value: true, onChanged: (bool value) {}),
          ),
          ListTile(
            leading: Icon(Icons.tune, color: Colors.white),
            title: Text('Notification Preferences', style: GoogleFonts.lato(fontSize: 18, color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.subscriptions, color: Colors.white),
            title: Text('Manage Subscriptions', style: GoogleFonts.lato(fontSize: 18, color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.link, color: Colors.white),
            title: Text('Linked Accounts', style: GoogleFonts.lato(fontSize: 18, color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.policy, color: Colors.white),
            title: Text('Privacy Policy', style: GoogleFonts.lato(fontSize: 18, color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text('Delete Account', style: GoogleFonts.lato(fontSize: 18, color: Colors.red)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.feedback, color: Colors.white),
            title: Text('App Feedback', style: GoogleFonts.lato(fontSize: 18, color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info, color: Colors.white),
            title: Text('App Version', style: GoogleFonts.lato(fontSize: 18, color: Colors.white)),
            subtitle: Text('1.0.0', style: GoogleFonts.lato(fontSize: 16, color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.article, color: Colors.white),
            title: Text('Terms of Service', style: GoogleFonts.lato(fontSize: 18, color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.code, color: Colors.white),
            title: Text('Open Source Licenses', style: GoogleFonts.lato(fontSize: 18, color: Colors.white)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

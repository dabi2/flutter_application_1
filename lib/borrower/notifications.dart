import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/color/colors.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final RemoteMessage? message = args is RemoteMessage ? args : null;

    return Scaffold(
      backgroundColor: MainColors.body,
      appBar: AppBar(
        backgroundColor: MainColors.appbar,
        title: Text(
          "Notifications",
          style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
        ),
      ),
      body: message == null
          ? Center(
              child: Text(
                "No notifications available.",
                style: GoogleFonts.lato(fontSize: 20),
              ),
            )
          : ListView(
              children: [
                const SizedBox(height: 50),
                Center(
                  child: Text(
                    message.notification?.title ?? "No title",
                    style: GoogleFonts.lato(fontSize: 20),
                  ),
                ),
                Center(
                  child: Text(
                    message.notification?.body ?? "No body",
                    style: GoogleFonts.lato(fontSize: 20),
                  ),
                ),
                Center(
                  child: Text(
                    message.data.toString(),
                    style: GoogleFonts.lato(fontSize: 20),
                  ),
                ),
              ],
            ),
    );
  }
}

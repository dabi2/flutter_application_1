import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _displayName = ''; // State variable to store user's display name
  String _email = ''; // State variable to store user's email
  String _phoneNumber = ''; // State variable to store user's phone number
  // String _password = ''; // State variable to store user's password (commented out for security reasons)

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load user data when the widget is initialized
  }

  // Method to load user data
  void _loadUserData() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _displayName = user.displayName ?? ''; // Set display name if available
        _email = user.email ?? ''; // Set email if available
        _phoneNumber = user.phoneNumber ?? ''; // Set phone number if available
        // We don't set the password here for security reasons, you usually wouldn't store the password in a state variable
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String initials = _displayName.isNotEmpty
        ? _displayName.substring(0, 2).toUpperCase()
        : "??"; // Default if no display name

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blue,
              child: Text(
                initials,
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Text('Display Name: $_displayName'),
            SizedBox(height: 10),
            Text('Email: $_email'),
            SizedBox(height: 10),
            Text('Phone Number: $_phoneNumber'),
            // You usually wouldn't display the password for security reasons
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}

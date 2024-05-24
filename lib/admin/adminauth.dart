import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin/AdminDashboard.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              decoration: InputDecoration(hintText: 'Enter your email'),
            ),
            SizedBox(height: 20.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              obscureText: true,
              decoration: InputDecoration(hintText: 'Enter your password'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Authenticate admin user
                if (email == 'admin@example.com' && password == 'admin123') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminDashboard()), // Navigate to admin home screen
                  );
                } else {
                  // Display error message
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Invalid credentials'),
                  ));
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

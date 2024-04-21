import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({super.key});

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void _gender(String gender) async {
    try {
      // Add your logic to add account information to Firestore here
      await _firestore.collection('bank_account_information').add({
        'gender': gender,
        // Add other fields you want to save
      });
      print('Account information added successfully');
    } catch (e) {
      print('Error adding account information: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bank Information"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _gender("male");
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("submitted Successfully")));
                      },
                      child: Icon(
                        Icons.man,
                        size: 50,
                      ),
                    ),
                    Divider(color: Colors.amber,height: 1,),
                    Text("Male")
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                
                child: GestureDetector(
                  onTap: () {
                    _gender("female");
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("submitted Successfully")));
                  },
                  child: Icon(
                    Icons.woman,
                    size: 50,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

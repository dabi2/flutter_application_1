import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({Key? key}) : super(key: key);

  @override
  _AccountInformationState createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  String? loanType;
  double interestRate = 0.0;
  int duration = 1;
  String fromDate = DateTime.now().toString().split(" ")[0];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Information"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: loanType,
                decoration: InputDecoration(
                  labelText: "Loan Type",
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(
                    child: Text("Car Loan"),
                    value: "Car Loan",
                  ),
                  DropdownMenuItem(
                    child: Text("Home Loan"),
                    value: "Home Loan",
                  ),
                  DropdownMenuItem(
                    child: Text("Instant Loan"),
                    value: "Instant Loan",
                  ),
                  DropdownMenuItem(
                    child: Text("Personal Loan"),
                    value: "Personal Loan",
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    loanType = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a loan type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Interest Rate: ${interestRate.toStringAsFixed(2)}%"),
                  Slider(
                    value: interestRate,
                    min: 0.0,
                    max: 20.0,
                    divisions: 200,
                    label: interestRate.toStringAsFixed(2),
                    onChanged: (value) {
                      setState(() {
                        interestRate = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Duration: $duration months"),
                  Slider(
                    value: duration.toDouble(),
                    min: 1.0,
                    max: 60.0,
                    divisions: 59,
                    label: duration.toString(),
                    onChanged: (value) {
                      setState(() {
                        duration = value.toInt();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "From Date",
                  border: OutlineInputBorder(),
                ),
                initialValue: fromDate,
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      fromDate = picked.toString().split(" ")[0];
                    });
                  }
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save data to Firestore
                    saveLoanInformation();
                  }
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveLoanInformation() async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      await FirebaseFirestore.instance.collection('Applicant').add({
        'userId': userId,
        'loanType': loanType,
        'interestRate': interestRate,
        'duration': duration,
        'fromDate': fromDate,
      });

      // Optionally show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Loan information submitted successfully')),
      );
    } catch (e) {
      // Handle errors
      print('Error submitting loan information: $e');
      // Optionally show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Error submitting loan information. Please try again later')),
      );
    }
  }
}

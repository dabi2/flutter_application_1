import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:flutter_application_1/pages/bottomnavigatinbar.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({Key? key, required bool isFormSubmitted}) : super(key: key);

  @override
  _AccountInformationState createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  String? loanType;
  double interestRate = 0.0;
  int duration = 1;
  String fromDate = DateTime.now().toString().split(" ")[0];
   bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.body,
      appBar: AppBar(
        backgroundColor: MainColors.appbar,
        title: Center(child: Text("Loan",style: GoogleFonts.lato(fontSize:20,color:Colors.white),)),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: loanType,
                decoration: const InputDecoration(
                  errorBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid )),
                  errorStyle: TextStyle(color: Colors.redAccent,fontSize: 16),
                  labelText: "Loan Type",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  focusColor: Colors.black,
                ),
                items: const [
                  DropdownMenuItem(
                    value: "Car Loan",
                    child: Text("Car Loan"),
                  ),
                  DropdownMenuItem(
                    value: "Home Loan",
                    child: Text("Home Loan"),
                  ),
                  DropdownMenuItem(
                    value: "Instant Loan",
                    child: Text("Instant Loan"),
                  ),
                  DropdownMenuItem(
                    value: "Personal Loan",
                    child: Text("Personal Loan"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    loanType = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a loan type*';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text("Interest Rate: ${interestRate.toStringAsFixed(2)}%"),
              //     Slider(
              //       value: interestRate,
              //       min: 0.0,
              //       max: 20.0,
              //       divisions: 200,
              //       label: interestRate.toStringAsFixed(2),
              //       onChanged: (value) {
              //         setState(() {
              //           interestRate = value;
              //         });
              //       },
              //     ),
              //   ],
              // ),
              // SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Duration: $duration months",style: GoogleFonts.lato(fontSize:20,color:Colors.white),),
                  Slider(
                    activeColor: MainColors.lightgreen,
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
              const SizedBox(height: 20.0),
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
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
               const SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                        backgroundColor: MainColors.lightgreen,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    // Save data to Firestore
                    saveLoanInformation();
                  }
                },
                child: Text("Submit",style: GoogleFonts.lato(fontSize:20,color:Colors.black),),
              ),
              if (isLoading)
            const Center(
              child: CircularProgressIndicator(backgroundColor: Colors.amber,),
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

    // Check if the user already submitted the form
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('Applicant')
        .where('userId', isEqualTo: userId)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // User has already submitted the form, show dialog box
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Your Application is already in progress"),
            content: const Text("Please be patience we will soon notify you! Thank you for understanding"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog box
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      // User hasn't submitted the form, proceed with submission
      await FirebaseFirestore.instance.collection('Applicant').add({
        'userId': userId,
        'loanType': loanType,
        'interestRate': interestRate,
        'duration': duration,
        'fromDate': fromDate,
      });

      // Show success dialog box
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Application Submitted"),
            content: Text("Your application has been submitted and is being processed."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Mybottomnavigationbar(),
                    ),
                  );
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }

    setState(() {
      isLoading = false;
    });
  } catch (e) {
    // Handle errors
    print('Error submitting loan information: $e');
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error submitting loan information. Please try again later.'),
      ),
    );
    setState(() {
      isLoading = false;
    });
  }
}

}

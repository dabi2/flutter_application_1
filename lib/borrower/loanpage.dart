import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/borrower/lun.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:flutter_application_1/borrower/drawer.dart';
import 'package:flutter_application_1/borrower/payment.dart';
import 'package:flutter_application_1/borrower/test.dart';
import 'package:flutter_application_1/razor_pay/razorpay.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Loanpage extends StatefulWidget {
  const Loanpage({super.key,});

  @override
  State<Loanpage> createState() => LoanpageState();
}

class LoanpageState extends State<Loanpage> {
  List<int> items = List.generate(20, (i) => i);

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      items = List.generate(20, (i) => i + 20);  // Update with new data
    });
  }
  final List _tenureTypes = ["Month(s)", "Year(s)"];
  String _tenureType = "Year(s)";
  String _emiResult = "";
  bool _switchValue = true;
  final TextEditingController _principalAmount = TextEditingController();
  final TextEditingController _interestRate = TextEditingController();
  final TextEditingController _tenure = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return   Container(
        child: const  Center(
          child:  Text("No user is currently logged in."),
        ),
      );
    }

    return Scaffold(
      backgroundColor: MainColors.body,
      appBar: AppBar(
        backgroundColor: MainColors.appbar,
        title: Center(
            child: Text(
          'Loan',
          style: GoogleFonts.audiowide(
            color: Colors.white,
            fontSize: 25,
          ),
        )),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const Notifications()));
            },
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const Languagepage()));
            },
            icon: const Icon(
              Icons.language,
              color: Colors.white,
            ),
          ),
        ],
        elevation: 100,
      ),
      drawer: Drawerclass().buildDrawer(context),
      body: RefreshIndicator(onRefresh: _refresh,color: MainColors.lightgreen,child: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('Applicant_name')
            .where('userId',
                isEqualTo: user.uid) // Fetch data for the current user only
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No loan applications found.'),
            );
          }

          // Display loan application details
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Center(
                    child: Card(
                  color: MainColors.lightgreen,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Current loan Amount is \u20B9${data['Loan Amount']}",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                )),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ElevatedButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context) => DisplayImagesPage(),));}, child: Text("Gooooo")),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: _principalAmount,
                      decoration: InputDecoration(
                          counterStyle: const TextStyle(color: Colors.red),
                          prefixStyle: const TextStyle(color: Colors.red),
                          suffixIcon: const Align(
                            widthFactor: 1.0,
                            heightFactor: 1.0,
                            child: Icon(
                              Icons.currency_rupee_rounded,
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: MainColors.lightgreen)),
                          labelText: "Enter Principal Amount",
                          labelStyle: const TextStyle(color: Colors.white),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: _interestRate,
                      decoration: InputDecoration(
                        suffixIcon: const Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(
                            Icons.percent_rounded,
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: MainColors.lightgreen)),
                        labelText: "Interest Rate",
                        labelStyle: const TextStyle(color: Colors.white),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        fillColor: Colors.amber,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 4,
                          fit: FlexFit.tight,
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            controller: _tenure,
                            decoration: InputDecoration(
                                suffixIcon: const Align(
                                  widthFactor: 1.0,
                                  heightFactor: 1.0,
                                  child: Icon(
                                    Icons.calendar_month_rounded,
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: MainColors.lightgreen)),
                                labelText: "Tenure",
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Flexible(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  _tenureType,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Switch(
                                    activeColor: Colors.green,
                                    value: _switchValue,
                                    onChanged: (bool value) {
                                      print(value);
                                      if ((value)) {
                                        _tenureType = _tenureTypes[1];
                                      } else {
                                        _tenureType = _tenureTypes[0];
                                      }
                                      setState(() {
                                        _switchValue = value;
                                      });
                                    })
                              ],
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    5.0), // Adjust border radius as needed
                              ),
                            ),
                            backgroundColor: MaterialStatePropertyAll(
                                MainColors.lightcontainer)),
                        onPressed: _handleCalculation,
                        child: const Text(
                          "Calculate",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Container(child: emiResultsWidget(_emiResult))),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: MainColors.lightcontainer),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    // const Icon(
                                    //   Icons.house_siding,
                                    //   color: Colors.white,
                                    //   size: 23,
                                    // ),
                                    Text(
                                      '${data['loanType']}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month_sharp,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    Text(
                                      'From Date: ${data['fromDate']}',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(
                              indent: 5,
                              color: Colors.grey,
                              endIndent: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Amount: \u20B9 ${data["Loan Amount"]}',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                ElevatedButton(
                                  onPressed: (){
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => RazorPayScreen(),));
                                  },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green[700],
                                    ),
                                    child: const Text(
                                      'Pay Now',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                // ElevatedButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context) => RazorPayScreen(),));}, child: Text("retrieve"))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),));
  }

// Amortization Formula
  void _handleCalculation() {
    double A = 0.0;
    int P = int.parse(_principalAmount.text);
    double r = int.parse(_interestRate.text) / 12 / 100;
    int n = _tenureType == "Year(s)"
        ? int.parse(_tenure.text) * 12
        : int.parse(_tenure.text);
    A = (P * r * pow((1 + r), n) / (pow((1 + r), n) - 1));
    _emiResult = A.toStringAsFixed(2);
    setState(() {});
  }

  Widget emiResultsWidget(emiResult) {
    bool canShow = false;
    String _emiResult = emiResult;
    if (_emiResult.isNotEmpty) {
      canShow = true;
    }
    const SizedBox(
      height: 20,
    );
    return canShow
        ? Column(
            children: [
              Text("Your Montly EMI Is",
                  style: GoogleFonts.openSans(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
              Text(
                ('\u20B9') + (_emiResult),
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          )
        : const Column();
  }
}

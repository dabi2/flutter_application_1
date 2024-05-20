import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:flutter_application_1/pages/drawer.dart';
import 'package:flutter_application_1/pages/payment.dart';
import 'package:flutter_application_1/pages/test.dart';
import 'package:google_fonts/google_fonts.dart';

class Loanpagetest extends StatefulWidget {
  const Loanpagetest({super.key});

  @override
  State<Loanpagetest> createState() => LoanpagetestState();
}

class LoanpagetestState extends State<Loanpagetest> {
  final List _tenureTypes = ["Month(s)", "Year(s)"];
  String _tenureType = "Year(s)";
  String _emiResult = "";
  bool _switchValue = true;
  final TextEditingController _principalAmount = TextEditingController();
  final TextEditingController _interestRate = TextEditingController();
  final TextEditingController _tenure = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Column(
                children: [
                  Text(
                    "your Total Loan Amount is: \u20B910,000",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "you don't have any active loan Amount",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            ),
            Divider(
              color: MainColors.lightcontainer,
              endIndent: 50,
              indent: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: MainColors.containercolor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
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
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 4,
                          fit: FlexFit.tight,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
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
                    TextButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    const SizedBox(
                      height: 10,
                    ),
                    emiResultsWidget(_emiResult)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: MainColors.lightcontainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.car_rental,
                                color: Colors.white,
                                size: 23,
                              ),
                              Text(
                                'Car Loan',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month_sharp,
                                color: Colors.white,
                                size: 15,
                              ),
                              Text(
                                'Due date 12/02/2024',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
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
                          const Text(
                            'Amount: \u20B9 50,000',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PaymentMode()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[700],
                              ),
                              child: const Text(
                                'Pay Now',
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: MainColors.lightcontainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.house_siding,
                                color: Colors.white,
                                size: 23,
                              ),
                              Text(
                                'Housing Loan',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month_sharp,
                                color: Colors.white,
                                size: 15,
                              ),
                              Text(
                                'Due date 12/02/2024',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
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
                          const Text(
                            'Amount: \u20B9 50,000',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PaymentMode()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[700],
                              ),
                              child: const Text(
                                'Pay Now',
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: MainColors.lightcontainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.school_outlined,
                                color: Colors.white,
                                size: 23,
                              ),
                              Text(
                                'Education Loan',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month_sharp,
                                color: Colors.white,
                                size: 15,
                              ),
                              Text(
                                'Due date 12/02/2024',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
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
                          const Text(
                            'Amount: \u20B9 50,000',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const Paymentmode()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[700],
                              ),
                              child: const Text(
                                'Pay Now',
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) => LoanApplicationDetailsPage(),));
            } , child: Text("TEST"))
          ],
        ),
      ),
    );
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
    if (_emiResult.length > 0) {
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

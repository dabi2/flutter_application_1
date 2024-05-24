import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCalculator extends StatefulWidget {
  const MyCalculator({super.key});

  @override
  State<MyCalculator> createState() => MyCalculatorState();
}

class MyCalculatorState extends State<MyCalculator> {
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
      body: Column(
        children: [
          TextField(
          controller: _principalAmount,
          decoration: const InputDecoration(
              labelText: "Enter Principal Amount",
              labelStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
          keyboardType: TextInputType.number,
        ),
        TextField(
                        controller: _interestRate,
                        decoration: const InputDecoration(
                          labelText: "Interest Rate",
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          fillColor: Colors.amber,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 4,
                            fit: FlexFit.tight,
                            child: TextField(
                              controller: _tenure,
                              decoration: const InputDecoration(
                                  labelText: "Tenure",
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
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
                      TextButton(
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
                      const SizedBox(
                        height: 10,
                      ),
                      emiResultsWidget(_emiResult)
        ],
      ),
    );
  }
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

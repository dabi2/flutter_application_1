import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayScreen extends StatefulWidget {
  const RazorpayScreen({Key? key}) : super(key: key);

  @override
  State<RazorpayScreen> createState() => _RazorpayScreenState();
}

class _RazorpayScreenState extends State<RazorpayScreen> {
  late Razorpay _razorpay;
  final TextEditingController amtController = TextEditingController();

  void openCheck(double amount) async {
    int amountInPaise = (amount * 100).toInt();
    var options = {
      'key': 'rzp_test_grI3dndnrMprjQ',
      'amount': amountInPaise,
      'name': 'Geeks for Geeks',
      'prefill': {'contact': '123456789', 'email': 'test@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint("error: $e");
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Payment successful" + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment failed: " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  TextFormField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      labelText: "Enter Amount",
                      labelStyle: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    controller: amtController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Amount to be paid';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (amtController.text.isNotEmpty) {
                        double amount = double.parse(amtController.text);
                        openCheck(amount);
                      }
                    },
                    child: Text("Make Payment"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

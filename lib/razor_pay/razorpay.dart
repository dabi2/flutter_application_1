import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayScreen extends StatefulWidget {
  const RazorpayScreen({super.key});

  @override
  State<RazorpayScreen> createState() => _RazorpayScreenState();


  // void clear() {}

  // void open(Map<String, Object> options) {}
}

class _RazorpayScreenState extends State<RazorpayScreen> {
  late Razorpay _razorpay;
  final TextEditingController amtController = TextEditingController();
  void opencheck(amount) async {
    amount = amount * 100;
    var options = {
      'key': 'rzp_test_grI3dndnrMprjQ',
      'amount': amount,
      'name': 'Geeks for geeks',
      'prefil': {'contact': '123456789', 'email': ' test@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint("error : e ");
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Payment successfull" + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment fail  " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleexternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "external Wallet " + response.walletName!,
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
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleexternalWallet);
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
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter Amount to be paid';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if(amtController.text.toString().isEmpty){
                        setState(() {
                          int amount = int.parse(amtController.text.toString());
                          opencheck(amount);
                        });
                      }
                      
                    },
                    child: Text("Make Payment")),

                   
              ],
            ),
          )
        ],
      ),
      )
    );
  }
}

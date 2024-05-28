import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class AdminTransferFund extends StatefulWidget {
  const AdminTransferFund({super.key});

  @override
  State<AdminTransferFund> createState() => _AdminTransferFundState();
}

class _AdminTransferFundState extends State<AdminTransferFund> {

  late Razorpay razorpay;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentsuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_grI3dndnrMprjQ",
      "amount": (double.parse(textEditingController.text) * 100)
          .toString(), // Converting to paisa
      "name": "LOAN APP",
      "description": "Payment for loan",
      "prefill": {"contact": "1234567890", "email": "Daia@gmail.com"},
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentsuccess(PaymentSuccessResponse response) {
    print("Payment Success: ${response.paymentId}");
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    print("Payment Error: ${response.code} - ${response.message}");
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    print("External Wallet: ${response.walletName}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainColors.appbar,
        title: Text(
          "RazorPay",
          style: GoogleFonts.inter(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textEditingController,
              decoration: const InputDecoration(hintText: "Transfer Fund"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: openCheckout,
              child: Text(
                "Transfer Now",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
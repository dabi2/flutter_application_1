import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class interestRatePage extends StatefulWidget {
  @override
  State<interestRatePage> createState() => _interestRatePageState();
}

class _interestRatePageState extends State<interestRatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.body,
      appBar: AppBar(
        backgroundColor: MainColors.appbar,
        title: Text(
          'Interest Rate Details',
          style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildInterestRateDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestRateDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInterestRateItem('Fixed vs. Variable Rates',
            'Understand whether the interest rate is fixed throughout the loan term or if it can change based on market conditions.'),
        _buildInterestRateItem('Annual Percentage Rate (APR)',
            'APR includes not only the interest rate but also any additional fees or charges associated with the loan. It provides a more comprehensive view of the cost of borrowing.'),
        _buildInterestRateItem('Compounding Frequency',
            'Know how often interest is compounded. The more frequently interest is compounded, the higher the effective interest rate.'),
        _buildInterestRateItem('Prepayment Penalties',
            'Some loans may have penalties for paying off the loan early. Understand whether prepayment penalties apply and how they are calculated.'),
        _buildInterestRateItem('Credit Score Impact',
            'Applying for a loan may impact your credit score. Understand how loan inquiries and new accounts affect your credit score.'),
        // Add more interest rate details as needed
      ],
    );
  }

  Widget _buildInterestRateItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.lato(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: GoogleFonts.lato(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

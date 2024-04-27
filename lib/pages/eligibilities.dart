import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class borrowerEligibilityPage extends StatefulWidget {
  @override
  State<borrowerEligibilityPage> createState() => _borrowerEligibilityPageState();
}

class _borrowerEligibilityPageState extends State<borrowerEligibilityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainColors.appbar,
        title: Text('Borrower Eligibility Criteria',style: GoogleFonts.lato(fontSize:20,color:Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Eligibility Criteria:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            _buildEligibilityList(),
          ],
        ),
      ),
    );
  }

  Widget _buildEligibilityList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildEligibilityItem('Minimum age of 18 years'),
        _buildEligibilityItem('Stable source of income'),
        _buildEligibilityItem('Good credit history'),
        _buildEligibilityItem('Proof of identification (e.g., Aadhar card)'),
        _buildEligibilityItem('No outstanding loans or defaults'),
        _buildEligibilityItem('Permanent address proof'),
        // Add more eligibility criteria as needed
      ],
    );
  }

  Widget _buildEligibilityItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

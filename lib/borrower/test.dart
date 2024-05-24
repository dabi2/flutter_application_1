import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoanApplicationDetailsPage extends StatefulWidget {
  const LoanApplicationDetailsPage({Key? key}) : super(key: key);

  @override
  State<LoanApplicationDetailsPage> createState() => _LoanApplicationDetailsPageState();
}

class _LoanApplicationDetailsPageState extends State<LoanApplicationDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Application Details'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('Applicant').get(),
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
              var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text('Loan Type: ${data['loanType']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Interest Rate: ${data['interestRate']}'),
                    Text('Duration: ${data['duration']} months'),
                    Text('From Date: ${data['fromDate']}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

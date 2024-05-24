import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoanApplicationDetailsPage extends StatelessWidget {
  const LoanApplicationDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loan Application Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('applicant').get(),
              builder: (context, applicantSnapshot) {
                if (applicantSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (applicantSnapshot.hasError) {
                  return Center(
                    child: Text('Error: ${applicantSnapshot.error}'),
                  );
                }
                // Process data from the "applicant" collection
                List<QueryDocumentSnapshot> applicantDocs = applicantSnapshot.data!.docs;
                return ListView.builder(
                  itemCount: applicantDocs.length,
                  itemBuilder: (context, index) {
                    var data = applicantDocs[index].data() as Map<String, dynamic>;
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
          ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('Applicant_name').get(),
              builder: (context, applicantNameSnapshot) {
                if (applicantNameSnapshot.connectionState == ConnectionState.waiting) {
                  return  const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (applicantNameSnapshot.hasError) {
                  return Center(
                    child: Text('Error: ${applicantNameSnapshot.error}'),
                  );
                }
                // Process data from the "Applicant_name" collection
                List<QueryDocumentSnapshot> applicantNameDocs = applicantNameSnapshot.data!.docs;
                return ListView.builder(
                  itemCount: applicantNameDocs.length,
                  itemBuilder: (context, index) {
                    var data = applicantNameDocs[index].data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text('Applicant Name: ${data['name']}'),
                      subtitle: Text('Phone: ${data['phone']}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

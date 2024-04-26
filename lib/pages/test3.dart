import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DisplayMarital extends StatefulWidget {
  @override
  State<DisplayMarital> createState() => _DisplayMaritalState();
}

class _DisplayMaritalState extends State<DisplayMarital> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marital Status'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('marital_status').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
            if (documents.isEmpty) {
              return Center(child: Text('No data available'));
            }
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data =
                    documents[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text('Name: ${data['name']}'),
                  subtitle: Text('Spouse\'s Name: ${data['spouseName']}'),
                );
              },
            );
          }
          return Container(); // Return an empty container by default
        },
      ),
    );
  }
}

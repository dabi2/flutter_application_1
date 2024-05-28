import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionsHistory extends StatefulWidget {
  const TransactionsHistory({super.key});

  @override
  State<TransactionsHistory> createState() => _TransactionsHistoryState();
}

class _TransactionsHistoryState extends State<TransactionsHistory> {
   final List<Map<String, String>> transactions = [
    {"date": "2024-05-28", "description": "1st Installment", "amount": "\u20B950.00"},
    {"date": "2024-05-27", "description": "2nd Installment", "amount": "\u20B91200.00"},
    {"date": "2024-05-26", "description": "3rd Installment", "amount": "\u20B960.00"},
    {"date": "2024-05-25", "description": "4th Installment", "amount": "\u20B945.00"},
    {"date": "2024-05-24", "description": "5th Installment", "amount": "\u20B95.00"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.body,
      appBar: AppBar(
        backgroundColor: MainColors.appbar,
        title: Text('Transaction History',style: GoogleFonts.lato(color:Colors.white),),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              leading: Icon(Icons.money_rounded),
              title: Text(transactions[index]['description']!),
              subtitle: Text(transactions[index]['date']!),
              trailing: Text(transactions[index]['amount']!,
                  style: const TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold)),
            ),
          );
        },
      ),
    );
  }

}
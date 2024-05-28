import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/color/colors.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  List<Item> _data = generateItems(5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: MainColors.body,
      appBar: AppBar(
        backgroundColor: MainColors.appbar,
        title: Center(
          child: Text(
            "Frequently Asked Questions",
            style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                item.headerValue,
                style: GoogleFonts.lato(fontSize: 18, color: const Color.fromARGB(255, 15, 15, 15)),
              ),
            );
          },
          body: ListTile(
            title: Text(
              item.expandedValue,
              style: GoogleFonts.lato(fontSize: 16, color: const Color.fromARGB(179, 212, 18, 18)),
            ),
            tileColor: MainColors.body,
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Question $index',
      expandedValue: 'This is the answer to question $index.',
    );
  });
}

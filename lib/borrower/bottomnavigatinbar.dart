
import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:flutter_application_1/borrower/loanpage.dart';
import 'homepage.dart';
import 'profilepage.dart';

class Mybottomnavigationbar extends StatefulWidget {
  const Mybottomnavigationbar({super.key});

  @override
  State<Mybottomnavigationbar> createState() => _MybottomnavigationbarState();
}

class _MybottomnavigationbarState extends State<Mybottomnavigationbar> {
  int currentIndex = 0;
  final screens = [
    const MyHomePage(),
    const Loanpage(),
    const Profilepagez(),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(      
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        backgroundColor: MainColors.appbar,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blueGrey,
        showUnselectedLabels: false,
        selectedFontSize: 16,
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_outlined),
            label: 'Loan',
            
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2),
            label: 'Profile',
            ),
        ] ),
    );
  }
}

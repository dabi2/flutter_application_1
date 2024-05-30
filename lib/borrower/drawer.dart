import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/borrower/contactus.dart';
import 'package:flutter_application_1/borrower/editprofile.dart';
import 'package:flutter_application_1/borrower/helpandfaq.dart';
import 'package:flutter_application_1/borrower/setting.dart';
import 'package:flutter_application_1/borrower/transactions.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:flutter_application_1/login/loginpage.dart';

class Drawerclass{
Widget buildDrawer(BuildContext context){
  return Drawer(
    backgroundColor: MainColors.body,
    
    
    child: ListView(
      
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: MainColors.appbar,
          ),
        child: CircleAvatar(
          backgroundColor: MainColors.body,
          child: const Icon(Icons.person,color: Colors.white,size: 50,),
        ),),
        ListTile(
          leading: const Icon(Icons.person_add_alt_1,color: Colors.white,),
          title: const Text('Edit Profile',style: TextStyle(color: Colors.white),),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditPersonalInformation()),
            );   
          },
        ),

        ListTile(          
          leading: const Icon(Icons.history,color: Colors.white,),
          title: const Text('Transactions History',style: TextStyle(color: Colors.white),),
          
          onTap: () {
            Navigator.push(
              context,MaterialPageRoute(builder: (context) => TransactionsHistory(),)
            );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ShowtransactionsHistory())
            // );
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings,color: Colors.white,),
          title: const Text('Notification Setting',style: TextStyle(color: Colors.white),),
          onTap: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Settingscreen(),));
          },
        ),
        ListTile(
          leading: const Icon(Icons.call,color: Colors.white,),
          title: const Text('Contact us',style: TextStyle(color: Colors.white),),
          onTap: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => ContactUsPage(),));
          },
        ),
        ListTile(
          leading: const Icon(Icons.help_outline_outlined,color: Colors.white,),
          title: const Text('Help and FAQ',style: TextStyle(color: Colors.white),),
          onTap: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => FAQPage(),));
          },
        ),
        const Divider(
          indent: 20,
          endIndent: 20,
        ),
        ListTile(
          leading: const Icon(Icons.logout_rounded,color: Colors.white,),
          title: const Text('Logout',style: TextStyle(color: Colors.white),),
          onTap: () {
            _logout(context);
            // FirebaseAuth.instance.signOut().then((value) {
            //  Navigator.push(context,MaterialPageRoute(builder: (context) => SignInScreen())); 
            // });
            // Navigator.push(context,MaterialPageRoute(builder: (context) => Signinscreen()));
          },
        ),
      ],
    ),
  );
}
void _logout(BuildContext context) async{
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LogIn()));
}
}

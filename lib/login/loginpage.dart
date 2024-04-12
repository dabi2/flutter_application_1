// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_application_1/color/colors.dart';
// import 'package:flutter_application_1/pages/bottomnavigatinbar.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Loginpage extends StatefulWidget {
//   const Loginpage({super.key});

//   @override
//   State<Loginpage> createState() => _LoginpageState();
// }

// class _LoginpageState extends State<Loginpage> {
//   String email = "", password = "";
//   TextEditingController emailController = new TextEditingController();
//   TextEditingController passwordController = new TextEditingController();

//   final _formkey = GlobalKey<FormState>();
//   registration()async{
//     if (password != null&& emailController.text!=""&& passwordController.text!=""){
//       try {
//         UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("registered successfully",style: TextStyle(fontSize: 20.0),)));
//         Navigator.push(
//           context,MaterialPageRoute(builder: (context) => Mybottomnavigationbar())
//         );
//       } on FirebaseAuthException catch(e){
//         if(e.code=='weak - Password'){
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.amber,content: Text("Password Provide is too weak",style: TextStyle(fontSize: 18.0),),));

//         }else if(e.code == "email already in use"){
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.amber,content: Text("account Already exist",style: TextStyle(fontSize: 18.0),),));
//         }
//       }
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: MainColors.body,
//       body: Column(
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(20),
//                 bottomRight: Radius.circular(20)),
//             // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
//             child: Image.network(
//               "https://images.unsplash.com/photo-1497864149936-d3163f0c0f4b?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black)
//               ),
//               child: Form(
//                   key: _formkey,
//                   child: Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black)
//                       ),
//                       child: Column(
//                         children: [
//                           TextFormField(
//                             validator: (value){
//                               if(value == null||value.isEmpty) {
//                                 return "Please Enter YOur Email";
//                               }
//                               return null;
//                             },
//                             controller: emailController,
//                             decoration: InputDecoration(
//                               // style: GoogleFonts.lato(fontSize:20,),
//                               // labelText: "Email,",labelStyle: TextStyle(color: Colors.white,fontSize: 16),
//                               border: InputBorder.none,
//                               hintText: "Email",
//                               hintStyle: TextStyle(
//                                 color: Color(0xFFb2b7bf),fontSize: 18.0,
//                               ),
//                             ),
//                           ),
//                           Divider(
//                             endIndent: 50,
//                             indent: 50,
//                             color: Colors.black,
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           TextFormField(
//                             validator: (value){
//                               if(value == null||value.isEmpty) {
//                                 return "Please Enter YOur password";
//                               }
//                               return null;
//                             },
//                             controller: passwordController,
//                             decoration: InputDecoration(
//                               border: InputBorder.none,
//                               hintText: "Password",
//                               hintStyle: TextStyle(
//                                 color: Color(0xFFb2b7bf),fontSize: 18.0,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
// ignore_for_file: use_build_context_synchronously


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth.dart';
import 'package:flutter_application_1/login/forgot_password.dart';
import 'package:flutter_application_1/login/signup.dart';
import 'package:flutter_application_1/pages/homepage.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email = "", password = "";

  TextEditingController mailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "images/car.PNG",
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                          color: const Color(0xFFedf0f8),
                          borderRadius: BorderRadius.circular(30)),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter E-mail';
                          }
                          return null;
                        },
                        controller: mailcontroller,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: TextStyle(
                                color: Color(0xFFb2b7bf), fontSize: 18.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                          color: const Color(0xFFedf0f8),
                          borderRadius: BorderRadius.circular(30)),
                      child: TextFormField(
                        controller: passwordcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(
                                color: Color(0xFFb2b7bf), fontSize: 18.0)),
                   obscureText: true,   ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    GestureDetector(
                      onTap: (){
                        if(_formkey.currentState!.validate()){
                          setState(() {
                            email= mailcontroller.text;
                            password=passwordcontroller.text;
                          });
                        }
                        userLogin();
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                              color: const Color(0xFF273671),
                              borderRadius: BorderRadius.circular(30)),
                          child: const Center(
                              child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w500),
                          ))),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const ForgotPassword()));
              },
              child: const Text("Forgot Password?",
                  style: TextStyle(
                      color: Color(0xFF8c8e98),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500)),
            ),
            const SizedBox(
              height: 40.0,
            ),
            const Text(
              "or LogIn with",
              style: TextStyle(
                  color: Color(0xFF273671),
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    AuthMethods().signInWithGoogle(context);
                  },
                  child: Image.asset(
                    "images/login2.png",
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 30.0,
                ),
                GestureDetector(
                  // onTap: (){
                  //   AuthMethods().signInWithApple();
                  // },
                  child: Image.asset(
                    "images/login2.png",
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?",
                    style: TextStyle(
                        color: Color(0xFF8c8e98),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500)),
                const SizedBox(
                  width: 5.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const SignUp()));
                  },
                  child: const Text(
                    "SignUp",
                    style: TextStyle(
                        color: Color(0xFF273671),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

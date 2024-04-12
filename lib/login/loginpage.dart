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
import 'package:flutter_application_1/pages/bottomnavigatinbar.dart';
import 'package:flutter_application_1/pages/homepage.dart';
import 'package:flutter_application_1/pages/profilepage.dart';

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
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Profilepage()));
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlCn7_4h1dXmXWsztCkI2QizVZpMAkdbOBu1vVDNIN1A&s")),
            ),
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
              height: 20.0,
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
                  child: Image.network("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABwAAAAcCAMAAABF0y+mAAAAvVBMVEVHcEz8/f3////////+/v7s7u/6+vr5+vr5+vr9/f3////////5+vr////////Kzs/////////9/v74+fn4+fn////8vwbsTkJFiPPrQjI7q1gpp00yqVPrSTlAhfX9/f2hv/nwgHj2tLGt2bkqe/Q2gPV+qPd7woza5f2WuPns8v5ZtnHD48n92Yj80Wn+6sD4yMXtZ13znpn8xSnwuh3v6+WIwbFwoPb0qKPpKxT1mx7AtydjuXgcpjNCk8nTYqeQAAAAFXRSTlMA5d2fnApdnVLJpWJiowsJZNGXl5g9ng+vAAABP0lEQVQokY2S2XqCMBCFQVGWulRbkIRABASK0FZtq3Z9/8fqZCDK0oueCzJf/sxhJhlF+Z/G1kJVF9a4T2ZD+6LhrM1u7ZZumsyyO5pe2RQ3+O4Qhoddbd32jHzigwiJms4jTAvJqtb7GekIoSbC0F+tCNnvCSFhZawhRE/I84UfP4eyKMEMEXxA3lunYqN2fXZe/ajbjvA1YX10HIeLjXyNyrcQmwAHsD45zgue3gSozQPEgx50UYmELdtTmqYngNJ2WRVEY1nIOnATsS5lK5+MenUr28ANUtmKIvxij1KGuaUbuFgPxxvSxd4Xo9TzisLz2E+SS1e4eCylgFzK4Aj7PuJLVBevTPBfMSQxBp+qsol8UK167DLLsmNZlaVfR0Hv3muDwVjyJuKd8ZzrF8z1eX90jXtTVc07o0/+1C9hwDM1yvfWEgAAAABJRU5ErkJggg==")
                ),
                const SizedBox(
                  width: 30.0,
                ),
                GestureDetector(
                  // onTap: (){
                  //   AuthMethods().signInWithApple();
                  // },
                  child: Image.network("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAEiklEQVRYha2XW2wUVRzGf7OX2SVt2d1ut11cMrVkt4XAA0oLiURC4UHI8iDpi4oJobXFRjCRRAJKTBDpW8VwEVGIwcjFd0OCSRHKMxEoCbSYmm7YsL1QdrdAZ/Yy40OnWNqZ7QzyPc75zv/79uw5/4tw+/ZdbOI14E0gBpTr354A94G/gKSdYC6LvAjQCrzvdruWeb1ePB4Rh8MBgKqqKEoOWZbJ5wv3gAvAGStmhHlOwA98DXRUV1d5/P6FeDxiyYCKkiOdzjIyMqYAPwJfAemXMbABOBcKBcM1NVUIglBSeDY0TWN4eIzR0Ucp4EOgx4jnMNnfAfwhSZFwOByyLQ4gCALhcAhJioSBy8BOqwY6Kyv9p2Kx150+X4UlMVVVOX/+At3d385Z8/kqiMXqnJWV/h+AzvkMbASOBYMBvF6vJXFZlmltbWPfvv309fUZcrxeD8FgAOCYrmFowA+ck6SI0+v1WBIHOHr0GFeu/AnA9u3bTXlerwdJijiBX3WtOQYOhULBGqvHDlO//vTpMwDs2vUJzc3rS/J9vgpCoWCYqZcF/PcKJOD+ihUN4nwXbnDwH1S1SF1dHU6nkyNHvqOpqZFoNMrDhykqKwPU1taa7tc0jTt3+nPAEiA5nYh2VFdXlRTv7b1Od3c3fX13UFWVhoZ64vE4tbUSZ8/+Qm/vdSYnJxFFkbVr3+LAgS+JxWJz4giCQHV1lTgyMvYRcHD6BO7W1y9ZapZkrl69xo4drRSLxZKnMxOxWIxLl37H45l7nxQlx8DAYD+w1AEsdrtdpuJPnz5l//4vbImXlZXR1XUYUTSO6fGIuN2uBmCxA1hZ6sldu9ZLMmmrvtDR0c6aNatLJjBdc6UDiJXK7zdu3LAlDrB586Z5ObpmvQOomK5qRpiYmLAlLgiCpSSma5abK+sIBAK2DGiaRn//gGW+A5hQVdWUsHz5clsGAI4fP0GhUCjJ0TWfOID7ipIzJTY1NVquC9O4desW7e07SSQSphxdc8AB3JRl2ZS4aNEi1q1725YBgJ6enuc1wgi65k0H8CCfL9wrdQqdnR/bNhAIBNi69V3DNUXJkc8XBoAH05fwYjqdNQ22atUqWlpabBnYu/dzfD6f4Vomk4WpvvF5Nfx5ZGQsr2maacBDhw4SjUYticfjcbZt+8BwTW/VcsBPAM7Ozl0AGaBG01hdXl5muFEURTZu3MDg4CAAzc3r2bPnM9ra2mhsbESWZVwuF1u2xOnqOozLZdxwDw+P8ezZ5EngN3ixKfUD9yQpYqsnsINMZoJEIpkClqF3yjMTURrYlkgki7KsvHJxWVZIJJJFpjrk52367EzYA+x+9Ogxr9KELCuMjz8G2M2s9tzojzo5Pp5Wx8fTJyQpYrkzNkM2O8HQULIIfAqcnL1uVgtOAe8kEslUKjVKqddhBk3TSKVGGRpKpoBNwPdGPCuj2TdAe01NlejzWRvNMpnszKd2gJcczWYiArQD77ndroYFC7yI4ovDaS6XY3JSJp8v9AMXdfH/PZwaYTHwBhAFFurfssDfTI3nD+wE+xfxCKNpO+N8NAAAAABJRU5ErkJggg==")
                )
                // GestureDetector(
                //   // onTap: (){
                //   //   AuthMethods().signInWithApple();
                //   // },
                //   child: Image.asset(
                //     "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAEiklEQVRYha2XW2wUVRzGf7OX2SVt2d1ut11cMrVkt4XAA0oLiURC4UHI8iDpi4oJobXFRjCRRAJKTBDpW8VwEVGIwcjFd0OCSRHKMxEoCbSYmm7YsL1QdrdAZ/Yy40OnWNqZ7QzyPc75zv/79uw5/4tw+/ZdbOI14E0gBpTr354A94G/gKSdYC6LvAjQCrzvdruWeb1ePB4Rh8MBgKqqKEoOWZbJ5wv3gAvAGStmhHlOwA98DXRUV1d5/P6FeDxiyYCKkiOdzjIyMqYAPwJfAemXMbABOBcKBcM1NVUIglBSeDY0TWN4eIzR0Ucp4EOgx4jnMNnfAfwhSZFwOByyLQ4gCALhcAhJioSBy8BOqwY6Kyv9p2Kx150+X4UlMVVVOX/+At3d385Z8/kqiMXqnJWV/h+AzvkMbASOBYMBvF6vJXFZlmltbWPfvv309fUZcrxeD8FgAOCYrmFowA+ck6SI0+v1WBIHOHr0GFeu/AnA9u3bTXlerwdJijiBX3WtOQYOhULBGqvHDlO//vTpMwDs2vUJzc3rS/J9vgpCoWCYqZcF/PcKJOD+ihUN4nwXbnDwH1S1SF1dHU6nkyNHvqOpqZFoNMrDhykqKwPU1taa7tc0jTt3+nPAEiA5nYh2VFdXlRTv7b1Od3c3fX13UFWVhoZ64vE4tbUSZ8/+Qm/vdSYnJxFFkbVr3+LAgS+JxWJz4giCQHV1lTgyMvYRcHD6BO7W1y9ZapZkrl69xo4drRSLxZKnMxOxWIxLl37H45l7nxQlx8DAYD+w1AEsdrtdpuJPnz5l//4vbImXlZXR1XUYUTSO6fGIuN2uBmCxA1hZ6sldu9ZLMmmrvtDR0c6aNatLJjBdc6UDiJXK7zdu3LAlDrB586Z5ObpmvQOomK5qRpiYmLAlLgiCpSSma5abK+sIBAK2DGiaRn//gGW+A5hQVdWUsHz5clsGAI4fP0GhUCjJ0TWfOID7ipIzJTY1NVquC9O4desW7e07SSQSphxdc8AB3JRl2ZS4aNEi1q1725YBgJ6enuc1wgi65k0H8CCfL9wrdQqdnR/bNhAIBNi69V3DNUXJkc8XBoAH05fwYjqdNQ22atUqWlpabBnYu/dzfD6f4Vomk4WpvvF5Nfx5ZGQsr2maacBDhw4SjUYticfjcbZt+8BwTW/VcsBPAM7Ozl0AGaBG01hdXl5muFEURTZu3MDg4CAAzc3r2bPnM9ra2mhsbESWZVwuF1u2xOnqOozLZdxwDw+P8ezZ5EngN3ixKfUD9yQpYqsnsINMZoJEIpkClqF3yjMTURrYlkgki7KsvHJxWVZIJJJFpjrk52367EzYA+x+9Ogxr9KELCuMjz8G2M2s9tzojzo5Pp5Wx8fTJyQpYrkzNkM2O8HQULIIfAqcnL1uVgtOAe8kEslUKjVKqddhBk3TSKVGGRpKpoBNwPdGPCuj2TdAe01NlejzWRvNMpnszKd2gJcczWYiArQD77ndroYFC7yI4ovDaS6XY3JSJp8v9AMXdfH/PZwaYTHwBhAFFurfssDfTI3nD+wE+xfxCKNpO+N8NAAAAABJRU5ErkJggg==",
                //     height: 50,
                //     width: 50,
                //     fit: BoxFit.cover,
                //   ),
                // )
              ],
            ),
            const SizedBox(
              height: 20.0,
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

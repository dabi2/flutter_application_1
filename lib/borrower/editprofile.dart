// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/color/colors.dart';
// import 'package:flutter_application_1/pages/AccountInformation.dart';

// class EditPersonalInformation extends StatefulWidget {
//   const EditPersonalInformation({super.key});

//   @override
//   State<EditPersonalInformation> createState() => _EditPersonalInformationState();
// }

// class _EditPersonalInformationState extends State<EditPersonalInformation> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String? fromDate;
//   String? loanType;
//   final TextEditingController _genderController = TextEditingController();
//   final TextEditingController _accountNumberController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _fatherNameController = TextEditingController();
//   final TextEditingController _dobController = TextEditingController();
//   final TextEditingController _aadharController = TextEditingController();
//   final TextEditingController _loanAmountController = TextEditingController();
//   final TextEditingController _ifscController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   Future<void> _loadUserData() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       try {
//         DocumentSnapshot userData = await FirebaseFirestore.instance
//             .collection('Applicant_name')
//             .doc(user.uid)
//             .get();
//         if (userData.exists) {
//           Map<String, dynamic> data = userData.data() as Map<String, dynamic>;
//           setState(() {
//             fromDate = data['fromDate'];
//             loanType = data['loanType'];
//             _nameController.text = data['name'];
//             _genderController.text = data['Gender'];
//             _addressController.text = data['Address'];
//             _accountNumberController.text = data['AccountNumber'];
//             _fatherNameController.text = data['Father_name'];
//             _dobController.text = data['dob'];
//             _aadharController.text = data['aadhar'];
//             _loanAmountController.text = data['Loan Amount'];
//             _ifscController.text = data['ifsc'];
//           });
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('No data found for this user')),
//           );
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to load data: $e')),
//         );
//       }
//     }
//   }

//   Future<void> _updateUserData() async {
//   User? user = FirebaseAuth.instance.currentUser;
//   if (user != null && _formKey.currentState!.validate()) {
//     try {
//       await FirebaseFirestore.instance.collection('Applicant_name').doc(user.uid).update({
//         'fromDate': fromDate,
//         'loanType': loanType,
//         'name': _nameController.text,
//         'Gender': _genderController.text,
//         'Address': _addressController.text,
//         'AccountNumber': _accountNumberController.text,
//         'Father_name': _fatherNameController.text,
//         'dob': _dobController.text,
//         'aadhar': _aadharController.text,
//         'ifsc': _ifscController.text,
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Information updated successfully')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update information: $e')),
//       );
//     }
//   }
// }
//  void _showEditDialog(String field, TextEditingController controller) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       String? updatedValue = '';
//       return AlertDialog(
//         title: Text('Edit $field'),
//         content: TextField(
//           controller: controller,
//           decoration: InputDecoration(labelText: field),
//           onChanged: (value) {
//             updatedValue = value; // Save the edited value
//           },
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 controller.text = updatedValue ?? controller.text; // Update the text controller with the edited value
//               });
//               Navigator.of(context).pop();
//             },
//             child: const Text('Save'),
//           ),
//         ],
//       );
//     },
//   );
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: MainColors.body,
//       appBar: AppBar(
//         backgroundColor: MainColors.appbar,
//         title: const Text(
//           "EDIT PERSONAL INFORMATION",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               ListTile(
//                 title: const Text("From Date"),
//                 subtitle: Text(fromDate ?? ''),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.edit),
//                   onPressed: () async {
//                     DateTime? picked = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2100),
//                     );
//                     if (picked != null) {
//                       setState(() {
//                         fromDate = picked.toString().split(" ")[0];
//                       });
//                     }
//                   },
//                 ),
//               ),
//               ListTile(
//                 title: const Text("Loan Type"),
//                 subtitle: Text(loanType ?? ''),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.edit),
//                   onPressed: () {
//                     _showEditDialog("Loan Type", _loanAmountController);
//                   },
//                 ),
//               ),
//               ListTile(
//                 title: const Text("Gender"),
//                 subtitle: Text(_genderController.text),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.edit),
//                   onPressed: () {
//                     _showEditDialog("Gender", _genderController);
//                   },
//                 ),
//               ),
//               ListTile(
//                 title: const Text("Name"),
//                 subtitle: Text(_nameController.text),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.edit),
//                   onPressed: () {
//                     _showEditDialog("Name", _nameController);
//                   },
//                 ),
//               ),
//               ListTile(
//                 title: const Text("Address"),
//                 subtitle: Text(_addressController.text),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.edit),
//                   onPressed: () {
//                     _showEditDialog("Address", _addressController);
//                   },
//                 ),
//               ),
//               ListTile(
//                 title: const Text("Father's Name"),
//                 subtitle: Text(_fatherNameController.text),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.edit),
//                   onPressed: () {
//                     _showEditDialog("Father's Name", _fatherNameController);
//                   },
//                 ),
//               ),
//               ListTile(
//                 title: const Text("Account Number"),
//                 subtitle: Text(_accountNumberController.text),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.edit),
//                   onPressed: () {
//                     _showEditDialog("Account Number", _accountNumberController);
//                   },
//                 ),
//               ),
//               ListTile(
//                 title: const Text("Date of Birth"),
//                 subtitle: Text(_dobController.text),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.edit),
//                   onPressed: () {
//                     _showEditDialog("Date of Birth", _dobController);
//                   },
//                 ),
//               ),
//               ListTile(
//                 title: const Text("Aadhar"),
//                 subtitle: Text(_aadharController.text),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.edit),
//                   onPressed: () {
//                     _showEditDialog("Aadhar", _aadharController);
//                   },
//                 ),
//               ),
//               ListTile(
//                 title: const Text("IFSC"),
//                 subtitle: Text(_ifscController.text),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.edit),
//                   onPressed: () {
//                     _showEditDialog("IFSC", _ifscController);
//                   },
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: MainColors.lightgreen,
//                 ),
//                 onPressed: _updateUserData,
//                 child: const Text('Update', style: TextStyle(color: Colors.white)),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/color/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDataPage extends StatefulWidget {
  const UserDataPage({Key? key}) : super(key: key);

  @override
  _UserDataPageState createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userData.exists) {
          Map<String, dynamic> data = userData.data() as Map<String, dynamic>;
          setState(() {
            _nameController.text = data['name'] ?? '';
            _emailController.text = data['email'] ?? '';
            _phoneNumberController.text = data['phone'] ?? '';
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No data found for this user')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load data: $e')),
        );
      }
    }
  }

  Future<void> _updateUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneNumberController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User data updated successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update user data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.body,
      appBar: AppBar(
        backgroundColor: MainColors.appbar,
        title: Center(child: Text('EDIT PROFILE',style: GoogleFonts.audiowide(fontSize:20,color:Colors.white),)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(label: const Text('Name')),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(label: const Text('Email')),
            ),
            TextFormField(
              controller: _phoneNumberController,
              decoration: InputDecoration(label: const Text('Phone Number')),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateUserData,
              child: Text('Update Data',style: GoogleFonts.inter(fontSize:20,color:const Color.fromARGB(255, 0, 0, 0)),),
            ),
          ],
        ),
      ),
    );
  }
}

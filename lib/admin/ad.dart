// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Dynamic Form Example'),
//         ),
//         body: DynamicForm(),
//       ),
//     );
//   }
// }

// class DynamicForm extends StatefulWidget {
//   @override
//   _DynamicFormState createState() => _DynamicFormState();
// }

// class _DynamicFormState extends State<DynamicForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   bool _showNextField = false;

//   void _submitName() {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _showNextField = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextFormField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Name'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter your name';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _submitName,
//               child: Text('OK'),
//             ),
//             SizedBox(height: 16),
//             Visibility(
//               visible: _showNextField,
//               child: TextFormField(
//                 decoration: InputDecoration(labelText: 'Next Field'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     super.dispose();
//   }
// }

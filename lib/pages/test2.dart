import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NameForm extends StatefulWidget {
  @override
  _NameFormState createState() => _NameFormState();
}

class _NameFormState extends State<NameForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _spouseNameController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed to save data to Firebase
      try {
        // Perform form submission asynchronously
        await FirebaseFirestore.instance.collection('marital_status').add({
          'name': _nameController.text,
          'spouseName': _spouseNameController.text,
        });

        // Clear form fields after successful submission
        _nameController.clear();
        _spouseNameController.clear();

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form submitted successfully')),
        );
      } catch (e) {
        // Handle errors
        print('Error submitting form: $e');
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Error submitting form. Please try again later')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Name Form'),
      ),
            // male.name.address.fathername.dob.adharnumber.loanamount.IFSC code.

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Your Name',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _spouseNameController,
                validator: (value) {
                  // You can add more validation logic here
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Spouse\'s Name',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

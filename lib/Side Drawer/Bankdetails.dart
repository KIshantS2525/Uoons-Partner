import 'package:flutter/material.dart';



class AddBankPage extends StatefulWidget {
  @override
  _AddBankPageState createState() => _AddBankPageState();
}

class _AddBankPageState extends State<AddBankPage> {
  final _formKey = GlobalKey<FormState>();
  final _beneficiaryNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _ifscCodeController = TextEditingController();

  @override
  void dispose() {
    _beneficiaryNameController.dispose();
    _accountNumberController.dispose();
    _bankNameController.dispose();
    _ifscCodeController.dispose();
    super.dispose();
  }

  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName cannot be empty';
    }
    return null;
  }

  String? _validateAccountNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Account Number cannot be empty';
    } else if (value.length < 9 || value.length > 18) {
      return 'Account Number must be between 9 and 18 digits';
    }
    return null;
  }

  String? _validateIFSCCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'IFSC Code cannot be empty';
    } else if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(value)) {
      return 'Enter a valid IFSC Code';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Bank',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _beneficiaryNameController,
                decoration: InputDecoration(labelText: 'Beneficiary Name'),
                validator: (value) => _validateNotEmpty(value, 'Beneficiary Name'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _accountNumberController,
                decoration: InputDecoration(labelText: 'Account Number'),
                keyboardType: TextInputType.number,
                validator: _validateAccountNumber,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _bankNameController,
                decoration: InputDecoration(labelText: 'Bank Name'),
                validator: (value) => _validateNotEmpty(value, 'Bank Name'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _ifscCodeController,
                decoration: InputDecoration(labelText: 'IFSC Code'),
                validator: _validateIFSCCode,
              ),
              SizedBox(height: 24.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process the form submission
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0)
                  ),
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
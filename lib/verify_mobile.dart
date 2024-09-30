import 'package:flutter/material.dart';
import 'package:uoons_partner/Home_Page.dart' as home;
import 'package:uoons_partner/kyc_page.dart'; // Assuming you have a KYC page implemented

class VerifyNumberPage extends StatefulWidget {
  final String phoneNumber;
  final String username;
  final bool navigateToHomePage;

  VerifyNumberPage({
    required this.phoneNumber,
    required this.username,
    required this.navigateToHomePage,
  });

  @override
  _VerifyNumberPageState createState() => _VerifyNumberPageState();
}

class _VerifyNumberPageState extends State<VerifyNumberPage> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  bool _allDigitsEntered = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; i++) {
      _controllers[i].addListener(() {
        setState(() {
          _allDigitsEntered = _controllers.every((controller) => controller.text.length == 1);
        });
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }
    if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  void _submitOTP() {
    if (_allDigitsEntered) {
      _handleVerification(context);
    }
  }

  void _handleVerification(BuildContext context) {
    // Assuming OTP is verified successfully
    if (widget.navigateToHomePage) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => home.MyHomePage(username: widget.username),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => KYC(username: widget.username), // Assuming you have a KYC page
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50), // Add some space from the top
              Image.asset(
                'assests/logo Uoons Services.png', // Update the path as per your project structure
                width: 150,
                height: 150,
              ),
              SizedBox(height: 20),
              Text(
                'Enter verification code',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We have sent you a 4 digit verification code on',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '+91 ${widget.phoneNumber}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return Container(
                    width: 50,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24),
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) => _onChanged(value, index),
                    ),
                  );
                }),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _allDigitsEntered ? _submitOTP : null,
                child: Text(_allDigitsEntered ? 'SUBMIT OTP' : 'GET OTP'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Add resend code logic here
                },
                child: Text(
                  'Resend Code',
                  style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

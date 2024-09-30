import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';
import 'package:lottie/lottie.dart';

import 'Accepted Screen.dart';  // Add this line for Lottie animations

class JobDetailsScreen1 extends StatelessWidget {
  final String status;
  final String address;
  final String scheduledTime;
  final String date;
  final bool completed;
  final int amount;

  const JobDetailsScreen1({
    required this.status,
    required this.address,
    required this.scheduledTime,
    required this.date,
    required this.completed,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              status,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: completed ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              address,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Icon(Icons.schedule, color: Colors.grey),
                SizedBox(width: 8.0),
                Text(scheduledTime),
                SizedBox(width: 16.0),
                Icon(Icons.date_range, color: Colors.grey),
                SizedBox(width: 8.0),
                Text(date),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Job Description',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Detailed job description goes here...',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Job Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Amount: ₹$amount',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SliderButton(
          action: () async {
            _showOtpDialog(context);
          },
          label: Text(
            "Slide to Enter OTP",
            style: TextStyle(
              color: Color(0xff4a4a4a),
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
          icon: Center(
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 40.0,
            ),
          ),
          width: MediaQuery.of(context).size.width - 32, // Adjusting width to match screen width
          radius: 10,
          buttonColor: Colors.orangeAccent,
          backgroundColor: Colors.white30,
          highlightedColor: Colors.white60,
          baseColor: Colors.orangeAccent,
        ),
      ),
    );
  }

  void _showOtpDialog(BuildContext context) {
    List<TextEditingController> _otpControllers = List.generate(4, (_) => TextEditingController());
    List<FocusNode> _otpFocusNodes = List.generate(4, (_) => FocusNode());
    bool _allDigitsEntered = false;

    for (int i = 0; i < 4; i++) {
      _otpControllers[i].addListener(() {
        _allDigitsEntered = _otpControllers.every((controller) => controller.text.length == 1);
      });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Enter OTP'),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return Container(
                    width: 50,
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _otpFocusNodes[index],
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
                      onChanged: (value) {
                        if (value.length == 1 && index < 3) {
                          FocusScope.of(context).requestFocus(_otpFocusNodes[index + 1]);
                        }
                        if (value.isEmpty && index > 0) {
                          FocusScope.of(context).requestFocus(_otpFocusNodes[index - 1]);
                        }
                        setState(() {
                          _allDigitsEntered = _otpControllers.every((controller) => controller.text.length == 1);
                        });
                      },
                    ),
                  );
                }),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: _allDigitsEntered
                      ? () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AcceptedScreen(),  // Add the new screen
                      ),
                    );
                  }
                      : null,
                  child: Text('Submit'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}


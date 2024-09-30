import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';

class JobDetailsScreen extends StatelessWidget {
  final String status;
  final String address;
  final String scheduledTime;
  final String date;
  final bool completed;
  final int amount;

  const JobDetailsScreen({
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
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Detailed job description goes here...',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Job Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
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
            // Handle job start action
            Navigator.pop(context); // Go back to the job list screen
          },
          label: Text(
            "Slide to Start Job",
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
}

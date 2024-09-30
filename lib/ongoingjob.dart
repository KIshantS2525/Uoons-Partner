import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';


class OngoingJobListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongoing Jobs'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/ongoingJobs');
            },
            child: JobCard(
              status: 'In Progress',
              address: 'Airwil Green Avenue Greater Noida, E Block, Sector 3, Noida, Uttar Pradesh, India',
              scheduledTime: '03:00 PM',
              date: 'FRI 18 FEB',
              completed: false,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/ongoingJobs');
            },
            child: JobCard(
              status: 'In Progress',
              address: 'Airwil Green Avenue Greater Noida, E Block, Sector 3, Noida, Uttar Pradesh, India',
              scheduledTime: '04:00 PM',
              date: 'FRI 18 FEB',
              completed: false,
            ),
          ),
        ],
      ),
    );
  }
}


class JobCard extends StatelessWidget {
  final String status;
  final String address;
  final String scheduledTime;
  final String date;
  final bool completed;

  const JobCard({
    required this.status,
    required this.address,
    required this.scheduledTime,
    required this.date,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.bolt, color: Colors.blue),
                SizedBox(width: 8.0),
                Text(
                  status,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: completed ? Colors.green : Colors.red,
                  ),
                ),
              ],
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
          ],
        ),
      ),
    );
  }
}

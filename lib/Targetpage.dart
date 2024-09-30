import 'package:flutter/material.dart';

class TargetPage extends StatelessWidget {
  final String username;
  final double rating;
  final double minRating;
  final List<Map<String, dynamic>> targets;

  TargetPage({
    required this.username,
    required this.rating,
    this.minRating = 4.8,
    required this.targets,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopCard(context),
            _buildRatingSection(context),
            _buildTargetsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.orange.shade200,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            backgroundImage: AssetImage('assets/avatar.png'), // Replace with user's avatar
          ),
          SizedBox(width: 16.0),
          Text(
            "Uoons Partner",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rating in last 100 jobs',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 40),
              SizedBox(width: 8.0),
              Text(
                rating.toString(),
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 16.0),
              Text(
                'Minimum Rating required is $minRating',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          LinearProgressIndicator(
            value: rating / 5.0,
            backgroundColor: Colors.orange.shade100,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget _buildTargetsSection(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: targets.length,
      itemBuilder: (context, index) {
        final target = targets[index];
        return ListTile(
          leading: Icon(
            target['completed'] ? Icons.check_circle : Icons.circle,
            color: target['completed'] ? Colors.green : Colors.orange,
          ),
          title: Text(target['title']),
          subtitle: Text(target['description']),
          trailing: Icon(Icons.arrow_forward_ios),
        );
      },
    );
  }
}

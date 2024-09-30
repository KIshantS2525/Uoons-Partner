import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:slider_button/slider_button.dart';

class AcceptedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Accepted'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assests/Animation - 1724931779285.json',  // Use the provided Lottie file
              width: 150,
              height: 150,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 20),
            Text(
              'Service Accepted',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Dear Partner please do your\njob carefully and correctly. All the best from Uoons services.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SliderButton(
          action: () async {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ServiceCompletedScreen()));
          },
          label: Text(
            "Finish the Service",
            style: TextStyle(
              color: Color(0xff4a4a4a),
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
          icon: Center(
            child: Icon(
              Icons.check,
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

class ServiceCompletedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'C:\\Users\\91930\\Desktop\\Ishant Activity\\Flutter Projects\\uoons_partner\\assests\\Animation - 1724933095921.json', // Your new Lottie animation file
              width: 200,
              height: 200,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 20),
            Text(
              'Service Completed',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Dear Partner please share your valuable feedback. This will help us improve our services.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Handle feedback action
          },
          child: Text("Share Feedback"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent,
            padding: EdgeInsets.symmetric(vertical: 15.0),
            textStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
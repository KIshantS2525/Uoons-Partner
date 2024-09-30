import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uoons_partner/Job_details_ongoingpage.dart';
import 'Job_Detail_newpage.dart';
import 'login_page.dart';
import 'newpage.dart';
import 'onboarding_screen.dart';
import 'Home_Page.dart';
import 'ongoingjob.dart';  // Ensure this is the only import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uoons Partner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        '/login': (context) => LoginPage(),
        '/onboarding': (context) => OnboardingScreen(),
        '/home': (context) => MyHomePage(username: ''), // Pass the username accordingly
        '/jobDetails': (context) => JobDetailsScreen(
          status: 'In Progress',
          address: 'Airwil Green Avenue Greater Noida, E Block, Sector 3, Noida, Uttar Pradesh, India',
          scheduledTime: '03:00 PM',
          date: 'FRI 18 FEB',
          completed: false,
          amount: 1200,
        ),
        '/ongoingJobs': (context) => JobDetailsScreen1(
    status: 'In Progress',
    address: 'Airwil Green Avenue Greater Noida, E Block, Sector 3, Noida, Uttar Pradesh, India',
    scheduledTime: '03:00 PM',
    date: 'FRI 18 FEB',
    completed: false,
    amount: 1200,
    ),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkOnboarding();
  }

  Future<void> _checkOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboardingSeen = prefs.getBool('onboardingSeen') ?? false;
    if (onboardingSeen) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      Navigator.pushReplacementNamed(context, '/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

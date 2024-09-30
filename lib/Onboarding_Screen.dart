import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uoons_partner/Login_page.dart';

class OnboardingContents {
  final String title;
  final String image;

  OnboardingContents({
    required this.title,
    required this.image,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "We Provide Professional Home services at a very friendly price",
    image: "C:\\Users\\91930\\Desktop\\Ishant Activity\\Flutter Projects\\uoons_services\\assests\\9905423_4304450.jpeg",
  ),
  OnboardingContents(
    title: "Stay organized with team",
    image: "C:\\Users\\91930\\Desktop\\Ishant Activity\\Flutter Projects\\uoons_services\\assests\\9905424_4305657.jpeg",
  ),
  OnboardingContents(
    title: "Get Electrification services at your home",
    image: "C:\\Users\\91930\\Desktop\\Ishant Activity\\Flutter Projects\\uoons_services\\assests\\9905422_4289870.jpeg",
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;
  List colors = const [
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(255, 255, 255, 255),
  ];

  AnimatedContainer _buildDots({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: Color(0xFF000000),
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  Future<void> _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingSeen', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.8,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _controller,
                  onPageChanged: (value) => setState(() => _currentPage = value),
                  itemCount: contents.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        children: [
                          Image.asset(
                            contents[i].image,
                            height: height * 0.35,
                          ),
                          SizedBox(height: (height >= 840) ? 40 : 20), // Reduced space here
                          Text(
                            contents[i].title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w600,
                              fontSize: (width <= 550) ? 25 : 30, // Reduced by 5 points
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: height * 0.15, // Reduced height here
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        contents.length,
                            (int index) => _buildDots(index: index),
                      ),
                    ),
                    _currentPage + 1 == contents.length
                        ? Padding(
                      padding: const EdgeInsets.all(30),
                      child: ElevatedButton(
                        onPressed: _completeOnboarding,
                        child: const Text(
                          "START",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: (width <= 550)
                              ? const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 20)
                              : EdgeInsets.symmetric(
                              horizontal: width * 0.2, vertical: 25),
                          textStyle: TextStyle(
                              fontSize: (width <= 550) ? 13 : 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black), // Set text color to black
                        ),
                      ),
                    )
                        : Padding(
                      padding: const EdgeInsets.all(30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              _controller.jumpToPage(contents.length - 1);
                            },
                            child: const Text(
                              "SKIP",
                              style: TextStyle(color: Colors.black),
                            ),
                            style: TextButton.styleFrom(
                              elevation: 0,
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: (width <= 550) ? 13 : 17,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _controller.nextPage(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeIn,
                              );
                            },
                            child: const Text(
                              "NEXT",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              elevation: 0,
                              padding: (width <= 550)
                                  ? const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20)
                                  : const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 25),
                              textStyle: TextStyle(
                                  fontSize: (width <= 550) ? 13 : 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black), // Set text color to black
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

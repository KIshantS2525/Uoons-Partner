import 'package:flutter/material.dart';
import 'package:uoons_partner/Side%20Drawer/Bankdetails.dart';
import 'package:uoons_partner/Side%20Drawer/contact_uspage.dart';
import 'package:uoons_partner/ongoingjob.dart';
import 'package:uoons_partner/homecontent.dart';
import 'Targetpage.dart';
import 'Side Drawer/Webview.dart';
import 'newpage.dart';
import 'Side Drawer/profile_page.dart';
import 'money_page.dart';
import 'Side Drawer/calender_page.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyHomePage extends StatefulWidget {
  final String username;

  MyHomePage({required this.username});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final String formattedToday = DateFormat('EEE, MMM d').format(DateTime.now());
  final String formattedNextDay =
  DateFormat('EEE, MMM d').format(DateTime.now().add(Duration(days: 1)));

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      HomeContent(
        formattedToday: formattedToday,
        formattedNextDay: formattedNextDay,
      ),
      JobListScreen(),
      OngoingJobListScreen(),
      TargetPage(
        username: widget.username,
        rating: 4.32,
        targets: [
          {
            'title': '75% Response Rate in last 20 days',
            'description': 'Target description...',
            'completed': false
          },
          {
            'title': '85% Service Delivery Rate in last 20 days',
            'description': 'Target description...',
            'completed': false
          },
          {
            'title': '100% First Time Right in last 20 days',
            'description': 'Target description...',
            'completed': true
          },
        ],
      ),
      MoneyPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showSubscriptionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 400,
            child: PageView(
              children: <Widget>[
                _buildSubscriptionCard(
                    'assets/subscription_basic.png', '\$50/mo', 'BASIC'),
                _buildSubscriptionCard(
                    'assets/subscription_standard.png', '\$70/mo', 'STANDARD'),
                _buildSubscriptionCard(
                    'assets/subscription_premium.png', '\$100/mo', 'PREMIUM'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSubscriptionCard(String imagePath, String price, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(imagePath),
            SizedBox(height: 20),
            Text(
              price,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle subscription purchase
              },
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Uoons Partner"),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.orange,
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.orange),
                  accountName: Text(widget.username),
                  accountEmail: Row(
                    children: List.generate(
                      4,
                          (index) => Icon(Icons.star,
                          color: index < 3 ? Colors.white : Colors.grey),
                    ),
                  ),
                  currentAccountPicture: Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/avatar.png'),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.edit, color: Colors.white, size: 20),
                          onPressed: () {
                            // Add functionality to edit the avatar
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: Text('Profile'),
                leading: Icon(Icons.person),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
              ListTile(
                title: Text('Bank Details'),
                leading: Icon(Icons.account_balance),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddBankPage()),
                  );
                },
              ),
              ListTile(
                title: Text('Refer and Earn'),
                leading: Icon(Icons.card_giftcard),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Your Calendar'),
                leading: Icon(Icons.calendar_today),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalendarPage()),
                  );
                },
              ),
              ListTile(
                title: Text('Job History'),
                leading: Icon(Icons.history),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Buy Subscription'),
                leading: Icon(Icons.shopping_cart),
                onTap: () {
                  _showSubscriptionDialog();
                },
              ),
              ListTile(
                title: Text('Your Helpers'),
                leading: Icon(Icons.group),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Uoons Shop'),
                leading: Icon(Icons.shop),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebViewPage(
                            url:
                            'https://play.google.com/store/apps/details?id=com.uoons.india&hl=en_IN&pli=1')),
                  );
                },
              ),
              ListTile(
                title: Text('Contact Us'),
                leading: Icon(Icons.contact_mail),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContactUsPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'New'),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time), label: 'Ongoing'),
          BottomNavigationBarItem(
              icon: Icon(Icons.task_alt_rounded), label: 'Target'),
          BottomNavigationBarItem(
              icon: Icon(Icons.currency_rupee), label: 'Money'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}




class NewJobsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Jobs'),
      ),
      body: Center(
        child: Text('No new jobs available.'),
      ),
    );
  }
}

class JobsTodayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs Today'),
      ),
      body: Center(
        child: Text('No jobs available today.'),
      ),
    );
  }
}

class UnreadUpdatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unread Updates'),
      ),
      body: Center(
        child: Text('No new updates available.'),
      ),
    );
  }
}

class ReferFriendPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Refer a Friend'),
      ),
      body: Center(
        child: Text('Refer a friend details.'),
      ),
    );
  }
}

class BuyProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Products'),
      ),
      body: Center(
        child: Text('Buy products details.'),
      ),
    );
  }
}

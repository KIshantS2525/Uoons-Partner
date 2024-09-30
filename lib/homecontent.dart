import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Home_Page.dart';
import 'newpage.dart';
import 'ongoingjob.dart';

class HomeContent extends StatelessWidget {
  final String formattedToday;
  final String formattedNextDay;

  HomeContent({
    required this.formattedToday,
    required this.formattedNextDay,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.orange[100],
              child: ListTile(
                title: Text(
                  'Hello, Partner',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Let's help you finish your workday !!",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Today', style: TextStyle(fontSize: 16)),
                    Text(formattedToday,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('• Working', style: TextStyle(color: Colors.green)),
                  ],
                ),
                Column(
                  children: [
                    Text('Next Day', style: TextStyle(fontSize: 16)),
                    Text(formattedNextDay,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('• Not Working', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JobListScreen()),
                );
              },
              child: Card(
                color: Colors.white,
                elevation: 2,
                child: ListTile(
                  title: Text('No new jobs'),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OngoingJobListScreen()),
                );
              },
              child: Card(
                color: Colors.white,
                elevation: 2,
                child: ListTile(
                  title: Text('No jobs today'),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text('Pending Tasks',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Card(
              color: Colors.white,
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.check_box, color: Colors.orange),
                title: Text('Complete suraksha test to accept & deliver jobs'),
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.subscriptions, color: Colors.orange),
                title: Text('20 Subscription jobs. 51 days left.'),
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.shopping_cart, color: Colors.orange),
                title: Text('Buy job pack now.'),
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 2,
              child: ListTile(
                leading: Icon(Icons.school, color: Colors.orange),
                title: Text('Complete all pending trainings.'),
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UnreadUpdatePage()),
                );
              },
              child: Card(
                color: Colors.white,
                elevation: 2,
                child: ListTile(
                  title: Text('1 Unread Update'),
                  subtitle: Text('WHS Referral Program\nReferrals • 5 hours ago'),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text('More from Uoons',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReferFriendPage()),
                );
              },
              child: Card(
                color: Colors.orange[100],
                child: ListTile(
                  title: Text(
                    'Earn upto ₹1000 for every friend of yours that joins UC',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Refer a Friend'),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuyProductsPage()),
                );
              },
              child: Card(
                color: Colors.orange[100],
                child: ListTile(
                  title: Text(
                    'Stock up on your inventory',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Buy products'),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

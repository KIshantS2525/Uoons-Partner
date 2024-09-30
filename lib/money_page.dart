import 'package:flutter/material.dart';

class MoneyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.green[50],
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '₹299',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Total Earning in March\'24'),
              ],
            ),
          ),
          ListTile(
            title: Text('Back Transfers'),
            subtitle: Text('₹699 in March\'24'),
            leading: Icon(Icons.account_balance),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text('02 - 03 Mar'),
            subtitle: Text('Deposit by 05 Mar'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text('04 - 22 Mar'),
            subtitle: Text('Deposit by 23 Mar'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text('Wallet'),
            subtitle: Text('49 Credits'),
            leading: Icon(Icons.wallet_travel),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle wallet tap
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle buy subscription
              },
              child: Text('Buy Subscription'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

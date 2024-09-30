import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: Scaffold(
        appBar: AppBar(
          title: Text('Contact Us', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Don\'t hesitate to contact us whether you have a suggestion on our improvement, a complaint to discuss, or an issue to solve.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ContactOption(
                        icon: Icons.phone,
                        title: 'Call us',
                        description: 'Our team is on the line\nMon-Fri - 9-17',
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ContactOption(
                        icon: Icons.email,
                        title: 'Email us',
                        description: 'Our team is online\nMon-Fri - 9-17',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Text(
                  'FAQ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                FAQOption(
                  question: 'How do I contact customer service?',
                  answer:
                  'You can contact our customer service team by phone or email from Mon-Fri, 9-17.',
                  icon: Icons.phone,
                ),
                FAQOption(
                  question: 'What are your hours of operation?',
                  answer: 'Our team is available Mon-Fri from 9-17.',
                  icon: Icons.access_time,
                ),
                FAQOption(
                  question: 'How can I track my order?',
                  answer:
                  'You can track your order status in your account under "Order History".',
                  icon: Icons.track_changes,
                ),
                FAQOption(
                  question: 'What is your return policy?',
                  answer:
                  'We offer a 30-day return policy. Please visit our returns page for more information.',
                  icon: Icons.policy,
                ),
                SizedBox(height: 24),
                Text(
                  'Submit a Query',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                ChatInterface(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContactOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  ContactOption({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 40, color: color),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class FAQOption extends StatelessWidget {
  final String question;
  final String answer;
  final IconData icon;

  FAQOption({
    required this.question,
    required this.answer,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(icon, size: 24),
      title: Text(
        question,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(answer),
        ),
      ],
    );
  }
}

class ChatInterface extends StatefulWidget {
  @override
  _ChatInterfaceState createState() => _ChatInterfaceState();
}

class _ChatInterfaceState extends State<ChatInterface> {
  List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  void _loadMessages() {
    // Load initial messages if needed.
  }

  @override
  Widget build(BuildContext context) => Container(
    height: 400, // Adjust height as needed
    child: Chat(
      messages: _messages,
      onSendPressed: _handleSendPressed,
      showUserAvatars: true,
      showUserNames: true,
      user: _user,
    ),
  );
}

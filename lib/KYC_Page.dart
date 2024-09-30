import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Home_Page.dart';

class KYC extends StatefulWidget {
  final String username;

  KYC({required this.username});

  @override
  _KYCState createState() => _KYCState();
}

class _KYCState extends State<KYC> {
  void _pickFile(String title) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null) {
      // Handle file selection
      print('File selected for $title: ${result.files.single.name}');
    } else {
      // User canceled the picker
      print('No file selected for $title');
    }
  }

  void _saveAndNavigate() {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
                SizedBox(width: 10),
                Text(
                  "Saving documents...",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // Simulate a delay for saving documents
    Future.delayed(Duration(seconds: 3), () {
      // Close the loading indicator
      Navigator.pop(context);

      // Navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(username: widget.username), // Pass the required username
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KYC Documents'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildListItem(
              'Sole proprietorship',
              "https://www.irs.gov/businesses/small-businesses-self-employed/forms-for-sole-proprietorship",
            ),
            _buildListItem(
              'Limited liability',
              'https://www.mca.gov.in/mca/html/mcav2_en/home/mcaservice/efiling/llpformsdownload/llpformsdownload.html',
            ),
            _buildListItem('Training & Certification', null),
            _buildListItem('ID Proof', null),
            _buildListItem('Skills & Experience Verification Certification', null),
            _buildListItem('Police Verification', null),
            _buildListItem('Photo', null),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveAndNavigate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              child: Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(String title, String? url) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            if (url != null)
              GestureDetector(
                onTap: () {
                  _launchURL(url);
                },
                child: Text(
                  'click here',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _pickFile(title),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                side: BorderSide(color: Colors.orange),
              ),
              child: Text(
                'Upload Document',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
}

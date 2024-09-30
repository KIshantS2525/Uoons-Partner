import 'package:flutter/material.dart';

class ManageAddressPage extends StatefulWidget {
  @override
  _ManageAddressPageState createState() => _ManageAddressPageState();
}

class _ManageAddressPageState extends State<ManageAddressPage> {
  // List to store addresses
  List<Map<String, String>> _addresses = [
    {
      'title': 'Home',
      'address': 'Plot no.209, Kavuri Hills, Madhapur, Telangana 500033',
      'phone': '+91234567890',
    }
  ];

  // Function to show the address dialog
  void _showAddressDialog({Map<String, String>? address, int? index}) {
    final _titleController = TextEditingController(text: address?['title'] ?? '');
    final _addressController = TextEditingController(text: address?['address'] ?? '');
    final _phoneController = TextEditingController(text: address?['phone'] ?? '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(address != null ? 'Edit Address' : 'Add Address'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Address Title'),
              ),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (address != null && index != null) {
                    // Update existing address
                    _addresses[index] = {
                      'title': _titleController.text,
                      'address': _addressController.text,
                      'phone': _phoneController.text,
                    };
                  } else {
                    // Add new address
                    _addresses.add({
                      'title': _titleController.text,
                      'address': _addressController.text,
                      'phone': _phoneController.text,
                    });
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Function to delete an address
  void _deleteAddress(int index) {
    setState(() {
      _addresses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Manage Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              onPressed: () {
                _showAddressDialog(); // Open empty dialog for adding new address
              },
              icon: Icon(Icons.add, color: Colors.orange),
              label: Text(
                'Add another address',
                style: TextStyle(color: Colors.orange),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _addresses.length,
                itemBuilder: (context, index) {
                  final address = _addresses[index];
                  return Card(
                    elevation: 2.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(address['title']!),
                      subtitle: Text(
                        '${address['address']}\nPh: ${address['phone']}',
                      ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (String value) {
                          if (value == 'Edit') {
                            _showAddressDialog(address: address, index: index); // Open dialog for editing address
                          } else if (value == 'Delete') {
                            _deleteAddress(index); // Delete the address
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return {'Edit', 'Delete'}.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

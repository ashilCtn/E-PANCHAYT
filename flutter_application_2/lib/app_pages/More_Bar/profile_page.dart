import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<String> _expectednumbers = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];
  String _selectedNumber = '1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, 'more');
          },
        ),
        title: const Text('Profile'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'profileupdate');
              },
              icon: const Icon(CupertinoIcons.create)),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 170,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(
                          'Username:',
                          'John Doe',
                        ),
                        const SizedBox(height: 8),
                        _buildDetailRow(
                          'Email ID:',
                          'johndoe@example.com',
                        ),
                        const SizedBox(height: 8),
                        _buildDetailRow(
                          'Mobile No:',
                          '+1234567890',
                        ),
                        const SizedBox(height: 8),
                        _buildDetailRow(
                          'Ward No:',
                          'Ward A1',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Divider(), // Add a divider after the card
            ListTile(
              title: const Text(
                'Family Count',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: DropdownButton<String>(
                value: _selectedNumber,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedNumber = newValue!;
                  });
                },
                items: _expectednumbers
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

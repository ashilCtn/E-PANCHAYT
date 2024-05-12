import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/firestore_register.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  /////////////////////////////////////////////////////////////////////////////
  FireStoreRegister fireStoreRegister = FireStoreRegister();
  final user = FirebaseAuth.instance.currentUser!;
  String userName = '';
  String emailid = '';
  String mobileNo = '';
  String wardNo = '';

  void getUserData() async {
    String? currentUserEmail = user.email; // Replace with the actual email
    if (currentUserEmail != null) {
      UserData? userData =
          await fireStoreRegister.getCurrentUserData(currentUserEmail);
      if (userData != null) {
        setState(() {
          userName = userData.userName;
          emailid = userData.emailid;
          mobileNo = userData.mobileNo;
          wardNo = userData.wardNo;
        });
        print(userName);
      }
    } else {
      print('User data not found!');
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  /////////////////////////////////////////////////////////////////////////////
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
                          userName,
                        ),
                        const SizedBox(height: 8),
                        _buildDetailRow(
                          'Email ID:',
                          emailid,
                        ),
                        const SizedBox(height: 8),
                        _buildDetailRow(
                          'Mobile No:',
                          mobileNo,
                        ),
                        const SizedBox(height: 8),
                        _buildDetailRow(
                          'Ward No:',
                          wardNo,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Divider(), // Add a divider after the card
            const Card(
              child: ListTile(
                title: Text(
                  'Family Count',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
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

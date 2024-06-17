import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_application_2/core/theme/app_pallete.dart';

class UserRemoval extends StatefulWidget {
  const UserRemoval({super.key});

  @override
  State<UserRemoval> createState() => _UserRemovalState();
}

class _UserRemovalState extends State<UserRemoval> {
  List<String> userEmails = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserEmails();
  }

  Future<void> fetchUserEmails() async {
    try {
      // Specify the region where your Cloud Function is deployed
      FirebaseFunctions functions =
          FirebaseFunctions.instanceFor(region: 'asia-south1');
      HttpsCallable callable = functions.httpsCallable('listAllUsers');
      final result = await callable();

      // Print the result for debugging purposes
      print('Result from Cloud Function: ${result.data}');

      List<dynamic> emails = result.data;

      setState(() {
        userEmails = emails.map((e) => e.toString()).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching user emails: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Removal'),
        centerTitle: true,
        backgroundColor: AppPallete.barAppNav,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, 'adminlvl');
          },
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userDetailsList(context),
    );
  }

  Widget userDetailsList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: userEmails.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [AppPallete.gradient1, AppPallete.gradient2]),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Email: ${userEmails[index]}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                const Text('Access Role:'),
              ],
            ),
          );
        },
      ),
    );
  }
}

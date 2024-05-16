import 'package:flutter/material.dart';
import 'package:flutter_application_2/core/theme/app_pallete.dart';

class UserRemoval extends StatefulWidget {
  const UserRemoval({super.key});

  @override
  State<UserRemoval> createState() => _UserRemovalState();
}

class _UserRemovalState extends State<UserRemoval> {
  get fireStoreServiceContacts => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Removal',
        ),
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
      body: userDetailsList(context),
    );
  }

  Widget userDetailsList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [AppPallete.gradient1, AppPallete.gradient2]),
          border: const Border(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User Email:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text('Access Role:'),
            ],
          ),
        ),
      ),
    );
  }
}

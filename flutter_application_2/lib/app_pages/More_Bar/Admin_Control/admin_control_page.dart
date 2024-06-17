import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/my_button_new.dart';
import 'package:flutter_application_2/core/theme/app_pallete.dart';

class AdminControls extends StatelessWidget {
  const AdminControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Controls',
        ),
        centerTitle: true,
        backgroundColor: AppPallete.barAppNav,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, 'more');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const SizedBox(height: 10),
              MyNewButton(
                  onTap: () {
                    Navigator.pushNamed(context, 'superuser');
                  },
                  text: "Superuser Creation"),
              const SizedBox(height: 10),
              // MyNewButton(
              //     onTap: () {
              //       Navigator.pushNamed(context, 'removeuser');
              //     },
              //     text: "User Removal"),
              // const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

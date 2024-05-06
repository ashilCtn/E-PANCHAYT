import 'package:flutter/material.dart';

class ServicePage extends StatelessWidget {
  ServicePage({super.key});
  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: search,
            )
          ],
        ),
      )),
    );
  }
}

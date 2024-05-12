import 'package:flutter/material.dart';

class TopSnackBar extends StatelessWidget {
  final String message;

  const TopSnackBar({
    super.key, // Make key nullable since passing a key is optional
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(top: 50), // Adjust top margin as needed
      padding: EdgeInsets.zero,
    );
  }
}

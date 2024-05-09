import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const ProfileAvatar({
    super.key,
    required this.imageUrl,
    this.radius = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(imageUrl),
      backgroundColor: Colors.grey[300], // Placeholder color
      // You can also use AssetImage for local images:
      // backgroundImage: AssetImage('assets/images/profile.png'),
    );
  }
}

// Example usage:
// ProfileAvatar(imageUrl: 'https://example.com/profile.jpg'),

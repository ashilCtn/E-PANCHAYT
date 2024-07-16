import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedProfileAvatar extends StatelessWidget {
  final String imageUrl;

  const CachedProfileAvatar({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: CircleAvatar(
        radius: 30.0,
        backgroundColor: Colors.grey[200],
        backgroundImage: CachedNetworkImageProvider(imageUrl),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppRoundedImage extends StatelessWidget {
  const AppRoundedImage({super.key, required this.url, this.radius = 30});

  final String url;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,
      backgroundImage: CachedNetworkImageProvider(
        url,
        errorListener: () => print('Error loading image'),
      ),
    );
  }
}

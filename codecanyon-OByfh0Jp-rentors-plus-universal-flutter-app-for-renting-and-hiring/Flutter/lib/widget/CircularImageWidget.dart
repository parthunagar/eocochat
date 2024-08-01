import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class CircularImageWidget extends StatelessWidget {
  final double size;
  final String imageUrl;

  CircularImageWidget(this.size, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      elevation: 2,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.amber),
            image: DecorationImage(
                image: imageUrl=='NA'?AssetImage('assets/img/avatar.png',):OptimizedCacheImageProvider(imageUrl),
                fit: BoxFit.cover)),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    );
  }
}

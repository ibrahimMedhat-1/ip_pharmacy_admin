import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  final String image;

  const CarouselItem({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 3,
            color: Colors.grey,
          )
        ],
      ),
      child: CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: image,
        errorWidget: (context, url, error) => const Icon(
          Icons.error,
          color: Colors.red,
        ),
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

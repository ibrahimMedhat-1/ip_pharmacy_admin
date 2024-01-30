import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TopImageWidget extends StatelessWidget {
  const TopImageWidget({
    super.key,
    required this.tag,
    required this.image,
  });

  final String tag;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: tag,
          child: Container(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.3,
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: image,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.sizeOf(context).width * 0.05,
            left: MediaQuery.sizeOf(context).width * 0.05,
          ),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade600,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  size: 35,
                  color: Colors.white,
                )),
          ),
        ),
      ],
    );
  }
}

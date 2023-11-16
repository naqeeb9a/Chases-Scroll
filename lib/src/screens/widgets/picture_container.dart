import 'package:cached_network_image/cached_network_image.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:flutter/material.dart';

class PictureContainer extends StatelessWidget {
  final String image;
  const PictureContainer({Key? key, required this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
        topLeft: Radius.circular(20),
        topRight: Radius.circular(0),
      ),
      child: SizedBox(
        width: width,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl:
              "${Endpoints.baseUrl}resource-api/download/${image.toString()}",
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}

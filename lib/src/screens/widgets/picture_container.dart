import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:chases_scroll/src/utils/constants/colors.dart';
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
      child: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl:
                  "${Endpoints.baseUrl}resource-api/download/${image.toString()}",
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Center(
              child: InteractiveViewer(
            boundaryMargin: const EdgeInsets.all(20.0),
            minScale: 0.1,
            maxScale: 5.0,
            child: CachedNetworkImage(
              fit: BoxFit.contain,
              imageUrl:
                  "http://ec2-3-128-192-61.us-east-2.compute.amazonaws.com:8080/resource-api/download/${image.toString()}",
              placeholder: (context, url) => const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          )),
        ],
      ),
    );
  }
}

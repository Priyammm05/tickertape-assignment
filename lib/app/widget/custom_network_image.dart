import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:tickertape_assignment/app/constants/constants.dart';
import 'package:tickertape_assignment/app/services/network_service.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final NetworkService networkService = Get.find<NetworkService>();

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      child: networkService.isConnected.isTrue
          ? CachedNetworkImage(
              imageUrl: imageUrl ?? Constants.defaultImage,
              width: width,
              height: height,
              fit: fit,
              placeholder: (context, url) => Container(
                width: width,
                height: height,
                color: Colors.grey[200],
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  image: const DecorationImage(
                    image: NetworkImage(Constants.defaultImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          : Image.asset(
              Constants.noInterntImage,
              width: width,
              height: height,
              fit: fit,
            ),
    );
  }
}

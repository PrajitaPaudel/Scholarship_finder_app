
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TRoundedImages extends StatelessWidget {
  final double? width, height;
  final String imageUrl;
  final String? defaultAssetImage;
  final bool applyImageRadius;
  final BoxBorder? border;
  final double borderRadius;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final bool isNetworkingImage;

  const TRoundedImages({
    Key? key,
    this.height,
    this.width,
    required this.imageUrl,
    this.defaultAssetImage,
    this.backgroundColor = Colors.white,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkingImage = false,
    this.borderRadius = 20.0,
    this.applyImageRadius = true,
    this.border,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: border,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: isNetworkingImage
              ? Image.network(
            imageUrl,
            fit: fit,
            errorBuilder: (context, error, stackTrace) {
              // Load default asset image if network image fails
              return defaultAssetImage != null
                  ? Image.asset(
                defaultAssetImage!,
                fit: fit,
              )
                  : const Center(child: Text('Could not load image'));
            },
          )
              : Image.asset(
            imageUrl,
            fit: fit,
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Text('Could not load image'));
            },
          ),
        ),
      ),
    );
  }
}

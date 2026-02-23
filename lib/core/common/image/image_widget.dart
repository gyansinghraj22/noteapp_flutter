import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noteapp/constants/app_icons.dart';

class ImageWidget {
  static showBackgroundImage({
    required String imagePath,
    double? height,
    double? width,
    bool? isAssetImg,
  }) {
    if (isAssetImg == true) {
      return AssetImage(imagePath);
    }
    return NetworkImage(imagePath);
  }

  static Widget showLocalImage(
    String imagePath, {
    double? height,
    double? width,
    Color? color,
  }) {
    return Image.asset(
      imagePath,
      color: color,
      width: width ?? 150,
      height: height ?? 50,
      errorBuilder: (context, error, stackTrace) => AppIcons.errorIcon,
    );
  }

  static Widget showSvgImage(
    String imagePath, {
    double? height,
    double? width,
    Color? color,
  }) {
    return SvgPicture.asset(
      imagePath,
      color: color,
      width: width ?? 150,
      height: height ?? 50,
      fit: BoxFit.fill,
    );
  }

  static Widget showNetworkImage(
    String imageUrl, {
    double? height,
    double? width,
  }) {
    return Image.network(
      imageUrl,
      width: width ?? 150,
      height: height ?? 50,
      errorBuilder: (context, error, stackTrace) => AppIcons.errorIcon,
    );
  }
}

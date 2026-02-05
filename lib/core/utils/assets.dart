import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppAssets {
  AppAssets._();

  static const String _icons = 'assets/images/icons';
  static const String _pictures = 'assets/images/pictures';

  // SVGs
  static const String checkboxRounded = '$_icons/checkbox_rounded.svg';
  static const String planet = '$_icons/planet.svg';
  static const String smartphone = '$_icons/smartphone.svg';
  static const String animation = '$_icons/animation.svg';
  static const String paint = '$_icons/paint.svg';
  static const String bag = '$_icons/bag.svg';
  static const String brand = '$_icons/brand.svg';
  static const String rateStar = '$_icons/rate_star.svg';

  // WebP and JPG (Note: Added 'assets/' prefix to match your pubspec)
  static const String teamImage = '$_pictures/team_image.webp';
  static const String ilustration = '$_pictures/ilustration.jpg';
}

/// Extension for SVG files
extension SvgAssetExtension on String {
  SvgPicture svg({
    Key? key,
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
  }) {
    return SvgPicture.asset(
      this,
      key: key,
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(color ?? Colors.teal, BlendMode.srcIn),
      fit: fit,
      alignment: alignment,
    );
  }
}

/// Extension for Raster files (WebP, JPG, PNG)
// Keep your AppAssets class as it is...

/// Single Smart Extension to handle both SVG and Raster images
extension AssetRenderer on String {
  Widget render({
    Key? key,
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
  }) {
    // If the path ends in .svg, use SvgPicture
    if (toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        this,
        key: key,
        width: width,
        height: height,
        colorFilter: color != null
            ? ColorFilter.mode(color, BlendMode.srcIn)
            : ColorFilter.mode(Colors.teal, BlendMode.srcIn),
        fit: fit,
        alignment: alignment,
      );
    } else {
      return Image.asset(
        this,
        key: key,
        width: width,
        height: height,
        color: color,
        fit: fit,
        alignment: alignment,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image),
      );
    }
  }
}

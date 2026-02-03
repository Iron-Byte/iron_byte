import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppAssets {
  AppAssets._();

  // Base path (no 'assets/' prefix)
  static const String _icons = 'images/icons';

  // Icon
  static const String checkboxRounded = '$_icons/checkbox_rounded.svg';
  static const String planet = '$_icons/planet.svg';
  static const String smartphone = '$_icons/smartphone.svg';
  static const String animation = '$_icons/animation.svg';
  static const String paint = '$_icons/paint.svg';
  static const String bag = '$_icons/bag.svg';
    static const String brand = '$_icons/brand.svg';

}

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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppAssets {
  AppAssets._();

  // Base path (no 'assets/' prefix)
  static const String _icons = 'images/icons';

  // Icon
  static const String checkboxRounded = '$_icons/checkbox_rounded.svg';
    static const String planet = '$_icons/planet.svg';

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

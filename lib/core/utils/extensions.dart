import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colors => theme.colorScheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;
  double get height => size.height;
  double get width => size.width;

  TextStyle? get displayLarge => textTheme.displayLarge;
  TextStyle? get displayMedium => textTheme.displayMedium;
  TextStyle? get displaySmall => textTheme.displaySmall;

  TextStyle? get h1 => textTheme.headlineLarge;
  TextStyle? get h2 => textTheme.headlineMedium;
  TextStyle? get h3 => textTheme.headlineSmall;

  TextStyle? get titleL => textTheme.titleLarge;
  TextStyle? get titleM => textTheme.titleMedium;
  TextStyle? get titleS => textTheme.titleSmall;

  TextStyle? get bodyL => textTheme.bodyLarge;
  TextStyle? get bodyM => textTheme.bodyMedium;
  TextStyle? get bodyS => textTheme.bodySmall;

  TextStyle? get labelL => textTheme.labelLarge;
  TextStyle? get labelM => textTheme.labelMedium;
  TextStyle? get labelS => textTheme.labelSmall;
}

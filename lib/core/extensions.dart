import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  /// Full theme
  ThemeData get theme => Theme.of(this);

  /// Text theme shortcut
  TextTheme get textTheme => theme.textTheme;

  /// Color scheme shortcut
  ColorScheme get colors => theme.colorScheme;

  /// MediaQuery shortcut
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Screen size shortcuts
  Size get size => mediaQuery.size;
  double get height => size.height;
  double get width => size.width;

  /// Shortcuts for common styles
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

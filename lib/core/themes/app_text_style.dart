import 'package:flutter/material.dart';
import 'package:iron_byte/core/themes/app_colors.dart';

class AppTextStyles {
  static TextStyle hero = TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: AppColors.textPrimary,
  );
  static TextStyle heroAccent = TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: AppColors.primary,
  );

  static TextStyle body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.75,
    color: AppColors.textSecondary,
  );
  static TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.textSecondary,
  );

  static TextStyle labelLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
  static TextStyle label = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
  static TextStyle labelSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
  static TextStyle caption = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle overline = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.1,
    color: AppColors.primary,
  );

  static TextStyle statNumber = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
  static TextStyle statLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  static TextStyle pill = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );
  static TextStyle tag = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
  );

  static TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
}

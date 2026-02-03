import 'package:flutter/material.dart';
import 'package:iron_byte/core/theme/app_theme.dart';

class InfoContainer extends StatelessWidget {
  final Widget? cardItem;
  final String? cardTitle;
  final String? cardDescription;
  final VoidCallback? onTap;

  const InfoContainer({
    super.key,
    this.cardItem,
    this.cardTitle,
    this.cardDescription,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: AppColors.secondary.withValues(alpha: 0.30),
        ),
        child: Column(
          children: [
            ?cardItem,
          ],
        ),
      ),
    );
  }
}

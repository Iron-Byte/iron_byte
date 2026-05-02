import 'package:flutter/material.dart';
import 'package:iron_byte/core/themes/themes.dart';

class TransparentButton extends StatelessWidget {
  final Widget child;
  final Color? buttonColor;
  final int transparency;
  const TransparentButton({
    super.key,
    required this.child,
    this.buttonColor,
    this.transparency = 35,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.sm8),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            buttonColor ?? AppColors.primary.withAlpha(transparency),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.md12),
              side: BorderSide(
                color: buttonColor ?? AppColors.primary,
                width: 1,
              ),
            ),
          ),
        ),
        onPressed: () {},
        child: child,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/themes/themes.dart';

class ConsultationItemScreen extends StatelessWidget {
  const ConsultationItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      height: 480,
      padding: AppSpacing.allLg16,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.borderMd12,
        border: Border.all(width: 1, color: AppColors.borderSurface),
      ),
      child: Column(
        children: [
          Text(
            'get_consultation'.tr(),
            style: AppTextStyles.hero.copyWith(
              fontSize: 24,
              fontFamily: "Cinzel",
            ),
          ),
          Gap(AppSpacing.xxl24),
          TextField(
            decoration: InputDecoration(hintText: 'Your Email'),
            keyboardType: TextInputType.emailAddress,
            autofocus: true,
          ),
          Gap(AppSpacing.xxxl32),
          TextField(
            minLines: 4,
            maxLines: 6,
            decoration: InputDecoration(
              hintText: 'Tell us what you’re looking for?',
            ),
            keyboardType: TextInputType.text,
            autofocus: true,
          ),
          Gap(AppSpacing.xxxl32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(200, 56),
            ),
            onPressed: () {},
            child: Text('send_message'.tr()),
          ),
          Gap(AppSpacing.lg16),

          Row(
            children: [
              Expanded(
                child: Divider(thickness: 1, color: AppColors.borderSurface),
              ),
              Gap(AppSpacing.lg16),

              Text('or'.tr()),
              Gap(AppSpacing.lg16),

              Expanded(
                child: Divider(thickness: 1, color: AppColors.borderSurface),
              ),
            ],
          ),
          Gap(AppSpacing.lg16),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(double.infinity, 56),
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_month),
                Gap(AppSpacing.xxl24),
                Text('book_meeting'.tr()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/about/presentation/models/about_ui_models.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutTeamMemberCard extends StatelessWidget {
  const AboutTeamMemberCard({
    super.key,
    required this.member,
  });

  final AboutTeamMemberData member;

  Future<void> _openLink(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.borderMd12,
        border: Border.all(color: AppColors.borderSurface),
      ),
      child: Padding(
        padding: AppSpacing.allLg16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: member.avatarColor,
              child: Text(
                member.initials,
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg16),
            Text(
              member.nameKey.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.label.copyWith(
                fontWeight: FontWeight.w700,
                fontFamily: 'Cinzel',
              ),
            ),
            const SizedBox(height: AppSpacing.sm8),
            Text(
              member.roleKey.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.caption,
            ),
            const SizedBox(height: AppSpacing.lg16),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: AppSpacing.md12,
              runSpacing: AppSpacing.sm8,
              children: [
                for (final link in member.links)
                  TextButton(
                    onPressed: () => _openLink(link.uri),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      link.labelKey.tr(),
                      style: AppTextStyles.pill.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

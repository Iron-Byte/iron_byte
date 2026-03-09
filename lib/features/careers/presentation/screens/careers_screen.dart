import 'package:flutter/material.dart';
import 'package:iron_byte/core/theme/app_theme.dart';
import 'package:iron_byte/core/utils/extensions.dart';
import 'package:iron_byte/core/utils/sizes.dart';
import 'package:iron_byte/features/careers/presentation/widgets/application_filling_form.dart';
import 'package:iron_byte/features/careers/presentation/widgets/current_vacancies.dart';

class CareersScreen extends StatelessWidget {
  const CareersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: context.width / 2,
          decoration: BoxDecoration(
            color: AppColors.tealLight.withValues(alpha: 0.20),
            borderRadius: BorderRadius.circular(AppSpacing.padding4),
          ),
          height: context.height,

          child: ApplicationFillingForm(),
        ),
        SizedBox(
          width: context.width / 2,
          height: context.height,
          child: CurrentVacancies(),
        ),
      ],
    );
  }
}

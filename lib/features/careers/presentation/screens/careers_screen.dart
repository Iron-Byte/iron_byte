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
    return Column(
      children: [
Text('${context.width}'),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final shortestSide = MediaQuery.sizeOf(context).width;
              final isMobile = shortestSide < 1024;
          
              final horizontalPadding = isMobile ? 16.0 : 48.0;
              final verticalPadding = isMobile ? 16.0 : 32.0;
          
              final formCard = Container(
                decoration: BoxDecoration(
                  color: AppColors.tealLight.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(AppSpacing.padding4),
                ),
                padding: isMobile ? const EdgeInsets.all(16) : const EdgeInsets.all(24),
                child: const ApplicationFillingForm(),
              );
          
              final vacancies = const CurrentVacancies();
          
              final content = isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        formCard,
                        SizedBox(height: AppSpacing.padding42),
                        vacancies,
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 1, child: formCard),
                        const SizedBox(width: 32),
                        Expanded(flex: 1, child: vacancies),
                      ],
                    );
          
              return SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
                  ),
                  child: content,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

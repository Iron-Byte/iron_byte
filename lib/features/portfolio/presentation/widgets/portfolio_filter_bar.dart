import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/portfolio/presentation/bloc/portfolio_bloc.dart';
import 'package:iron_byte/features/portfolio/presentation/bloc/portfolio_event.dart';
import 'package:iron_byte/features/portfolio/presentation/bloc/portfolio_state.dart';
import 'package:iron_byte/features/portfolio/presentation/models/portfolio_ui_models.dart';

class PortfolioFilterBar extends StatelessWidget {
  const PortfolioFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioBloc, PortfolioState>(
      builder: (context, state) {
        final selected = state.maybeWhen(
          loaded: (f) => f,
          orElse: () => PortfolioFilter.all,
        );

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final f in PortfolioFilter.values) ...[
                if (f != PortfolioFilter.values.first)
                  const SizedBox(width: AppSpacing.md12),
                _FilterChip(
                  labelKey: f.labelKey,
                  selected: selected == f,
                  onTap: () => context
                      .read<PortfolioBloc>()
                      .add(PortfolioFilterSelected(f)),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.labelKey,
    required this.selected,
    required this.onTap,
  });

  final String labelKey;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.borderPill36,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg16,
            vertical: AppSpacing.sm8,
          ),
          decoration: BoxDecoration(
            borderRadius: AppRadius.borderPill36,
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.borderSurface,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Text(
            labelKey.tr(),
            style: AppTextStyles.pill.copyWith(
              color: selected ? AppColors.textPrimary : AppColors.textSecondary,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

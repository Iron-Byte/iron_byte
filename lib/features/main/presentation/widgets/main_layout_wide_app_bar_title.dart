import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iron_byte/core/navigation/home_scroll_coordinator.dart';
import 'package:iron_byte/core/router/app_routes.dart';
import 'package:iron_byte/core/router/main_shell_nav_items.dart';
import 'package:iron_byte/core/router/shell_nav_location.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/main/presentation/widgets/app_bar_nav_item.dart';

class MainLayoutWideAppBarTitle extends StatelessWidget {
  const MainLayoutWideAppBarTitle({super.key, required this.coordinator});

  final HomeScrollCoordinator? coordinator;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth;
        final horizontalInset = AppSpacing.xxxl32 * 2;
        final minRowWidth = maxW.isFinite
            ? (maxW - horizontalInset).clamp(0.0, double.infinity)
            : 0.0;

        Widget navRow(String actualLoc, String highlight) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: AppSpacing.xxxl32,
                    width: AppSpacing.xxxl32,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: AppRadius.borderXs6,
                    ),
                    child: Center(
                      child: Text('IB', style: AppTextStyles.labelLarge),
                    ),
                  ),
                  AppBarNavItem(
                    label: 'iron_byte'.tr(),
                    route: AppRoutes.home,
                    currentLocation: actualLoc,
                    dense: true,
                    onPressed: coordinator == null
                        ? null
                        : () => coordinator!.onShellNavTap(
                            context,
                            AppRoutes.home,
                          ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final item in kMainShellNavItems)
                    AppBarNavItem(
                      label: item.labelKey.tr(),
                      route: item.route,
                      currentLocation: highlight,
                      onPressed: coordinator == null
                          ? null
                          : () =>
                                coordinator!.onShellNavTap(context, item.route),
                    ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  context.push(AppRoutes.consultation);
                },
                child: Text('free_consulatation'.tr()),
              ),
            ],
          );
        }

        if (coordinator == null) {
          final loc = shellNavigationLocation(context);
          final row = navRow(loc, loc);
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: AppSpacing.allXxxl32,
              child: maxW.isFinite && minRowWidth > 0
                  ? ConstrainedBox(
                      constraints: BoxConstraints(minWidth: minRowWidth),
                      child: row,
                    )
                  : row,
            ),
          );
        }

        return ListenableBuilder(
          listenable: coordinator!,
          builder: (context, _) {
            final actualLoc = shellNavigationLocation(context);
            final highlight = shellNavHighlightLocation(context, coordinator!);
            final row = navRow(actualLoc, highlight);
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: AppSpacing.allXxxl32,
                child: maxW.isFinite && minRowWidth > 0
                    ? ConstrainedBox(
                        constraints: BoxConstraints(minWidth: minRowWidth),
                        child: row,
                      )
                    : row,
              ),
            );
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iron_byte/core/router/app_routes.dart';
import 'package:iron_byte/core/router/main_shell_nav_items.dart';
import 'package:iron_byte/core/router/shell_nav_location.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/main/presentation/widgets/app_bar_nav_item.dart';

// Web text-copy regression checklist:
// [ ] User can click-drag to highlight text in browser
// [ ] Ctrl+C / Cmd+C copies selected text
// [ ] Right-click shows browser native Copy option
// [ ] Programmatic copy buttons use Clipboard.setData()
// [ ] No regressions on navigation or tap interactions
class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final currentLocation = shellNavigationLocation(context);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Container(height: 1.5, color: AppColors.borderSurface),
        ),
        title: LayoutBuilder(
          builder: (context, constraints) {
            final maxW = constraints.maxWidth;
            // Padding must live *inside* the scroll extent so minWidth matches the
            // viewport; otherwise the row is wider than the visible area and clips
            // trailing actions (e.g. the consultation button).
            final horizontalInset = AppSpacing.xxxl32 * 2;
            final minRowWidth = maxW.isFinite
                ? (maxW - horizontalInset).clamp(0.0, double.infinity)
                : 0.0;
            final row = Row(
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
                      currentLocation: currentLocation,
                      dense: true,
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
                        currentLocation: currentLocation,
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
        ),
      ),
      body: Padding(padding: AppSpacing.allXxxl32, child: child),
    );
  }
}

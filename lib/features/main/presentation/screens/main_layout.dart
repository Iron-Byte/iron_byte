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
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isCompactNav = screenWidth < 900;
    final bodyHorizontalPadding = screenWidth >= 1200
        ? 32.0
        : (screenWidth >= 700 ? 24.0 : 16.0);

    return Scaffold(
      endDrawer: isCompactNav
          ? _MainNavDrawer(currentLocation: currentLocation)
          : null,
      appBar: AppBar(
        titleSpacing: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Container(height: 1.5, color: AppColors.borderSurface),
        ),
        title: isCompactNav
            ? _CompactAppBarTitle(
                currentLocation: currentLocation,
              )
            : _WideAppBarTitle(
                currentLocation: currentLocation,
              ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          bodyHorizontalPadding,
          AppSpacing.xxxl32,
          bodyHorizontalPadding,
          AppSpacing.xxxl32,
        ),
        child: child,
      ),
    );
  }
}

class _CompactAppBarTitle extends StatelessWidget {
  const _CompactAppBarTitle({required this.currentLocation});

  final String currentLocation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg16,
      ),
      child: Row(
        children: [
          AppBarNavItem(
            label: 'iron_byte'.tr(),
            route: AppRoutes.home,
            currentLocation: currentLocation,
            dense: true,
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              context.push(AppRoutes.consultation);
            },
            child: Text('free_consulatation'.tr()),
          ),
          const SizedBox(width: AppSpacing.sm8),
          Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              icon: const Icon(Icons.menu),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
      ),
    );
  }
}

class _WideAppBarTitle extends StatelessWidget {
  const _WideAppBarTitle({required this.currentLocation});

  final String currentLocation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth;
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
    );
  }
}

class _MainNavDrawer extends StatelessWidget {
  const _MainNavDrawer({required this.currentLocation});

  final String currentLocation;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg16,
            vertical: AppSpacing.md12,
          ),
          children: [
            ListTile(
              title: Text('iron_byte'.tr()),
              selected: currentLocation == AppRoutes.home,
              onTap: () {
                context.go(AppRoutes.home);
                Navigator.of(context).pop();
              },
            ),
            for (final item in kMainShellNavItems)
              ListTile(
                title: Text(item.labelKey.tr()),
                selected: currentLocation == item.route,
                onTap: () {
                  context.go(item.route);
                  Navigator.of(context).pop();
                },
              ),
          ],
        ),
      ),
    );
  }
}

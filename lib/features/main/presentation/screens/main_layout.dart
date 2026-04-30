import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iron_byte/core/navigation/home_scroll_coordinator.dart';
import 'package:iron_byte/core/router/app_routes.dart';
import 'package:iron_byte/core/router/main_shell_nav_items.dart';
import 'package:iron_byte/core/router/navigation_route_match.dart';
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
    final coordinator = HomeScrollScope.maybeOf(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isCompactNav = screenWidth < 900;
    final bodyHorizontalPadding = screenWidth >= 1200
        ? 32.0
        : (screenWidth >= 700 ? 24.0 : 16.0);

    return Scaffold(
      endDrawer: isCompactNav ? _MainNavDrawer(coordinator: coordinator) : null,
      appBar: AppBar(
        titleSpacing: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Container(height: 1.5, color: AppColors.borderSurface),
        ),
        title: isCompactNav
            ? _CompactAppBarTitle(coordinator: coordinator)
            : _WideAppBarTitle(coordinator: coordinator),
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
  const _CompactAppBarTitle({required this.coordinator});

  final HomeScrollCoordinator? coordinator;

  @override
  Widget build(BuildContext context) {
    if (coordinator == null) {
      final loc = shellNavigationLocation(context);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg16),
        child: Row(
          children: [
            AppBarNavItem(
              label: 'iron_byte'.tr(),
              route: AppRoutes.home,
              currentLocation: loc,
              dense: true,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => context.push(AppRoutes.consultation),
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

    return ListenableBuilder(
      listenable: coordinator!,
      builder: (context, _) {
        final actualLoc = shellNavigationLocation(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg16),
          child: Row(
            children: [
              AppBarNavItem(
                label: 'iron_byte'.tr(),
                route: AppRoutes.home,
                currentLocation: actualLoc,
                dense: true,
                onPressed: () =>
                    coordinator!.onShellNavTap(context, AppRoutes.home),
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
                  tooltip: MaterialLocalizations.of(
                    context,
                  ).openAppDrawerTooltip,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _WideAppBarTitle extends StatelessWidget {
  const _WideAppBarTitle({required this.coordinator});

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

class _MainNavDrawer extends StatelessWidget {
  const _MainNavDrawer({required this.coordinator});

  final HomeScrollCoordinator? coordinator;

  @override
  Widget build(BuildContext context) {
    Widget drawerBody(String highlight) {
      return ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg16,
          vertical: AppSpacing.md12,
        ),
        children: [
          ListTile(
            title: Text('iron_byte'.tr()),
            selected: NavigationRouteMatch.isRouteActive(
              currentLocation: highlight,
              routePath: AppRoutes.home,
            ),
            onTap: () {
              coordinator?.onShellNavTap(context, AppRoutes.home);
              Navigator.of(context).pop();
            },
          ),
          for (final item in kMainShellNavItems)
            ListTile(
              title: Text(item.labelKey.tr()),
              selected: NavigationRouteMatch.isRouteActive(
                currentLocation: highlight,
                routePath: item.route,
              ),
              onTap: () {
                coordinator?.onShellNavTap(context, item.route);
                Navigator.of(context).pop();
              },
            ),
        ],
      );
    }

    if (coordinator == null) {
      return Drawer(
        child: SafeArea(child: drawerBody(shellNavigationLocation(context))),
      );
    }

    return ListenableBuilder(
      listenable: coordinator!,
      builder: (context, _) {
        final highlight = shellNavHighlightLocation(context, coordinator!);
        return Drawer(child: SafeArea(child: drawerBody(highlight)));
      },
    );
  }
}

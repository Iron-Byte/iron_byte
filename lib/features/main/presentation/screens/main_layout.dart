import 'package:flutter/material.dart';
import 'package:iron_byte/core/navigation/home_scroll_coordinator.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/main/presentation/widgets/main_layout_compact_app_bar_title.dart';
import 'package:iron_byte/features/main/presentation/widgets/main_layout_nav_drawer.dart';
import 'package:iron_byte/features/main/presentation/widgets/main_layout_wide_app_bar_title.dart';

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
      endDrawer: isCompactNav
          ? MainLayoutNavDrawer(coordinator: coordinator)
          : null,
      appBar: AppBar(
        titleSpacing: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Container(height: 1.5, color: AppColors.borderSurface),
        ),
        title: isCompactNav
            ? MainLayoutCompactAppBarTitle(coordinator: coordinator)
            : MainLayoutWideAppBarTitle(coordinator: coordinator),
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

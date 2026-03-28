import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:iron_byte/core/theme/app_theme.dart';
import 'package:iron_byte/features/about/presentation/screens/about_screen.dart';
import 'package:iron_byte/features/home/presentation/screens/home_screen.dart';
import 'package:iron_byte/features/careers/presentation/screens/careers_screen.dart';
import 'package:iron_byte/features/portfolio/presentation/screens/portfolio.dart';
import 'package:iron_byte/features/services/presentation/screens/services_screen.dart';
import '../../core/widgets/energy_bnag.dart';

class MainScreen extends StatefulWidget {
  final Widget child;
  const MainScreen({super.key, required this.child});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController pageController = PageController();
  int pageIndex = 0;

  void goToPage(int index) {
    setState(() => pageIndex = index);

    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutBack,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Breakpoints:
        // Small: < 400
        // Medium: 400–800
        // Large: > 800
        final isSmall = width < 400;
        final isMedium = width >= 400 && width < 800;

        final toolbarHeight = isSmall ? 64.0 : isMedium ? 74.0 : 80.0;
        final titleFontSize = isSmall ? 18.0 : isMedium ? 20.0 : 22.0;
        final navFontSize = isSmall ? 12.0 : isMedium ? 13.0 : 14.0;

        final navItems = const <_NavItem>[
          _NavItem(index: 0, label: 'HOME'),
          _NavItem(index: 1, label: 'PORTFOLIO'),
          _NavItem(index: 2, label: 'SERVICES'),
          _NavItem(index: 3, label: 'CAREERS'),
          _NavItem(index: 4, label: 'ABOUT'),
        ];

        // Small: collapse into a popup menu
        final smallActions = <Widget>[
          PopupMenuButton<int>(
            tooltip: 'Navigation',
            onSelected: goToPage,
            itemBuilder: (context) => navItems
                .map(
                  (item) => PopupMenuItem<int>(
                    value: item.index,
                    child: Text(
                      item.label,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: pageIndex == item.index
                            ? Colors.deepOrangeAccent
                            : null,
                      ),
                    ),
                  ),
                )
                .toList(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: navFontSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ];

        // Medium: show first 3 + overflow popup for remaining
        final mediumActions = <Widget>[
          for (final item in navItems.take(3))
            _NavTextButton(
              index: item.index,
              label: item.label,
              isSelected: pageIndex == item.index,
              fontSize: navFontSize,
              onTap: goToPage,
            ),
          PopupMenuButton<int>(
            tooltip: 'More',
            onSelected: goToPage,
            itemBuilder: (context) => navItems
                .skip(3)
                .map(
                  (item) => PopupMenuItem<int>(
                    value: item.index,
                    child: Text(
                      item.label,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: pageIndex == item.index
                            ? Colors.deepOrangeAccent
                            : null,
                      ),
                    ),
                  ),
                )
                .toList(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'More',
                style: TextStyle(
                  fontSize: navFontSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ];

        // Large: show all actions normally, keep them compact
        final largeActions = <Widget>[
          for (final item in navItems)
            _NavTextButton(
              index: item.index,
              label: item.label,
              isSelected: pageIndex == item.index,
              fontSize: navFontSize,
              onTap: goToPage,
            ),
        ];

        return Scaffold(
          backgroundColor: AppColors.teal,
          appBar: AppBar(
            toolbarHeight: toolbarHeight,
            backgroundColor: AppColors.secondary.withValues(alpha: 0.10),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            centerTitle: false,
            title: Text(
              'Iron Byte',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: isSmall
                ? smallActions
                : isMedium
                    ? mediumActions
                    : largeActions,
          ),
          body: Padding(
            padding: const EdgeInsets.all(0),
            child: Stack(
              children: [
                const Positioned(
                  top: 60,
                  left: 200,
                  child: DiagonalEnergyLines(),
                ),
                BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                  child: Container(color: Colors.transparent),
                ),
                PageView(
                  controller: pageController,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() => pageIndex = index);
                  },
                  children: const [
                    HomeScreen(),
                    PortfolioScreen(),
                    ServicesScreen(),
                    CareersScreen(),
                    AboutScreen(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.index,
    required this.label,
  });

  final int index;
  final String label;
}

class _NavTextButton extends StatelessWidget {
  const _NavTextButton({
    required this.index,
    required this.label,
    required this.isSelected,
    required this.fontSize,
    required this.onTap,
  });

  final int index;
  final String label;
  final bool isSelected;
  final double fontSize;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onTap(index),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          color: isSelected ? Colors.deepOrangeAccent : null,
        ),
      ),
    );
  }
}

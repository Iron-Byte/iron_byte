import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:iron_byte/core/theme/app_theme.dart';
import 'package:iron_byte/features/home/presentation/screens/home_screen.dart';
import 'package:iron_byte/features/main/presentation/screens/careers_screen.dart';
import 'package:iron_byte/features/main/presentation/screens/services_screen.dart';
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
    return Scaffold(
      backgroundColor: AppColors.teal,
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            const Text('Iron Byte'),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () => goToPage(0),
                  child: const Text('Home'),
                ),
                TextButton(
                  onPressed: () => goToPage(1),
                  child: const Text('Careers'),
                ),
                TextButton(
                  onPressed: () => goToPage(2),
                  child: const Text('Services'),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
      body: Stack(
        children: [
          const Positioned(top: 0, left: 0, child: DiagonalEnergyLines()),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child: Container(color: Colors.transparent),
          ),
          PageView(
            controller: pageController,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) {
              setState(() => pageIndex = index);
            },
            children: const [HomeScreen(), CareersScreen(), ServicesScreen()],
          ),
        ],
      ),
    );
  }
}

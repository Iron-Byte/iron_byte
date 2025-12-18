import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui' as ui;

class MainScreen extends StatelessWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            // App name (left)
            const Text('Iron Byte'),

            // Spacer pushes nav to center
            const Spacer(),

            // Center navigation
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () => context.go('/home'),
                  child: const Text('Home'),
                ),
                TextButton(
                  onPressed: () => context.go('/careers'),
                  child: const Text('Careers'),
                ),
                TextButton(
                  onPressed: () => context.go('/services'),
                  child: const Text('Services'),
                ),
              ],
            ),

            // Spacer keeps nav centered
            const Spacer(),
          ],
        ),
      ),
      body: Stack(
        children: [
        
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orange, width: 40),
            ),
          ),
          BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          child: Container(color: Colors.transparent),
        ),
            child,
        ],
      ),
    );
  }
}

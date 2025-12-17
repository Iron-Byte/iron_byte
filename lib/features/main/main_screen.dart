import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  final Widget child;

  const MainScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iron Byte'),
        actions: [
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
      body: child,
    );
  }
}

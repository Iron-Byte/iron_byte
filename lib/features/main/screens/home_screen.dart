import 'package:flutter/material.dart';
import 'package:iron_byte/core/theme/app_theme.dart';

import 'dart:ui' as ui;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
     child: Center(
       child: Text('Home Screen', style: TextStyle(fontSize: 24)),
     ),
            );
  }
}

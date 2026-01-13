import 'package:flutter/material.dart';
import 'package:iron_byte/core/extensions.dart';

import 'package:iron_byte/widgets/mate_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: MateContainer(
                        title: 'Your vision.',
                        subtitle: 'Our innovative solutions.',
                        description1: '24/7 client and app support',
                        description2: '24/7 client and app support',
                        description3: '24/7 client and app support',
                      ),
                    ),
                  ],
                ),
              ),
                
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 2,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

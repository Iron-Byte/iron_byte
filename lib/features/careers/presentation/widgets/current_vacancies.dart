import 'package:flutter/material.dart';
import 'package:iron_byte/core/utils/extensions.dart';
import 'package:iron_byte/core/utils/sizes.dart';

class CurrentVacancies extends StatefulWidget {
  const CurrentVacancies({super.key});

  @override
  State<CurrentVacancies> createState() => _CurrentVacanciesState();
}

class _CurrentVacanciesState extends State<CurrentVacancies> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.padding32),
        child: Text(
          'There are currently no open positions available :( \n\n'
          'But send us your information and we’ll be in touch when a good opportunity becomes available for you. ;)',
          style: context.h3,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

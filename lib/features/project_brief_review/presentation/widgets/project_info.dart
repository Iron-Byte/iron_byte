import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/project_brief_review/data/datasources/project_brief_review_local_datasource.dart';
import 'package:iron_byte/features/project_brief_review/data/repositories/project_brief_review_repository_impl.dart';
import 'package:iron_byte/features/project_brief_review/domain/entities/project_brief_review.dart';
import 'package:iron_byte/features/project_brief_review/domain/usecases/get_featured_project_brief.dart';

class ProjectInfo extends StatelessWidget {
  const ProjectInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Text('s'),
    );
  }
}

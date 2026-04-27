import 'package:iron_byte/features/project_brief_review/domain/entities/project_brief_review.dart';

class ProjectBriefReviewModel extends ProjectBriefReview {
  const ProjectBriefReviewModel({
    required super.appName,
    required super.slogan,
    required super.description,
    required super.rating,
    required super.downloads,
    required super.imageAssetPath,
    required super.storeUrl,
  });
}

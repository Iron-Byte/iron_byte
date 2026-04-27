import 'package:iron_byte/features/project_brief_review/domain/entities/project_brief_review.dart';
import 'package:iron_byte/features/project_brief_review/domain/repositories/project_brief_review_repository.dart';

class GetFeaturedProjectBrief {
  const GetFeaturedProjectBrief(this._repository);

  final ProjectBriefReviewRepository _repository;

  ProjectBriefReview call() => _repository.getFeaturedProject();
}

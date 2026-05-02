import 'package:iron_byte/features/project_brief_review/data/datasources/project_brief_review_local_datasource.dart';
import 'package:iron_byte/features/project_brief_review/domain/entities/project_brief_review.dart';
import 'package:iron_byte/features/project_brief_review/domain/repositories/project_brief_review_repository.dart';

class ProjectBriefReviewRepositoryImpl implements ProjectBriefReviewRepository {
  const ProjectBriefReviewRepositoryImpl(this._localDataSource);

  final ProjectBriefReviewLocalDataSource _localDataSource;

  @override
  ProjectBriefReview getFeaturedProject() {
    return _localDataSource.featuredProject();
  }
}

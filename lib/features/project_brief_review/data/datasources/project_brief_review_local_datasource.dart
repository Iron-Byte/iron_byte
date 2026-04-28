import 'package:iron_byte/features/project_brief_review/data/models/project_brief_review_model.dart';

class ProjectBriefReviewLocalDataSource {
  const ProjectBriefReviewLocalDataSource();

  ProjectBriefReviewModel featuredProject() {
    return const ProjectBriefReviewModel(
      appName: 'Language Kit',
      slogan: 'Your pocket coach for confident English.',
      description:
          'Language Kit helps learners improve English with practical lessons, '
          'daily speaking drills, and vocabulary training designed for real conversations.',
      rating: '4.8/5 (App Store)',
      downloads: '50K+ downloads (estimated)',
      imageAssetPath: 'assets/images/pictures/language_kit/language_kit_01.webp',
      storeUrl:
          'https://apps.apple.com/us/app/learn-english-languagekit/id6476380601',
    );
  }
}

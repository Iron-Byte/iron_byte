import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/project_brief_review/data/datasources/project_brief_review_local_datasource.dart';
import 'package:iron_byte/features/project_brief_review/data/repositories/project_brief_review_repository_impl.dart';
import 'package:iron_byte/features/project_brief_review/domain/entities/project_brief_review.dart';
import 'package:iron_byte/features/project_brief_review/domain/usecases/get_featured_project_brief.dart';

class ProjectBriefReviewSection extends StatelessWidget {
  const ProjectBriefReviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    const useCase = GetFeaturedProjectBrief(
      ProjectBriefReviewRepositoryImpl(ProjectBriefReviewLocalDataSource()),
    );
    final project = useCase();

    return LayoutBuilder(
      builder: (context, constraints) {
        final mobile = constraints.maxWidth < 980;
        final slider = _ProjectReviewSlider(project: project);
        final cards = _ProjectReviewCards(project: project, compact: mobile);

        return mobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  slider,
                  const SizedBox(height: AppSpacing.xxl24),
                  cards,
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 7, child: slider),
                  const SizedBox(width: AppSpacing.xxl24),
                  Expanded(flex: 3, child: cards),
                ],
              );
      },
    );
  }
}

class _ProjectReviewSlider extends StatelessWidget {
  const _ProjectReviewSlider({required this.project});

  final ProjectBriefReview project;

  @override
  Widget build(BuildContext context) {
    final maxW = MediaQuery.sizeOf(context).width;
    // final sliderHeight = maxW < 980 ? 280.0 : 520.0;

    const images = [
      'assets/images/pictures/language_kit/language_kit_01.webp',
      'assets/images/pictures/language_kit/language_kit_02.webp',
      'assets/images/pictures/language_kit/language_kit_03.webp',
      'assets/images/pictures/language_kit/language_kit_04.webp',
      'assets/images/pictures/language_kit/language_kit_05.webp',
    ];

    return Padding(
      padding: AppSpacing.allLg16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            project.appName,
            style: AppTextStyles.label.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: AppSpacing.md12),
          ClipRRect(
            borderRadius: AppRadius.borderMd12,
            child: _CarouselSlider(
              imagePaths: images,
            ), // height: sliderHeight),
          ),
        ],
      ),
    );
  }
}

class _CarouselSlider extends StatefulWidget {
  const _CarouselSlider({required this.imagePaths});

  final List<String> imagePaths;
  // final double height;

  @override
  State<_CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<_CarouselSlider> {
  late final PageController _controller;
  Timer? _autoPlayTimer;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.88);
    _startAutoPlay();
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    if (widget.imagePaths.length < 2) return;
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted || !_controller.hasClients) return;
      final next = (_page + 1) % widget.imagePaths.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 360),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    height: 520,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.imagePaths.length,
        onPageChanged: (value) => setState(() => _page = value),
        itemBuilder: (context, index) {
          final active = index == _page;
          return AnimatedPadding(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.sm8,
              vertical: active ? AppSpacing.sm8 : AppSpacing.lg16,
            ),
            child: ClipRRect(
              borderRadius: AppRadius.borderMd12,
              child: Image.asset(
                widget.imagePaths[index],
                fit: BoxFit.contain,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    size: 40,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProjectReviewCards extends StatelessWidget {
  const _ProjectReviewCards({required this.project, required this.compact});

  final ProjectBriefReview project;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final cards = [
      _ReviewCardData(title: 'App', body: project.appName),
      _ReviewCardData(title: 'Slogan', body: project.slogan),
      _ReviewCardData(title: 'Description', body: project.description),
      _ReviewCardData(title: 'Rating', body: project.rating),
      _ReviewCardData(title: 'Downloads', body: project.downloads),
    ];

    // final cardWidth = compact ? 250.0  : 250.0;
    // final cardHeight = compact ? 220.0 : 250.0;

    return Wrap(
      spacing: AppSpacing.lg16,
      runSpacing: AppSpacing.lg16,
      // children: [
      //   for (final card in cards)
      //     _ReviewInfoCard(data: card),
      //   _StoreLinkCard(url: project.storeUrl),
      // ],
    );
  }
}

class _ReviewInfoCard extends StatelessWidget {
  const _ReviewInfoCard({required this.data});

  final _ReviewCardData data;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.borderMd12,
        border: Border.all(color: AppColors.borderSurface),
      ),
      child: Padding(
        padding: AppSpacing.allLg16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              data.title,
              style: AppTextStyles.tag.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: AppSpacing.md12),
            Expanded(
              child: SelectableText(
                data.body,
                style: AppTextStyles.label.copyWith(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Cinzel',
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoreLinkCard extends StatelessWidget {
  const _StoreLinkCard({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.borderMd12,
        border: Border.all(color: AppColors.borderSurface),
      ),
      child: Padding(
        padding: AppSpacing.allLg16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              'Store',
              style: AppTextStyles.tag.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: AppSpacing.md12),
            SelectableText(
              'Read reviews and explore Language Kit on the App Store.',
              style: AppTextStyles.bodySmall,
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () async {
                final uri = Uri.parse(url);
                if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
                  throw StateError('Could not open store URL.');
                }
              },
              icon: const Icon(Icons.open_in_new, size: 16),
              label: const Text('Open App Store'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewCardData {
  const _ReviewCardData({required this.title, required this.body});

  final String title;
  final String body;
}

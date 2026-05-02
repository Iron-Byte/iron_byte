import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iron_byte/core/router/app_routes.dart';

/// Logical sections on the single-page home scroll (used for scroll + nav highlight).
enum HomeScrollSection { home, portfolio, services, careers, about }

/// Central scroll + in-view section tracking. Does **not** change GoRouter paths
/// for shell tabs — only [ScrollController] + [Scrollable.ensureVisible].
class HomeScrollCoordinator extends ChangeNotifier {
  HomeScrollCoordinator();

  final ScrollController scrollController = ScrollController();

  final GlobalKey homeHeroKey = GlobalKey();
  final GlobalKey languageKitSectionKey = GlobalKey();
  final GlobalKey servicesSectionKey = GlobalKey();
  final GlobalKey careersSectionKey = GlobalKey();
  final GlobalKey aboutSectionKey = GlobalKey();

  final Map<HomeScrollSection, double> _visibilityFraction = {
    for (final s in HomeScrollSection.values) s: 0,
  };

  HomeScrollSection _activeSection = HomeScrollSection.home;
  HomeScrollSection get activeSection => _activeSection;

  /// Path string that matches [AppRoutes] for [NavigationRouteMatch] / app bar.
  String get navHighlightPath => switch (_activeSection) {
    HomeScrollSection.home => AppRoutes.home,
    HomeScrollSection.portfolio => AppRoutes.portfolio,
    HomeScrollSection.services => AppRoutes.services,
    HomeScrollSection.careers => AppRoutes.careers,
    HomeScrollSection.about => AppRoutes.about,
  };

  static const double _visibilityEpsilon = 0.001;

  void onSectionVisibility(HomeScrollSection section, double visibleFraction) {
    final f = visibleFraction.clamp(0.0, 1.0);
    if ((_visibilityFraction[section]! - f).abs() < _visibilityEpsilon) return;
    _visibilityFraction[section] = f;
    _recomputeActiveSection();
  }

  /// Same as [onSectionVisibility] for [HomeScrollSection.portfolio] (legacy name).
  void onLanguageKitVisibilityChanged(double visibleFraction) {
    onSectionVisibility(HomeScrollSection.portfolio, visibleFraction);
  }

  void _recomputeActiveSection() {
    HomeScrollSection? best;
    var bestF = 0.0;
    for (final s in HomeScrollSection.values) {
      final v = _visibilityFraction[s] ?? 0;
      if (v > bestF) {
        bestF = v;
        best = s;
      }
    }
    final next = best ?? HomeScrollSection.home;
    if (next == _activeSection) return;
    _activeSection = next;
    notifyListeners();
  }

  void scrollToTop() {
    if (!scrollController.hasClients) return;
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
    );
  }

  void _ensureKey(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 520),
      curve: Curves.easeOutCubic,
      alignment: 0,
    );
  }

  /// Shell nav / in-page: scroll only (no route changes).
  void scrollToShellRoute(String route) {
    switch (route) {
      case AppRoutes.home:
        scrollToTop();
        return;
      case AppRoutes.portfolio:
        _ensureKey(languageKitSectionKey);
        return;
      case AppRoutes.services:
        _ensureKey(servicesSectionKey);
        return;
      case AppRoutes.careers:
        _ensureKey(careersSectionKey);
        return;
      case AppRoutes.about:
        _ensureKey(aboutSectionKey);
        return;
      default:
        scrollToTop();
    }
  }

  /// App bar / drawer: single entry — scroll on home; from consultation, [go]
  /// home then scroll after layout.
  void onShellNavTap(BuildContext context, String route) {
    final loc = GoRouterState.of(context).matchedLocation;
    if (loc == AppRoutes.consultation) {
      context.go(AppRoutes.home);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollToShellRoute(route);
        });
      });
      return;
    }
    scrollToShellRoute(route);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

class HomeScrollScope extends InheritedWidget {
  const HomeScrollScope({
    super.key,
    required this.coordinator,
    required super.child,
  });

  final HomeScrollCoordinator coordinator;

  static HomeScrollCoordinator of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<HomeScrollScope>();
    assert(scope != null, 'HomeScrollScope not found in context');
    return scope!.coordinator;
  }

  static HomeScrollCoordinator? maybeOf(BuildContext context) {
    return context
        .getInheritedWidgetOfExactType<HomeScrollScope>()
        ?.coordinator;
  }

  @override
  bool updateShouldNotify(HomeScrollScope oldWidget) =>
      coordinator != oldWidget.coordinator;
}

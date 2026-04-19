# Iron Byte

Flutter application for the Iron Byte agency site: marketing pages (home, portfolio, services, careers, about), shared shell navigation, and consultation entry points. UI strings are localized; feature screens use **BLoC** and **freezed** where state is modeled.

## Table of contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Tech stack](#tech-stack)
- [Run the app](#run-the-app)
- [Tests](#tests)
- [Project layout](#project-layout)
- [Application entry](#application-entry)
- [Routing](#routing)
- [Shell layout and global BLoCs](#shell-layout-and-global-blocs)
- [Theming](#theming)
- [Localization](#localization)
- [Feature modules](#feature-modules)
  - [Home](#home)
  - [Main (shell)](#main-shell)
  - [Portfolio](#portfolio)
  - [Services](#services)
  - [Careers](#careers)
  - [About](#about)
  - [Consultation](#consultation)
  - [Consultation item](#consultation-item)
- [Code generation](#code-generation)
- [Configuration](#configuration)

## Overview

The app boots with **EasyLocalization**, registers global **MainBloc** and **HomeBloc**, and uses **go_router** with a **ShellRoute** so every route shares the same chrome ([`MainLayout`](lib/features/main/presentation/screens/main_layout.dart)). Individual marketing routes live under `lib/features/*/presentation/screens/`; thin re-exports in [`lib/screens/`](lib/screens/) keep router imports stable.

## Requirements

- Flutter SDK compatible with **Dart ^3.10.3** (see [`pubspec.yaml`](pubspec.yaml)).

## Tech stack

| Concern | Implementation |
|--------|------------------|
| UI | Flutter (Material 3) |
| Navigation | [go_router](https://pub.dev/packages/go_router) — [`AppRouter`](lib/router.dart) |
| State | [flutter_bloc](https://pub.dev/packages/flutter_bloc), [freezed](https://pub.dev/packages/freezed) for union states |
| i18n | [easy_localization](https://pub.dev/packages/easy_localization) — [`assets/translations/en.json`](assets/translations/en.json) |
| Deep links (team social) | [url_launcher](https://pub.dev/packages/url_launcher) |

## Run the app

```bash
flutter pub get
flutter run
```

## Tests

```bash
flutter test
```

Smoke test: [`test/widget_test.dart`](test/widget_test.dart).

## Project layout

| Path | Role |
|------|------|
| [`lib/main.dart`](lib/main.dart) | `main()`, `IronByteApp`, `MultiBlocProvider`, `MaterialApp.router` |
| [`lib/router.dart`](lib/router.dart) | `GoRouter` factory, routes, `/porfolio` → `/portfolio` redirect |
| [`lib/core/themes/`](lib/core/themes/) | Colors, typography, spacing, radius, `AppTheme.dark` |
| [`lib/features/`](lib/features/) | Feature-first modules (`presentation`, `domain`, `data` where used) |
| [`lib/screens/`](lib/screens/) | Barrel exports to feature screens (router compatibility) |
| [`assets/translations/`](assets/translations/) | JSON locale files |

## Application entry

- [`lib/main.dart`](lib/main.dart) — initializes bindings and EasyLocalization, provides [`MainBloc`](lib/features/main/presentation/bloc/main_bloc.dart) and [`HomeBloc`](lib/features/home/presentation/bloc/home_bloc.dart), applies [`AppTheme.dark`](lib/core/themes/app_themes.dart) and [`AppRouter.createRouter()`](lib/router.dart).

## Routing

- [`lib/router.dart`](lib/router.dart) — defines `ShellRoute` → [`MainLayout`](lib/features/main/presentation/screens/main_layout.dart) and child routes:

| Path | Screen |
|------|--------|
| `/` | [`HomeScreen`](lib/features/home/presentation/screens/home_screen.dart) |
| `/portfolio` | [`PortfolioScreen`](lib/features/portfolio/presentation/screens/portfolio_screen.dart) |
| `/services` | [`ServicesScreen`](lib/features/services/presentation/screens/services_screen.dart) |
| `/careers` | [`CareersScreen`](lib/features/careers/presentation/screens/careers_screen.dart) |
| `/about` | [`AboutScreen`](lib/features/about/presentation/screens/about_screen.dart) |
| `/consultation` | [`ConsultationScreen`](lib/screens/consultation_screen.dart) |

Legacy path `/porfolio` redirects to `/portfolio`.

## Shell layout and global BLoCs

- [`lib/features/main/presentation/screens/main_layout.dart`](lib/features/main/presentation/screens/main_layout.dart) — app bar, nav links (`context.go`), consultation CTA (`context.push`), body padding, [`MainBloc`](lib/features/main/presentation/bloc/main_bloc.dart) builder (currently passes child through).

## Theming

| File | Contents |
|------|----------|
| [`lib/core/themes/app_colors.dart`](lib/core/themes/app_colors.dart) | Brand and semantic colors |
| [`lib/core/themes/app_text_style.dart`](lib/core/themes/app_text_style.dart) | Shared `TextStyle`s |
| [`lib/core/themes/app_spacing.dart`](lib/core/themes/app_spacing.dart) | Spacing constants and `EdgeInsets` |
| [`lib/core/themes/app_radius.dart`](lib/core/themes/app_radius.dart) | Corner radii |
| [`lib/core/themes/app_themes.dart`](lib/core/themes/app_themes.dart) | `AppTheme.dark` — full `ThemeData` |
| [`lib/core/themes/themes.dart`](lib/core/themes/themes.dart) | Barrel (includes easy_localization export) |

## Localization

- Source strings: [`assets/translations/en.json`](assets/translations/en.json)
- Usage: `.tr()` via [`themes.dart`](lib/core/themes/themes.dart) export of easy_localization.

## Feature modules

### Home

| Piece | File |
|-------|------|
| Barrel | [`lib/features/home/home.dart`](lib/features/home/home.dart) |
| Screen | [`lib/features/home/presentation/screens/home_screen.dart`](lib/features/home/presentation/screens/home_screen.dart) |
| BLoCs | [`home_bloc.dart`](lib/features/home/presentation/bloc/home_bloc.dart), [`home_consultation_bloc.dart`](lib/features/home/presentation/bloc/home_consultation_bloc.dart) |
| Widgets | [`hero_section.dart`](lib/features/home/presentation/widgets/hero_section.dart), [`consultation_card.dart`](lib/features/home/presentation/widgets/consultation_card.dart), [`stats_row.dart`](lib/features/home/presentation/widgets/stats_row.dart), [`status_chip.dart`](lib/features/home/presentation/widgets/status_chip.dart), etc. |
| Domain / data | [`home_repository.dart`](lib/features/home/domain/repositories/home_repository.dart), [`home_repository_impl.dart`](lib/features/home/data/repositories/home_repository_impl.dart), [`home_remote_datasource.dart`](lib/features/home/data/datasources/home_remote_datasource.dart) |

### Main (shell)

| Piece | File |
|-------|------|
| Barrel | [`lib/features/main/main.dart`](lib/features/main/main.dart) |
| Layout | [`main_layout.dart`](lib/features/main/presentation/screens/main_layout.dart) |
| BLoC | [`main_bloc.dart`](lib/features/main/presentation/bloc/main_bloc.dart) |
| Repository | [`main_repository_impl.dart`](lib/features/main/data/repositories/main_repository_impl.dart) |

### Portfolio

| Piece | File |
|-------|------|
| Barrel | [`lib/features/portfolio/portfolio.dart`](lib/features/portfolio/portfolio.dart) |
| Screen | [`portfolio_screen.dart`](lib/features/portfolio/presentation/screens/portfolio_screen.dart) |
| BLoC | [`portfolio_bloc.dart`](lib/features/portfolio/presentation/bloc/portfolio_bloc.dart), [`portfolio_state.dart`](lib/features/portfolio/presentation/bloc/portfolio_state.dart) |
| UI models | [`portfolio_ui_models.dart`](lib/features/portfolio/presentation/models/portfolio_ui_models.dart) |
| Widgets | [`portfolio_project_card.dart`](lib/features/portfolio/presentation/widgets/portfolio_project_card.dart), [`portfolio_filter_bar.dart`](lib/features/portfolio/presentation/widgets/portfolio_filter_bar.dart) |

### Services

| Piece | File |
|-------|------|
| Barrel | [`lib/features/services/services.dart`](lib/features/services/services.dart) |
| Screen | [`services_screen.dart`](lib/features/services/presentation/screens/services_screen.dart) |
| BLoC | [`services_bloc.dart`](lib/features/services/presentation/bloc/services_bloc.dart) |
| Models | [`services_ui_models.dart`](lib/features/services/presentation/models/services_ui_models.dart) |
| Widgets | [`services_capability_card.dart`](lib/features/services/presentation/widgets/services_capability_card.dart), [`services_pricing_card.dart`](lib/features/services/presentation/widgets/services_pricing_card.dart) |

Thin export: [`lib/screens/services_screen.dart`](lib/screens/services_screen.dart).

### Careers

| Piece | File |
|-------|------|
| Barrel | [`lib/features/careers/careers.dart`](lib/features/careers/careers.dart) |
| Screen | [`careers_screen.dart`](lib/features/careers/presentation/screens/careers_screen.dart) |
| BLoC | [`careers_bloc.dart`](lib/features/careers/presentation/bloc/careers_bloc.dart) |
| Models | [`careers_ui_models.dart`](lib/features/careers/presentation/models/careers_ui_models.dart) |
| Widgets | [`careers_why_card.dart`](lib/features/careers/presentation/widgets/careers_why_card.dart), [`careers_job_card.dart`](lib/features/careers/presentation/widgets/careers_job_card.dart), [`careers_open_application_banner.dart`](lib/features/careers/presentation/widgets/careers_open_application_banner.dart) |

Thin export: [`lib/screens/careers_screen.dart`](lib/screens/careers_screen.dart).

### About

| Piece | File |
|-------|------|
| Barrel | [`lib/features/about/about.dart`](lib/features/about/about.dart) |
| Screen | [`about_screen.dart`](lib/features/about/presentation/screens/about_screen.dart) |
| BLoC | [`about_bloc.dart`](lib/features/about/presentation/bloc/about_bloc.dart) |
| Models | [`about_ui_models.dart`](lib/features/about/presentation/models/about_ui_models.dart) |
| Widgets | [`about_stat_card.dart`](lib/features/about/presentation/widgets/about_stat_card.dart), [`about_value_card.dart`](lib/features/about/presentation/widgets/about_value_card.dart), [`about_team_member_card.dart`](lib/features/about/presentation/widgets/about_team_member_card.dart), [`about_cta_banner.dart`](lib/features/about/presentation/widgets/about_cta_banner.dart) |

Thin export: [`lib/screens/about_screen.dart`](lib/screens/about_screen.dart).

### Consultation

| File |
|------|
| [`lib/screens/consultation_screen.dart`](lib/screens/consultation_screen.dart) |

### Consultation item

| File |
|------|
| [`lib/features/consultation_item/consultation_item.dart`](lib/features/consultation_item/consultation_item.dart) |
| [`lib/features/consultation_item/presentation/screens/consultation_item_screen.dart`](lib/features/consultation_item/presentation/screens/consultation_item_screen.dart) |

### Shared widgets

| File |
|------|
| [`lib/features/common_widgets/transparent_button.dart`](lib/features/common_widgets/transparent_button.dart) |

## Code generation

Union states use **freezed** (`*.dart` + `part '*.freezed.dart'`). After changing annotated files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Generated files under `lib/**` (for example `*_state.freezed.dart`) are produced by **Freezed** and retain generator headers when rebuilt.

## Configuration

| File | Purpose |
|------|---------|
| [`pubspec.yaml`](pubspec.yaml) | Package name, SDK, dependencies, assets, fonts |
| [`analysis_options.yaml`](analysis_options.yaml) | Lints (if present) |

---

**Iron Byte** — custom software positioning, dark theme, Cinzel/Playfair accents in UI, consultation funnel to `/consultation`.

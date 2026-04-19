import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iron_byte/core/themes/themes.dart';
import 'package:iron_byte/features/common_widgets/transparent_button.dart';
import 'package:iron_byte/features/consultation_item/presentation/screens/consultation_item_screen.dart';
import 'package:iron_byte/features/home/home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Offset mousePosition = Offset.zero;

  List<Widget> getTransparentButtons({required List<String> titles}) {
    List<Widget> transparentIcons = [];
    transparentIcons = [
      for (var i = 0; i < titles.length; ++i)
        TransparentButton(
          transparency: 36,
          child: RichText(
            text: TextSpan(
              text: '● ',
              style: AppTextStyles.label.copyWith(
                color: AppColors.textPrimary_brand,
              ),
              children: [
                TextSpan(
                  text: titles[i].tr(),
                  style: AppTextStyles.label.copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
    ];
    return transparentIcons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'we_turn_ideas'.tr(),
                      style: AppTextStyles.hero.copyWith(
                        fontFamily: 'Cinzel',
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(height: AppSpacing.md12),
                    Text(
                      'software_works'.tr(),
                      style: AppTextStyles.heroAccent.copyWith(
                        fontFamily: 'Cinzel',
                      ),
                    ),
                    SizedBox(height: AppSpacing.md12),
                    Text(
                      'web_apps'.tr(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.label.copyWith(
                        fontFamily: 'Cinzel',
                        color: AppColors.textPrimary.withAlpha(186),
                      ),
                    ),
                    SizedBox(height: AppSpacing.md12),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.horizontal,
                      children: getTransparentButtons(
                        titles: [
                          'custom_software_dev',
                          'web_dev',
                          'mobile_dev',
                          'cloud_solutions',
                          'saas',
                          'api_integration',
                          'devops',
                          'ui_ux',
                          'data_engineering',
                          'web_view_platform_development',
                          '2d_animations',
                        ],
                      ),
                    ),
                    Gap(AppSpacing.huge36),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              '50+',
                              style: AppTextStyles.hero.copyWith(
                                fontFamily: 'Cinzel',
                              ),
                            ),
                            Text(
                              'projects_delivered'.tr(),
                              style: AppTextStyles.body.copyWith(
                                fontFamily: 'Cinzel',
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: SizedBox(
                            height: 100,
                            width: 1,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.borderSurface,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              '24/7',
                              style: AppTextStyles.hero.copyWith(
                                fontFamily: 'Cinzel',
                              ),
                            ),
                            Text(
                              'client_support'.tr(),
                              style: AppTextStyles.body.copyWith(
                                fontFamily: 'Cinzel',
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: SizedBox(
                            height: 100,
                            width: 1,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.borderSurface,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              '1 Hr',
                              style: AppTextStyles.hero.copyWith(
                                fontFamily: 'Cinzel',
                              ),
                            ),

                            Text(
                              'consultation_time'.tr(),
                              style: AppTextStyles.body.copyWith(
                                fontFamily: 'Cinzel',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(child: Column(children: [ConsultationItemScreen()])),
            ],
          );
        },
      ),
    );
  }
}

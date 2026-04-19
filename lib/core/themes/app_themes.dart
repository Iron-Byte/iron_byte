import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iron_byte/core/themes/app_colors.dart';
import 'package:iron_byte/core/themes/app_radius.dart';
import 'package:iron_byte/core/themes/app_text_style.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          brightness: Brightness.dark,
          primary: AppColors.primary,
          onPrimary: AppColors.textPrimary,
          primaryContainer: AppColors.primaryBg,
          onPrimaryContainer: AppColors.primary,
          secondary: AppColors.surface,
          onSecondary: AppColors.textPrimary,
          secondaryContainer: AppColors.surface,
          onSecondaryContainer: AppColors.textSecondary,
          surface: AppColors.surface,
          onSurface: AppColors.textPrimary,
          onSurfaceVariant: AppColors.textSecondary,
          outline: AppColors.border,
          outlineVariant: AppColors.borderSurface,
          error: Color(0xFFE8642A),
          onError: AppColors.textPrimary,
          scrim: Color(0x80000000),
        ),

        scaffoldBackgroundColor: AppColors.background,
        canvasColor: AppColors.background,
        cardColor: AppColors.surface,

        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          titleTextStyle: AppTextStyles.labelLarge,
          iconTheme: const IconThemeData(color: AppColors.textSecondary),
          actionsIconTheme: const IconThemeData(color: AppColors.textSecondary),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        ),

        textTheme: TextTheme(
          displayLarge: AppTextStyles.hero,
          displayMedium: AppTextStyles.hero,
          displaySmall: AppTextStyles.heroAccent,
          headlineLarge: AppTextStyles.labelLarge,
          headlineMedium: AppTextStyles.label,
          headlineSmall: AppTextStyles.labelSmall,
          titleLarge: AppTextStyles.label,
          titleMedium: AppTextStyles.labelSmall,
          titleSmall: AppTextStyles.caption,
          bodyLarge: AppTextStyles.body,
          bodyMedium: AppTextStyles.bodySmall,
          bodySmall: AppTextStyles.caption,
          labelLarge: AppTextStyles.button,
          labelMedium: AppTextStyles.pill,
          labelSmall: AppTextStyles.tag,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textPrimary,
            disabledBackgroundColor: AppColors.primaryBg,
            disabledForegroundColor: AppColors.textMuted,
            elevation: 0,
            shadowColor: Colors.transparent,
            textStyle: AppTextStyles.button,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.borderSm8,
            ),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.textPrimary,
            disabledForegroundColor: AppColors.textMuted,
            side: const BorderSide(color: AppColors.borderSubtle, width: 0.5),
            textStyle: AppTextStyles.button,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.borderSm8,
            ),
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.textPrimary,
            textStyle: AppTextStyles.button,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.borderSm8,
            ),
          ),
        ),

        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textPrimary,
            textStyle: AppTextStyles.button,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.borderSm8,
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.background,
          hoverColor: Colors.transparent,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 11),

          hintStyle: const TextStyle(
            fontSize: 14,
            color: AppColors.textPlaceholder,
            fontWeight: FontWeight.w400,
          ),
          labelStyle: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
          floatingLabelStyle: const TextStyle(
            fontSize: 12,
            color: AppColors.primary,
            fontWeight: FontWeight.w400,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderSm8,
            borderSide: const BorderSide(
                color: AppColors.borderSurface, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderSm8,
            borderSide:
                const BorderSide(color: AppColors.primary, width: 0.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderSm8,
            borderSide:
                const BorderSide(color: AppColors.primary, width: 0.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderSm8,
            borderSide:
                const BorderSide(color: AppColors.primary, width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: AppRadius.borderSm8,
            borderSide: const BorderSide(
                color: AppColors.borderSubtle, width: 0.5),
          ),
        ),

        cardTheme: CardThemeData(
          color: AppColors.surface,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderLg16,
            side: const BorderSide(
                color: AppColors.borderSurface, width: 0.5),
          ),
          margin: EdgeInsets.zero,
        ),

        dividerTheme: const DividerThemeData(
          color: AppColors.border,
          thickness: 0.5,
          space: 0,
        ),

        iconTheme: const IconThemeData(
          color: AppColors.textSecondary,
          size: 20,
        ),

        chipTheme: ChipThemeData(
          backgroundColor: AppColors.surface,
          selectedColor: AppColors.primaryBg,
          disabledColor: AppColors.surface,
          labelStyle: AppTextStyles.pill,
          side: const BorderSide(color: AppColors.borderSurface, width: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderPill36,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        ),

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.background,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textMuted,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: AppTextStyles.pill,
          unselectedLabelStyle: AppTextStyles.pill,
        ),

        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.background,
          indicatorColor: AppColors.primaryBg,
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: AppColors.primary, size: 22);
            }
            return const IconThemeData(color: AppColors.textMuted, size: 22);
          }),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppTextStyles.pill
                  .copyWith(color: AppColors.primary);
            }
            return AppTextStyles.pill;
          }),
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),

        drawerTheme: const DrawerThemeData(
          backgroundColor: AppColors.surface,
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(AppRadius.lg16),
            ),
          ),
        ),

        dialogTheme: DialogThemeData(
          backgroundColor: AppColors.surface,
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderLg16,
            side: const BorderSide(
                color: AppColors.borderSurface, width: 0.5),
          ),
          titleTextStyle: AppTextStyles.label,
          contentTextStyle: AppTextStyles.body,
        ),

        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.surface,
          contentTextStyle: AppTextStyles.bodySmall,
          actionTextColor: AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderSm8,
            side: const BorderSide(
                color: AppColors.borderSurface, width: 0.5),
          ),
          behavior: SnackBarBehavior.floating,
        ),

        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.textPrimary;
            }
            return AppColors.textMuted;
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return AppColors.borderSurface;
          }),
          trackOutlineColor:
              WidgetStateProperty.all(Colors.transparent),
        ),

        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(AppColors.textPrimary),
          side: const BorderSide(color: AppColors.borderSurface, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderXs6,
          ),
        ),

        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }
            return AppColors.textMuted;
          }),
        ),

        sliderTheme: SliderThemeData(
          activeTrackColor: AppColors.primary,
          inactiveTrackColor: AppColors.borderSurface,
          thumbColor: AppColors.primary,
          overlayColor: AppColors.primaryBg,
          valueIndicatorColor: AppColors.primary,
          valueIndicatorTextStyle: AppTextStyles.caption,
        ),

        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primary,
          linearTrackColor: AppColors.borderSurface,
          circularTrackColor: AppColors.borderSurface,
        ),

        tabBarTheme: TabBarThemeData(
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textMuted,
          labelStyle: AppTextStyles.labelSmall,
          unselectedLabelStyle: AppTextStyles.bodySmall,
          indicatorColor: AppColors.primary,
          indicatorSize: TabBarIndicatorSize.label,
          dividerColor: AppColors.border,
          overlayColor: WidgetStateProperty.all(AppColors.primaryBg),
        ),

        listTileTheme: ListTileThemeData(
          tileColor: Colors.transparent,
          selectedTileColor: AppColors.primaryBg,
          iconColor: AppColors.textSecondary,
          textColor: AppColors.textPrimary,
          subtitleTextStyle: AppTextStyles.caption,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.borderSm8,
          ),
        ),

        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.borderSm8,
            border: Border.all(color: AppColors.borderSurface, width: 0.5),
          ),
          textStyle: AppTextStyles.caption,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),

        splashColor: AppColors.primaryBg,
        highlightColor: AppColors.primaryBg,
        hoverColor: AppColors.primaryBg,
        focusColor: AppColors.primaryBorder,
        disabledColor: AppColors.textMuted,
        shadowColor: Colors.transparent,
        unselectedWidgetColor: AppColors.textMuted,
      );
}

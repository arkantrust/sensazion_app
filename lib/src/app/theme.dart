import 'package:flutter/material.dart';

// Generate color schemes from blue seed color
var lightPalette = ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.light);

var darkPalette = ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark);

ThemeData _appTheme(ColorScheme palette) {
  return ThemeData(
    colorScheme: palette,
    useMaterial3: true,

    // App Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: palette.surface,
      foregroundColor: palette.onSurface,
      elevation: 0,
      scrolledUnderElevation: 3,
      surfaceTintColor: palette.surfaceTint,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: palette.onSurface,
      ),
    ),

    // Navigation Bar Theme
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: palette.surface,
      surfaceTintColor: palette.surfaceTint,
      indicatorColor: palette.secondaryContainer,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: palette.onSecondaryContainer,
          );
        }
        return TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: palette.onSurfaceVariant,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: palette.onSecondaryContainer, size: 24);
        }
        return IconThemeData(color: palette.onSurfaceVariant, size: 24);
      }),
    ),

    // Bottom Navigation Bar Theme (for legacy support)
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: palette.surface,
      selectedItemColor: palette.primary,
      unselectedItemColor: palette.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      elevation: 3,
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: palette.surface,
      surfaceTintColor: palette.surfaceTint,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: palette.primary,
        foregroundColor: palette.onPrimary,
        elevation: 1,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),

    // Filled Button Theme
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: palette.primary,
        foregroundColor: palette.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: palette.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: palette.primary,
        side: BorderSide(color: palette.outline),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: palette.primaryContainer,
      foregroundColor: palette.onPrimaryContainer,
      elevation: 3,
      focusElevation: 4,
      hoverElevation: 4,
      highlightElevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: palette.surfaceContainerHighest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: palette.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: palette.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: palette.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: palette.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: palette.error, width: 2),
      ),
      labelStyle: TextStyle(color: palette.onSurfaceVariant),
      hintStyle: TextStyle(color: palette.onSurfaceVariant),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: palette.surfaceContainerLow,
      selectedColor: palette.secondaryContainer,
      disabledColor: palette.onSurface.withValues(alpha: 0.12),
      labelStyle: TextStyle(color: palette.onSurfaceVariant),
      side: BorderSide(color: palette.outline),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // Dialog Theme
    dialogTheme: DialogTheme(
      backgroundColor: palette.surface,
      surfaceTintColor: palette.surfaceTint,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: palette.onSurface,
      ),
      contentTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: palette.onSurfaceVariant,
        height: 1.4,
      ),
    ),

    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return palette.onPrimary;
        }
        return palette.outline;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return palette.primary;
        }
        return palette.surfaceContainerHighest;
      }),
    ),

    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return palette.primary;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(palette.onPrimary),
      side: BorderSide(color: palette.outline, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
    ),

    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return palette.primary;
        }
        return palette.outline;
      }),
    ),

    // Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: palette.primary,
      inactiveTrackColor: palette.surfaceContainerHighest,
      thumbColor: palette.primary,
      overlayColor: palette.primary.withValues(alpha: 0.12),
      valueIndicatorColor: palette.primary,
      valueIndicatorTextStyle: TextStyle(
        color: palette.onPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: palette.primary,
      linearTrackColor: palette.surfaceContainerHighest,
      circularTrackColor: palette.surfaceContainerHighest,
    ),

    // List Tile Theme
    listTileTheme: ListTileThemeData(
      tileColor: Colors.transparent,
      selectedTileColor: palette.secondaryContainer.withValues(alpha: 0.3),
      iconColor: palette.onSurfaceVariant,
      textColor: palette.onSurface,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: palette.onSurface,
      ),
      subtitleTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: palette.onSurfaceVariant,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(color: palette.outlineVariant, thickness: 1, space: 1),

    // Icon Theme
    iconTheme: IconThemeData(color: palette.onSurfaceVariant, size: 24),

    // Primary Icon Theme
    primaryIconTheme: IconThemeData(color: palette.primary, size: 24),

    // Enhanced Text Theme with better hierarchy
    textTheme: TextTheme(
      // Display styles - for hero text
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        height: 1.12,
        color: palette.onSurface,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.16,
        color: palette.onSurface,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.22,
        color: palette.onSurface,
      ),

      // Headline styles - for section headers
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.25,
        color: palette.onSurface,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.29,
        color: palette.onSurface,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.33,
        color: palette.onSurface,
      ),

      // Title styles - for component headers
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: 1.27,
        color: palette.onSurface,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        height: 1.5,
        color: palette.onSurface,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
        color: palette.onSurface,
      ),

      // Label styles - for buttons and small UI elements
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
        color: palette.onSurface,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.33,
        color: palette.onSurface,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.45,
        color: palette.onSurface,
      ),

      // Body styles - for main content
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.5,
        color: palette.onSurface,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.43,
        color: palette.onSurface,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.33,
        color: palette.onSurfaceVariant,
      ),
    ),

    // Material 3 specific properties
    snackBarTheme: SnackBarThemeData(
      backgroundColor: palette.inverseSurface,
      contentTextStyle: TextStyle(color: palette.onInverseSurface),
      actionTextColor: palette.inversePrimary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    // Tab Bar Theme
    tabBarTheme: TabBarTheme(
      labelColor: palette.primary,
      unselectedLabelColor: palette.onSurfaceVariant,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: palette.primary, width: 3),
        insets: const EdgeInsets.symmetric(horizontal: 16),
      ),
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    ),

    // Expansion Tile Theme
    expansionTileTheme: ExpansionTileThemeData(
      backgroundColor: palette.surface,
      collapsedBackgroundColor: palette.surface,
      textColor: palette.onSurface,
      collapsedTextColor: palette.onSurface,
      iconColor: palette.onSurfaceVariant,
      collapsedIconColor: palette.onSurfaceVariant,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}

// Public theme accessors
ThemeData get lightTheme => _appTheme(lightPalette);
ThemeData get darkTheme => _appTheme(darkPalette);

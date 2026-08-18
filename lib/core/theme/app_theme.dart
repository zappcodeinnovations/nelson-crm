import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Complete ThemeData for Nelson Staff CRM.
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: NelsonColors.primaryBlue,
      scaffoldBackgroundColor: NelsonColors.background,
      colorScheme: const ColorScheme.light(
        primary: NelsonColors.primaryBlue,
        onPrimary: NelsonColors.white,
        secondary: NelsonColors.primaryRed,
        onSecondary: NelsonColors.white,
        surface: NelsonColors.surface,
        onSurface: NelsonColors.textPrimary,
        error: NelsonColors.primaryRed,
        onError: NelsonColors.white,
        outline: NelsonColors.border,
      ),
      textTheme: GoogleFonts.interTextTheme(),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0.5,
        backgroundColor: NelsonColors.surface,
        foregroundColor: NelsonColors.textPrimary,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: NelsonColors.textPrimary,
        ),
        iconTheme: const IconThemeData(
          color: NelsonColors.textPrimary,
          size: 22,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: NelsonColors.surface,
        selectedItemColor: NelsonColors.primaryBlue,
        unselectedItemColor: NelsonColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: NelsonColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: NelsonColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: NelsonColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: NelsonColors.primaryBlue, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: NelsonColors.primaryRed),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: NelsonColors.primaryRed, width: 1.5),
        ),
        hintStyle: GoogleFonts.inter(
          fontSize: 14,
          color: NelsonColors.textTertiary,
        ),
        labelStyle: GoogleFonts.inter(
          fontSize: 14,
          color: NelsonColors.textSecondary,
        ),
        errorStyle: GoogleFonts.inter(
          fontSize: 12,
          color: NelsonColors.primaryRed,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: NelsonColors.primaryRed,
          foregroundColor: NelsonColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: NelsonColors.primaryBlue,
          side: const BorderSide(color: NelsonColors.border),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: NelsonColors.primaryBlue,
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: NelsonColors.blueSurface,
        labelStyle: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: NelsonColors.primaryBlue,
        ),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: NelsonColors.primaryBlue,
        unselectedLabelColor: NelsonColors.textTertiary,
        indicatorColor: NelsonColors.primaryBlue,
        labelStyle: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        indicatorSize: TabBarIndicatorSize.label,
      ),
      dividerTheme: const DividerThemeData(
        color: NelsonColors.divider,
        thickness: 1,
        space: 0,
      ),
      cardTheme: CardThemeData(
        color: NelsonColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: NelsonColors.border, width: 0.5),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: NelsonColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: NelsonColors.textPrimary,
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: NelsonColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        showDragHandle: true,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: NelsonColors.primaryRed,
        foregroundColor: NelsonColors.white,
        elevation: 2,
      ),
    );
  }
}

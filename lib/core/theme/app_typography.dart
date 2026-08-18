import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography system using Inter font.
class AppTypography {
  AppTypography._();

  // Screen title: 24-28px Semibold
  static TextStyle get screenTitle => GoogleFonts.inter(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: NelsonColors.black,
    height: 1.3,
  );

  static TextStyle get screenTitleSmall => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: NelsonColors.black,
    height: 1.3,
  );

  // Section: 18-20px Semibold
  static TextStyle get sectionTitle => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: NelsonColors.black,
    height: 1.4,
  );

  static TextStyle get sectionTitleLarge => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: NelsonColors.black,
    height: 1.4,
  );

  // Card: 15-17px Medium
  static TextStyle get cardTitle => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: NelsonColors.black,
    height: 1.4,
  );

  static TextStyle get cardTitleLarge => GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: NelsonColors.black,
    height: 1.4,
  );

  // Body: 14-16px
  static TextStyle get body => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: NelsonColors.black,
    height: 1.5,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: NelsonColors.black,
    height: 1.5,
  );

  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: NelsonColors.black,
    height: 1.5,
  );

  // Supporting: 12-14px
  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: NelsonColors.black,
    height: 1.4,
  );

  static TextStyle get captionMedium => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: NelsonColors.black,
    height: 1.4,
  );

  static TextStyle get label => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: NelsonColors.black,
    height: 1.4,
  );

  // Button text
  static TextStyle get buttonLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static TextStyle get buttonMedium => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static TextStyle get buttonSmall => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // KPI / Metrics
  static TextStyle get kpiValue => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: NelsonColors.textPrimary,
    height: 1,
  );

  static TextStyle get kpiLabel => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: NelsonColors.textSecondary,
    height: 1.3,
  );

  // Greeting
  static TextStyle get greeting => GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: NelsonColors.textPrimary,
    height: 1.3,
  );

  // Tab
  static TextStyle get tab => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  // Badge
  static TextStyle get badge => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
}

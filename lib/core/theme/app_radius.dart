import 'package:flutter/material.dart';

/// Border radius constants.
class AppRadius {
  AppRadius._();

  static const double xs = 4.0;
  static const double sm = 6.0;
  static const double md = 8.0;
  static const double lg = 12.0;
  static const double xl = 16.0;
  static const double xxl = 20.0;
  static const double full = 100.0;

  static BorderRadius get cardRadius => BorderRadius.circular(lg);
  static BorderRadius get buttonRadius => BorderRadius.circular(md);
  static BorderRadius get inputRadius => BorderRadius.circular(md);
  static BorderRadius get badgeRadius => BorderRadius.circular(sm);
  static BorderRadius get sheetRadius => const BorderRadius.vertical(
    top: Radius.circular(20),
  );
  static BorderRadius get chipRadius => BorderRadius.circular(full);
}

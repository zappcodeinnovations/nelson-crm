import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Shadow presets for elevation.
class AppShadows {
  AppShadows._();

  static List<BoxShadow> get sm => [
    BoxShadow(
      color: NelsonColors.dark.withValues(alpha: 0.04),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> get md => [
    BoxShadow(
      color: NelsonColors.dark.withValues(alpha: 0.06),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
    BoxShadow(
      color: NelsonColors.dark.withValues(alpha: 0.03),
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> get lg => [
    BoxShadow(
      color: NelsonColors.dark.withValues(alpha: 0.08),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: NelsonColors.dark.withValues(alpha: 0.03),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get card => [
    BoxShadow(
      color: NelsonColors.dark.withValues(alpha: 0.04),
      blurRadius: 6,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> get bottomNav => [
    BoxShadow(
      color: NelsonColors.dark.withValues(alpha: 0.08),
      blurRadius: 12,
      offset: const Offset(0, -2),
    ),
  ];
}

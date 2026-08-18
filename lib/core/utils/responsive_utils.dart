import 'package:flutter/material.dart';

class ResponsiveUtils {
  ResponsiveUtils._();

  // Breakpoints
  static const double tabletBreakpoint = 600;
  static const double desktopBreakpoint = 1024;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < tabletBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletBreakpoint &&
      MediaQuery.sizeOf(context).width < desktopBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= desktopBreakpoint;

  static bool isTabletOrLarger(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletBreakpoint;

  static int getGridCrossAxisCount(BuildContext context, {int mobile = 2, int tablet = 4, int desktop = 6}) {
    double width = MediaQuery.sizeOf(context).width;
    if (width >= desktopBreakpoint) return desktop;
    if (width >= tabletBreakpoint) return tablet;
    return mobile;
  }

  // Helper for responsive max width for center-aligned forms
  static double getMaxWidth(BuildContext context) {
    if (isDesktop(context)) return 800;
    if (isTablet(context)) return 600;
    return double.infinity;
  }
}

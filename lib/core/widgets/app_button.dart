import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_typography.dart';

/// Primary action button with loading state support.
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final bool isSmall;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final double? width;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.isSmall = false,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.width,
  });

  /// Red primary CTA button.
  factory AppButton.primary({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    double? width,
  }) {
    return AppButton(
      key: key,
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      backgroundColor: NelsonColors.primaryRed,
      textColor: NelsonColors.white,
      icon: icon,
      width: width,
    );
  }

  /// Blue secondary button.
  factory AppButton.secondary({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    double? width,
  }) {
    return AppButton(
      key: key,
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      backgroundColor: NelsonColors.primaryBlue,
      textColor: NelsonColors.white,
      icon: icon,
      width: width,
    );
  }

  /// Outlined button.
  factory AppButton.outline({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    double? width,
  }) {
    return AppButton(
      key: key,
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      isOutlined: true,
      icon: icon,
      width: width,
    );
  }

  /// Small action button.
  factory AppButton.small({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
  }) {
    return AppButton(
      key: key,
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      isSmall: true,
      backgroundColor: backgroundColor,
      textColor: textColor,
      icon: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? NelsonColors.primaryRed;
    final fgColor = textColor ?? NelsonColors.white;

    if (isOutlined) {
      return SizedBox(
        width: width,
        height: isSmall ? 36 : 48,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: bgColor,
            side: BorderSide(color: bgColor.withValues(alpha: 0.3)),
            shape: RoundedRectangleBorder(borderRadius: AppRadius.buttonRadius),
            padding: EdgeInsets.symmetric(
              horizontal: isSmall ? 12 : 20,
              vertical: isSmall ? 6 : 12,
            ),
          ),
          child: _buildChild(bgColor),
        ),
      );
    }

    return SizedBox(
      width: width,
      height: isSmall ? 36 : 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          disabledBackgroundColor: bgColor.withValues(alpha: 0.6),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.buttonRadius),
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 12 : 20,
            vertical: isSmall ? 6 : 12,
          ),
        ),
        child: _buildChild(fgColor),
      ),
    );
  }

  Widget _buildChild(Color color) {
    if (isLoading) {
      return SizedBox(
        width: isSmall ? 18 : 22,
        height: isSmall ? 18 : 22,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            isOutlined ? color : NelsonColors.white,
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: isSmall ? 16 : 18),
          SizedBox(width: isSmall ? 4 : 8),
          Text(
            label,
            style: isSmall ? AppTypography.buttonSmall : AppTypography.buttonMedium,
          ),
        ],
      );
    }

    return Text(
      label,
      style: isSmall ? AppTypography.buttonSmall : AppTypography.buttonMedium,
    );
  }
}

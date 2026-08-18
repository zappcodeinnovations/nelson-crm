import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Confirmation dialog helper.
class ConfirmDialog {
  static Future<bool> show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    Color? confirmColor,
    bool isDangerous = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: AppTypography.sectionTitle),
        content: Text(message, style: AppTypography.body.copyWith(color: NelsonColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              cancelLabel,
              style: AppTypography.buttonMedium.copyWith(color: NelsonColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmColor ??
                  (isDangerous ? NelsonColors.primaryRed : NelsonColors.primaryBlue),
              foregroundColor: NelsonColors.white,
              elevation: 0,
            ),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}

/// User avatar widget.
class UserAvatar extends StatelessWidget {
  final String name;
  final double size;
  final String? imageUrl;
  final Color? backgroundColor;

  const UserAvatar({
    super.key,
    required this.name,
    this.size = 40,
    this.imageUrl,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final initials = _getInitials(name);
    final bgColor = backgroundColor ?? NelsonColors.primaryBlue;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            fontSize: size * 0.36,
            fontWeight: FontWeight.w600,
            color: bgColor,
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}

/// Shift badge showing current shift info.
class ShiftBadge extends StatelessWidget {
  final String shiftName;
  final String time;
  final Color color;

  const ShiftBadge({
    super.key,
    required this.shiftName,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.access_time, size: 16, color: color),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                shiftName,
                style: AppTypography.captionMedium.copyWith(color: color),
              ),
              Text(
                time,
                style: AppTypography.caption.copyWith(color: color.withValues(alpha: 0.8), fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

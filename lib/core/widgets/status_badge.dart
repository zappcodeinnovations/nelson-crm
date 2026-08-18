import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/app_radius.dart';

/// Status badge for leads, appointments, etc.
class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  final bool showDot;

  const StatusBadge({
    super.key,
    required this.label,
    required this.color,
    this.showDot = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppRadius.chipRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: AppTypography.badge.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

/// Priority badge with color-coded severity.
class PriorityBadge extends StatelessWidget {
  final String label;
  final Color color;

  const PriorityBadge({
    super.key,
    required this.label,
    required this.color,
  });

  factory PriorityBadge.high() => const PriorityBadge(
    label: 'High',
    color: NelsonColors.priorityHigh,
  );

  factory PriorityBadge.medium() => const PriorityBadge(
    label: 'Medium',
    color: NelsonColors.priorityMedium,
  );

  factory PriorityBadge.low() => const PriorityBadge(
    label: 'Low',
    color: NelsonColors.priorityLow,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppRadius.chipRadius,
        border: Border.all(color: color.withValues(alpha: 0.3), width: 0.5),
      ),
      child: Text(
        label,
        style: AppTypography.badge.copyWith(color: color),
      ),
    );
  }
}

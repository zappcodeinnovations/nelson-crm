import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';

/// KPI metric card for dashboards.
class KpiCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? color;
  final VoidCallback? onTap;
  final String? subtitle;

  const KpiCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.color,
    this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? NelsonColors.primaryBlue;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: NelsonColors.surface,
          borderRadius: AppRadius.cardRadius,
          border: Border.all(color: NelsonColors.border, width: 0.5),
          boxShadow: AppShadows.card,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: cardColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 14, color: cardColor),
            ),
            const SizedBox(height: 12),
            Text(value, style: AppTypography.kpiValue),
            const SizedBox(height: 2),
            Text(label, style: AppTypography.kpiLabel),
            if (subtitle != null) ...[
              const SizedBox(height: 2),
              Text(
                subtitle!,
                style: AppTypography.caption.copyWith(
                  color: cardColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

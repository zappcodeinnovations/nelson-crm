import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/utils/snackbar_utils.dart';

/// Shift handover view showing pending tasks and transfer action.
class ShiftHandoverView extends StatelessWidget {
  const ShiftHandoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NelsonColors.background,
      appBar: AppBar(title: const Text('Shift Handover')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Shift Summary', style: AppTypography.sectionTitle),
            const SizedBox(height: 16),
            Row(
              children: [
                _SummaryCard(label: 'Completed', value: '8', color: NelsonColors.successGreen),
                const SizedBox(width: 12),
                _SummaryCard(label: 'Pending', value: '4', color: NelsonColors.primaryRed),
              ],
            ),
            const SizedBox(height: AppSpacing.sectionGap),
            Text('Pending Tasks', style: AppTypography.sectionTitle),
            const SizedBox(height: 12),
            _PendingTask(icon: Icons.event_note, label: '2 Follow-ups', color: NelsonColors.statusFollowUp),
            _PendingTask(icon: Icons.medical_services_outlined, label: '1 Doctor Assignment', color: NelsonColors.primaryBlue),
            _PendingTask(icon: Icons.check_circle_outline, label: '1 Appointment Confirmation', color: NelsonColors.successGreen),
            const Spacer(),
            AppButton.primary(
              label: 'HANDOVER PENDING TASKS',
              icon: Icons.swap_horiz,
              onPressed: () {
                SnackbarUtils.showSuccess('Tasks handed over to next shift.');
                Get.back();
              },
            ),
            const SizedBox(height: 12),
            AppButton.outline(label: 'CANCEL', onPressed: () => Get.back()),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label, value;
  final Color color;
  const _SummaryCard({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Text(value, style: AppTypography.kpiValue.copyWith(color: color)),
            const SizedBox(height: 4),
            Text(label, style: AppTypography.captionMedium.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}

class _PendingTask extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _PendingTask({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: NelsonColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: NelsonColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 12),
          Text(label, style: AppTypography.bodyMedium),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../../../data/models/lead_model.dart';

/// Doctor assignment confirmation.
class DoctorAssignmentView extends StatelessWidget {
  const DoctorAssignmentView({super.key});

  @override
  Widget build(BuildContext context) {
    final lead = Get.arguments?['lead'] as LeadModel?;
    final doctor = Get.arguments?['doctor'] as Map<String, dynamic>?;
    final slot = Get.arguments?['slot'] as String?;

    return Scaffold(
      backgroundColor: NelsonColors.background,
      appBar: AppBar(title: const Text('Confirm Assignment')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: NelsonColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: NelsonColors.border, width: 0.5),
              ),
              child: Column(
                children: [
                  Icon(Icons.medical_services, size: 48, color: NelsonColors.primaryBlue.withValues(alpha: 0.7)),
                  const SizedBox(height: 16),
                  _ConfirmRow(label: 'Patient', value: lead?.name ?? ''),
                  _ConfirmRow(label: 'Department', value: lead?.department?.label ?? doctor?['department'] as String? ?? ''),
                  _ConfirmRow(label: 'Doctor', value: doctor?['name'] as String? ?? ''),
                  _ConfirmRow(label: 'Branch', value: lead?.branch ?? 'Nelson Hospital - Dhantoli'),
                  _ConfirmRow(label: 'Date', value: '14 Aug'),
                  _ConfirmRow(label: 'Time', value: slot ?? ''),
                ],
              ),
            ),
            const Spacer(),
            AppButton.primary(
              label: 'ASSIGN & CONTINUE',
              width: double.infinity,
              icon: Icons.check,
              onPressed: () {
                SnackbarUtils.showSuccess('Doctor assigned successfully!');
                Get.back();
                Get.back();
                Get.back();
              },
            ),
            const SizedBox(height: 12),
            AppButton.outline(
              label: 'CANCEL',
              width: double.infinity,
              onPressed: () => Get.back(),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _ConfirmRow extends StatelessWidget {
  final String label;
  final String value;
  const _ConfirmRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label, style: AppTypography.caption)),
          Expanded(child: Text(value, style: AppTypography.bodyMedium, textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/utils/snackbar_utils.dart';

/// Appointment detail with actions.
class AppointmentDetailView extends StatelessWidget {
  const AppointmentDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final appt = Get.arguments?['appointment'] as Map<String, dynamic>?;

    return Scaffold(
      backgroundColor: NelsonColors.background,
      appBar: AppBar(title: const Text('Appointment Detail')),
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
                  _Row(label: 'Patient', value: appt?['patientName'] as String? ?? ''),
                  _Row(label: 'Doctor', value: appt?['doctor'] as String? ?? ''),
                  _Row(label: 'Department', value: appt?['department'] as String? ?? ''),
                  _Row(label: 'Date', value: '${appt?['day']} ${appt?['month']}'),
                  _Row(label: 'Time', value: appt?['time'] as String? ?? ''),
                  _Row(label: 'Status', value: appt?['status'] as String? ?? ''),
                  _Row(label: 'Branch', value: 'Nelson Hospital - Dhantoli'),
                ],
              ),
            ),
            const Spacer(),
            AppButton.primary(label: 'CONFIRM APPOINTMENT', width: double.infinity, onPressed: () {
              SnackbarUtils.showSuccess('Appointment confirmed!');
            }),
            const SizedBox(height: 10),
            AppButton.secondary(label: 'MARK ARRIVED', width: double.infinity, onPressed: () {
              SnackbarUtils.showSuccess('Patient marked as arrived.');
            }),
            const SizedBox(height: 10),
            AppButton.outline(label: 'RESCHEDULE', width: double.infinity, onPressed: () {}),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                SnackbarUtils.showWarning('Appointment cancelled.');
                Get.back();
              },
              child: Text('Cancel Appointment', style: AppTypography.bodyMedium.copyWith(color: NelsonColors.primaryRed)),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label, value;
  const _Row({required this.label, required this.value});
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

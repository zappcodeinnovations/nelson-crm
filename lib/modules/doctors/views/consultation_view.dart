import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';

/// Consultation screen for doctors.
class ConsultationView extends StatelessWidget {
  const ConsultationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NelsonColors.surface,
      appBar: AppBar(title: const Text('Consultation')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Patient summary
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: NelsonColors.blueSurface, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Patient: Amit Sharma', style: AppTypography.bodyMedium),
                  Text('Age: 35 • Male • Neurology', style: AppTypography.caption),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            const AppTextField(label: 'Chief Complaint', hint: 'Primary complaint...', maxLines: 2),
            const SizedBox(height: AppSpacing.lg),
            const AppTextField(label: 'Diagnosis', hint: 'Diagnosis...', maxLines: 2),
            const SizedBox(height: AppSpacing.lg),
            const AppTextField(label: 'Clinical Notes', hint: 'Clinical observations...', maxLines: 4),
            const SizedBox(height: AppSpacing.lg),
            const AppTextField(label: 'Prescription', hint: 'Medications...', maxLines: 3),
            const SizedBox(height: AppSpacing.lg),
            const AppTextField(label: 'Treatment Plan', hint: 'Treatment plan...', maxLines: 3),
            const SizedBox(height: AppSpacing.xxl),
            AppButton.primary(label: 'SAVE CONSULTATION', onPressed: () {}),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/utils/snackbar_utils.dart';

/// Book appointment form.
class BookAppointmentView extends StatelessWidget {
  const BookAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NelsonColors.surface,
      appBar: AppBar(title: const Text('Book Appointment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppTextField(label: 'Patient', hint: 'Patient name', prefixIcon: Icons.person_outline),
            const SizedBox(height: AppSpacing.lg),
            const AppTextField(label: 'Doctor', hint: 'Select doctor', prefixIcon: Icons.medical_services_outlined, readOnly: true, suffixIcon: Icons.keyboard_arrow_down),
            const SizedBox(height: AppSpacing.lg),
            const AppTextField(label: 'Department', hint: 'Select department', prefixIcon: Icons.local_hospital, readOnly: true, suffixIcon: Icons.keyboard_arrow_down),
            const SizedBox(height: AppSpacing.lg),
            const AppTextField(label: 'Date', hint: 'Select date', prefixIcon: Icons.calendar_today, readOnly: true, suffixIcon: Icons.keyboard_arrow_down),
            const SizedBox(height: AppSpacing.lg),
            const AppTextField(label: 'Time', hint: 'Select time', prefixIcon: Icons.access_time, readOnly: true, suffixIcon: Icons.keyboard_arrow_down),
            const SizedBox(height: AppSpacing.lg),
            const AppTextField(label: 'Notes', hint: 'Additional notes', maxLines: 2),
            const SizedBox(height: AppSpacing.xxl),
            AppButton.primary(label: 'BOOK APPOINTMENT', onPressed: () {
              SnackbarUtils.showSuccess('Appointment booked!');
              Get.back();
            }),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

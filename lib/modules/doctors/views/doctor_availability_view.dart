import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../../../routes/app_routes.dart';

/// Doctor availability with time slots.
class DoctorAvailabilityView extends StatelessWidget {
  const DoctorAvailabilityView({super.key});

  @override
  Widget build(BuildContext context) {
    final department = Get.arguments?['department'] as String? ?? 'NEUROLOGY';
    final lead = Get.arguments?['lead'];
    final selectedSlot = Rxn<String>();

    final doctors = [
      {'name': 'Dr. Amit Sharma', 'department': 'Neurology', 'time': '05:00 PM - 08:00 PM', 'status': 'Available', 'slots': ['05:00 PM', '05:30 PM', '06:00 PM', '06:30 PM', '07:00 PM', '07:30 PM']},
      {'name': 'Dr. Priya Nair', 'department': 'Neurology', 'time': '10:00 AM - 02:00 PM', 'status': 'Busy', 'slots': <String>[]},
      {'name': 'Dr. Rajiv Kumar', 'department': 'Neurology', 'time': 'On Leave', 'status': 'On Leave', 'slots': <String>[]},
    ];

    final selectedDoctor = Rxn<Map<String, dynamic>>();

    return Scaffold(
      backgroundColor: NelsonColors.background,
      appBar: AppBar(title: const Text('Doctor Availability')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
        children: [
          Text('Today', style: AppTypography.sectionTitle),
          const SizedBox(height: 12),

          ...doctors.map((doc) {
            final isAvailable = doc['status'] == 'Available';
            return Obx(() => GestureDetector(
              onTap: isAvailable ? () => selectedDoctor.value = doc : null,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: NelsonColors.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: selectedDoctor.value == doc ? NelsonColors.primaryBlue : NelsonColors.border,
                    width: selectedDoctor.value == doc ? 1.5 : 0.5,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isAvailable ? NelsonColors.successGreen : NelsonColors.textTertiary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(doc['name'] as String, style: AppTypography.bodyMedium),
                          Text(doc['department'] as String, style: AppTypography.caption),
                          Text(doc['time'] as String, style: AppTypography.caption.copyWith(
                            color: isAvailable ? NelsonColors.successGreen : NelsonColors.textTertiary,
                          )),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: (isAvailable ? NelsonColors.successGreen : NelsonColors.textTertiary).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(width: 6, height: 6, decoration: BoxDecoration(color: isAvailable ? NelsonColors.successGreen : NelsonColors.textTertiary, shape: BoxShape.circle)),
                          const SizedBox(width: 4),
                          Text(doc['status'] as String, style: AppTypography.badge.copyWith(color: isAvailable ? NelsonColors.successGreen : NelsonColors.textTertiary)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
          }),

          const SizedBox(height: 20),

          // Slot selection
          Obx(() {
            final doc = selectedDoctor.value;
            if (doc == null) return const SizedBox.shrink();
            final slots = doc['slots'] as List<String>;
            if (slots.isEmpty) return const SizedBox.shrink();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Available Slots', style: AppTypography.sectionTitle),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: slots.map((slot) => Obx(() => ChoiceChip(
                    label: Text(slot),
                    selected: selectedSlot.value == slot,
                    onSelected: (_) => selectedSlot.value = slot,
                    selectedColor: NelsonColors.primaryBlue,
                    labelStyle: TextStyle(color: selectedSlot.value == slot ? NelsonColors.white : NelsonColors.textPrimary, fontSize: 13),
                    side: BorderSide(color: selectedSlot.value == slot ? NelsonColors.primaryBlue : NelsonColors.border),
                  ))).toList(),
                ),
                const SizedBox(height: 24),
                AppButton.primary(
                  label: 'ASSIGN & CONTINUE',
                  width: double.infinity,
                  onPressed: selectedSlot.value != null ? () {
                    Get.toNamed(AppRoutes.doctorAssignment, arguments: {
                      'lead': lead,
                      'doctor': doc,
                      'slot': selectedSlot.value,
                    });
                  } : null,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

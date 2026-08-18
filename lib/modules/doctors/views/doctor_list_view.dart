import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/loading_states.dart';
import '../../../core/widgets/status_badge.dart';
import '../controllers/doctor_controller.dart';

/// Doctor list view filtered by department.
class DoctorListView extends StatelessWidget {
  const DoctorListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorListController());

    return Scaffold(
      backgroundColor: NelsonColors.background,
      appBar: AppBar(title: const Text('Doctors')),
      body: Obx(() {
        if (controller.isLoading.value) return const LoadingState();
        if (controller.doctors.isEmpty) {
          return const EmptyState(icon: Icons.medical_services_outlined, title: 'No doctors found');
        }
        return ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
          itemCount: controller.doctors.length,
          itemBuilder: (_, index) {
            final doc = controller.doctors[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: NelsonColors.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: NelsonColors.border, width: 0.5),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: NelsonColors.primaryBlue.withValues(alpha: 0.1),
                    child: Text(
                      (doc['name'] as String).split(' ').last[0],
                      style: TextStyle(color: NelsonColors.primaryBlue, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(doc['name'] as String, style: AppTypography.bodyMedium),
                        Text(doc['department'] as String, style: AppTypography.caption),
                        Text(doc['schedule'] as String, style: AppTypography.caption.copyWith(fontSize: 11)),
                      ],
                    ),
                  ),
                  StatusBadge(
                    label: doc['availability'] as String,
                    color: doc['availability'] == 'Available' ? NelsonColors.successGreen : NelsonColors.statusNoResponse,
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}

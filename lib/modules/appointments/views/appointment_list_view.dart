import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/loading_states.dart';
import '../../../core/widgets/status_badge.dart';
import '../controllers/appointment_controller.dart';

/// Appointment list view.
class AppointmentListView extends StatelessWidget {
  const AppointmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppointmentListController());

    return Scaffold(
      backgroundColor: NelsonColors.background,
      appBar: AppBar(title: const Text('Appointments')),
      body: Obx(() {
        if (controller.isLoading.value) return const LoadingState();
        if (controller.appointments.isEmpty) {
          return const EmptyState(icon: Icons.calendar_today_outlined, title: 'No appointments');
        }
        return RefreshIndicator(
          onRefresh: () async { await controller.load(); },
          child: ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
            itemCount: controller.appointments.length,
            itemBuilder: (_, index) {
              final appt = controller.appointments[index];
              return GestureDetector(
                onTap: () => Get.toNamed('/appointments/detail', arguments: {'appointment': appt}),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: NelsonColors.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: NelsonColors.border, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48, height: 48,
                        decoration: BoxDecoration(
                          color: NelsonColors.primaryBlue.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(appt['day'] as String, style: AppTypography.bodyMedium.copyWith(color: NelsonColors.primaryBlue, fontWeight: FontWeight.w700)),
                            Text(appt['month'] as String, style: AppTypography.badge.copyWith(color: NelsonColors.primaryBlue)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(appt['patientName'] as String, style: AppTypography.bodyMedium),
                            Text('${appt['doctor']} • ${appt['department']}', style: AppTypography.caption),
                            Text(appt['time'] as String, style: AppTypography.caption.copyWith(color: NelsonColors.primaryBlue)),
                          ],
                        ),
                      ),
                      StatusBadge(
                        label: appt['status'] as String,
                        color: appt['status'] == 'Confirmed' ? NelsonColors.successGreen
                            : appt['status'] == 'Scheduled' ? NelsonColors.primaryBlue
                            : NelsonColors.statusNoResponse,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

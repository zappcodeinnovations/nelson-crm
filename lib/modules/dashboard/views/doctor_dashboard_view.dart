import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/kpi_card.dart';
import '../../auth/controllers/auth_controller.dart';

/// Doctor-specific dashboard.
class DoctorDashboardView extends StatelessWidget {
  const DoctorDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Get.find<AuthController>().currentUser.value;

    return Scaffold(
      backgroundColor: NelsonColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user?.name ?? 'Doctor', style: AppTypography.greeting),
            Text(user?.department ?? 'Department', style: AppTypography.caption),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
        children: [
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              KpiCard(
                label: "Today's Appts.",
                value: '8',
                icon: Icons.calendar_today,
                color: NelsonColors.primaryBlue,
              ),
              KpiCard(
                label: 'Patients Waiting',
                value: '3',
                icon: Icons.people_outline,
                color: NelsonColors.statusFollowUp,
              ),
              KpiCard(
                label: 'Completed',
                value: '4',
                icon: Icons.check_circle_outline,
                color: NelsonColors.successGreen,
              ),
              KpiCard(
                label: 'Follow-ups',
                value: '2',
                icon: Icons.event_note_outlined,
                color: NelsonColors.statusAssigned,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sectionGap),

          Text('Upcoming Patients', style: AppTypography.sectionTitle),
          const SizedBox(height: AppSpacing.md),

          _PatientItem(name: 'Amit Sharma', time: '05:00 PM', department: 'Neurology', type: 'Consultation'),
          _PatientItem(name: 'Meera Patel', time: '05:30 PM', department: 'Neurology', type: 'Follow-up'),
          _PatientItem(name: 'Raj Kumar', time: '06:00 PM', department: 'Neurology', type: 'Treatment Review'),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _PatientItem extends StatelessWidget {
  final String name;
  final String time;
  final String department;
  final String type;

  const _PatientItem({
    required this.name,
    required this.time,
    required this.department,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
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
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: NelsonColors.primaryBlue,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTypography.bodyMedium),
                const SizedBox(height: 2),
                Text(type, style: AppTypography.caption),
              ],
            ),
          ),
          Text(time, style: AppTypography.captionMedium.copyWith(color: NelsonColors.primaryBlue)),
        ],
      ),
    );
  }
}

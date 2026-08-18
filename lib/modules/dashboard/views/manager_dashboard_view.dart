import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/loading_states.dart';
import '../controllers/dashboard_controller.dart';
import '../../auth/controllers/auth_controller.dart';

/// Manager/Marketing dashboard with lead analytics.
class ManagerDashboardView extends StatelessWidget {
  const ManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    final user = Get.find<AuthController>().currentUser.value;

    return Scaffold(
      backgroundColor: NelsonColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${controller.greeting.value}, ${controller.userName.value}', style: AppTypography.greeting),
            Text(user?.role.label ?? '', style: AppTypography.caption),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) return const LoadingState();

        return RefreshIndicator(
          onRefresh: controller.refresh,
          color: NelsonColors.primaryBlue,
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
            children: [
              // Today's Leads header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: NelsonColors.primaryBlue,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    Text("Today's Leads", style: AppTypography.label.copyWith(color: NelsonColors.white.withValues(alpha: 0.8))),
                    const SizedBox(height: 4),
                    Text('${controller.totalLeadsToday.value}', style: AppTypography.kpiValue.copyWith(color: NelsonColors.white, fontSize: 40)),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sectionGap),

              // Department breakdown
              Text('By Department', style: AppTypography.sectionTitle),
              const SizedBox(height: AppSpacing.md),
              ...controller.departmentStats.map((dept) => _StatBar(
                label: dept['name'] as String,
                count: dept['count'] as int,
                percentage: dept['percentage'] as double,
                color: NelsonColors.primaryBlue,
              )),

              const SizedBox(height: AppSpacing.sectionGap),

              // Source breakdown
              Text('By Source', style: AppTypography.sectionTitle),
              const SizedBox(height: AppSpacing.md),
              ...controller.sourceStats.map((src) => _StatBar(
                label: src['name'] as String,
                count: src['count'] as int,
                percentage: src['percentage'] as double,
                color: NelsonColors.primaryRed,
              )),

              const SizedBox(height: AppSpacing.sectionGap),

              // Staff workload
              Text('Staff Workload', style: AppTypography.sectionTitle),
              const SizedBox(height: AppSpacing.md),
              ...controller.staffWorkload.map((staff) => _StatBar(
                label: staff['name'] as String,
                count: staff['count'] as int,
                percentage: ((staff['count'] as int) / 20 * 100),
                color: NelsonColors.statusAssigned,
              )),

              const SizedBox(height: 32),
            ],
          ),
        );
      }),
    );
  }
}

class _StatBar extends StatelessWidget {
  final String label;
  final int count;
  final double percentage;
  final Color color;

  const _StatBar({
    required this.label,
    required this.count,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: AppTypography.bodyMedium),
              Text('$count', style: AppTypography.bodyMedium.copyWith(color: color)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: NelsonColors.border,
              valueColor: AlwaysStoppedAnimation(color.withValues(alpha: 0.7)),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}

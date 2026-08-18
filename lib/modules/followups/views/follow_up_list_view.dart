import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/loading_states.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/utils/date_utils.dart';
import '../controllers/follow_up_controller.dart';

/// Follow-up list with Today, Upcoming, Overdue, Completed tabs.
class FollowUpListView extends StatelessWidget {
  const FollowUpListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FollowUpController());

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: NelsonColors.background,
        appBar: AppBar(
          title: const Text('Follow-ups'),
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Today'),
              Tab(text: 'Upcoming'),
              Tab(text: 'Overdue'),
              Tab(text: 'Completed'),
            ],
            labelColor: NelsonColors.primaryBlue,
            unselectedLabelColor: NelsonColors.textTertiary,
            indicatorColor: NelsonColors.primaryBlue,
            labelStyle: AppTypography.tab,
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) return const LoadingState();

          return TabBarView(
            children: [
              _FollowUpTab(items: controller.todayFollowUps),
              _FollowUpTab(items: controller.upcomingFollowUps),
              _FollowUpTab(items: controller.overdueFollowUps),
              _FollowUpTab(items: controller.completedFollowUps),
            ],
          );
        }),
      ),
    );
  }
}

class _FollowUpTab extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  const _FollowUpTab({required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const EmptyState(
        icon: Icons.event_note_outlined,
        title: 'No follow-ups',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        final isOverdue = item['isOverdue'] as bool? ?? false;

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: NelsonColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isOverdue ? NelsonColors.primaryRed.withValues(alpha: 0.3) : NelsonColors.border,
              width: 0.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (isOverdue ? NelsonColors.primaryRed : NelsonColors.primaryBlue).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isOverdue ? Icons.warning_amber : Icons.event_note,
                  size: 18,
                  color: isOverdue ? NelsonColors.primaryRed : NelsonColors.primaryBlue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['patientName'] as String, style: AppTypography.bodyMedium),
                    const SizedBox(height: 2),
                    Text(item['department'] as String, style: AppTypography.caption),
                    Text(item['type'] as String, style: AppTypography.caption),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    item['time'] as String,
                    style: AppTypography.captionMedium.copyWith(
                      color: isOverdue ? NelsonColors.primaryRed : NelsonColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  StatusBadge(
                    label: isOverdue ? 'Overdue' : (item['status'] as String),
                    color: isOverdue ? NelsonColors.primaryRed : NelsonColors.successGreen,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

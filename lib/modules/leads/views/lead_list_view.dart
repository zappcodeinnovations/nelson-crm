import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_search_bar.dart';
import '../../../core/widgets/loading_states.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/utils/date_utils.dart';
import '../../../routes/app_routes.dart';
import '../controllers/lead_controller.dart';
import '../../../data/models/lead_model.dart';

/// Lead list with tabs, search, and filters.
class LeadListView extends StatelessWidget {
  const LeadListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeadListController());

    return Scaffold(
      backgroundColor: NelsonColors.background,
      appBar: AppBar(
        title: const Text('Leads'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => Get.toNamed(AppRoutes.notifications),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.addLead),
        icon: const Icon(Icons.add, size: 20),
        label: const Text('ADD LEAD'),
        backgroundColor: NelsonColors.primaryRed,
        foregroundColor: NelsonColors.white,
      ),
      body: Column(
        children: [
          // Search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal, vertical: 8),
            child: AppSearchBar(
              hint: 'Search name, phone, ID...',
              showFilter: true,
              onChanged: controller.onSearchChanged,
              onFilterTap: () {
                // TODO: Show filter bottom sheet
              },
            ),
          ),

          // Status tabs
          SizedBox(
            height: 38,
            child: Obx(() {
              final currentStatus = controller.selectedStatus.value;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal),
                itemCount: controller.tabLabels.length,
                itemBuilder: (_, index) {
                  final isSelected = currentStatus == controller.statusTabs[index];
                  return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(controller.tabLabels[index]),
                    selected: isSelected,
                    onSelected: (_) => controller.onStatusChanged(controller.statusTabs[index]),
                    selectedColor: NelsonColors.primaryBlue,
                    backgroundColor: NelsonColors.surface,
                    labelStyle: AppTypography.tab.copyWith(
                      color: isSelected ? NelsonColors.white : NelsonColors.textSecondary,
                    ),
                    side: BorderSide(
                      color: isSelected ? NelsonColors.primaryBlue : NelsonColors.border,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    visualDensity: VisualDensity.compact,
                  ),
                );
              },
            );
            }),
          ),
          const SizedBox(height: 8),

          // Lead list
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) return const LoadingState();
              if (controller.leads.isEmpty) {
                return const EmptyState(
                  icon: Icons.people_outline,
                  title: 'No leads found',
                  subtitle: 'Tap + to add a new lead',
                );
              }

              return RefreshIndicator(
                onRefresh: controller.refresh,
                color: NelsonColors.primaryBlue,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollEndNotification &&
                        notification.metrics.extentAfter < 200) {
                      controller.loadMore();
                    }
                    return false;
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal),
                    itemCount: controller.leads.length + (controller.isLoadingMore.value ? 1 : 0),
                    itemBuilder: (_, index) {
                      if (index == controller.leads.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                        );
                      }
                      return _LeadCard(lead: controller.leads[index]);
                    },
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _LeadCard extends StatelessWidget {
  final LeadModel lead;
  const _LeadCard({required this.lead});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.leadDetail, arguments: {'lead': lead}),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: NelsonColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: NelsonColors.border, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(lead.name, style: AppTypography.cardTitle),
                ),
                StatusBadge(label: lead.status.label, color: lead.status.color),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                if (lead.department != null) ...[
                  Icon(Icons.local_hospital, size: 13, color: lead.department!.color),
                  const SizedBox(width: 4),
                  Text(lead.department!.label, style: AppTypography.caption.copyWith(color: lead.department!.color)),
                  const SizedBox(width: 12),
                ],
                Icon(lead.source.icon, size: 13, color: NelsonColors.textTertiary),
                const SizedBox(width: 4),
                Text(lead.source.label, style: AppTypography.caption),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              lead.requirement,
              style: AppTypography.caption,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  AppDateUtils.timeAgo(lead.createdAt),
                  style: AppTypography.caption.copyWith(fontSize: 11),
                ),
                const Spacer(),
                // Quick actions
                _QuickActionIcon(
                  icon: Icons.phone,
                  color: NelsonColors.primaryRed,
                  onTap: () => Get.toNamed(AppRoutes.callOutcome, arguments: {'lead': lead}),
                ),
                const SizedBox(width: 12),
                _QuickActionIcon(
                  icon: Icons.chat_outlined,
                  color: NelsonColors.successGreen,
                  onTap: () {},
                ),
                const SizedBox(width: 12),
                _QuickActionIcon(
                  icon: Icons.event_note_outlined,
                  color: NelsonColors.primaryBlue,
                  onTap: () => Get.toNamed(AppRoutes.scheduleFollowUp, arguments: {'lead': lead}),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionIcon({required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16, color: color),
      ),
    );
  }
}

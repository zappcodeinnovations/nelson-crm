import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/kpi_card.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../core/widgets/loading_states.dart';
import '../../../routes/app_routes.dart';
import '../../auth/controllers/auth_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../../../core/utils/responsive_utils.dart';

/// CRM Staff dashboard - home screen.
class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    final authController = Get.find<AuthController>();
    final user = authController.currentUser.value;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 59, 193),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingState();
        }

        return RefreshIndicator(
          onRefresh: controller.refresh,
          color: NelsonColors.primaryBlue,
          child: CustomScrollView(
            slivers: [
              // App bar
              SliverAppBar(
                floating: true,
                snap: true,
                automaticallyImplyLeading: false,
                backgroundColor: NelsonColors.surface,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${controller.greeting.value}, ${controller.userName.value}',
                      style: AppTypography.greeting,
                    ),
                    const SizedBox(height: 2),
                    Text(user?.role.label ?? '', style: AppTypography.caption),
                  ],
                ),
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: NelsonColors.textPrimary,
                    ),
                    onPressed: () => Get.toNamed(AppRoutes.notifications),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.profile),
                      child: UserAvatar(name: user?.name ?? 'U', size: 34),
                    ),
                  ),
                ],
                // bottom: PreferredSize(
                //   preferredSize: const Size.fromHeight(48),
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal, vertical: 8),
                //     child: ShiftBadge(
                //       shiftName: user?.shiftName ?? 'Morning Shift',
                //       time: '08:00 AM - 04:00 PM',
                //       color: NelsonColors.shiftMorning,
                //     ),
                //   ),
                // ),
              ),

              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // My Work section
                    // Text('My Work', style: AppTypography.sectionTitle),
                    // const SizedBox(height: AppSpacing.md),

                    // Follow up slider banner
                    const _FollowUpBanner(),
                    const SizedBox(height: AppSpacing.md),
                    GridView.count(
                      crossAxisCount: ResponsiveUtils.getGridCrossAxisCount(context, tablet: 3, desktop: 4),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: ResponsiveUtils.isTabletOrLarger(context) ? 1.8 : 1.5,
                      children: [
                        KpiCard(
                          label: 'New Leads',
                          value: '${controller.newLeadsCount.value}',
                          icon: Icons.person_add_outlined,
                          color: NelsonColors.statusNew,
                          onTap: () => Get.toNamed(AppRoutes.leads),
                        ),
                        KpiCard(
                          label: 'Calls Pending',
                          value: '${controller.callsPendingCount.value}',
                          icon: Icons.phone_outlined,
                          color: NelsonColors.primaryRed,
                          onTap: () => Get.toNamed(AppRoutes.leads),
                        ),
                        KpiCard(
                          label: 'Follow-ups',
                          value: '${controller.followUpsCount.value}',
                          icon: Icons.event_note_outlined,
                          color: NelsonColors.statusFollowUp,
                          onTap: () => Get.toNamed(AppRoutes.followUps),
                        ),
                        KpiCard(
                          label: 'Overdue',
                          value: '${controller.overdueCount.value}',
                          icon: Icons.warning_amber_outlined,
                          color: NelsonColors.primaryRed,
                          subtitle: 'Action required',
                          onTap: () => Get.toNamed(AppRoutes.followUps),
                        ),
                        KpiCard(
                          label: 'Doctor Assign.',
                          value: '${controller.doctorAssignmentsCount.value}',
                          icon: Icons.medical_services_outlined,
                          color: NelsonColors.primaryBlue,
                          onTap: () => Get.toNamed(AppRoutes.doctors),
                        ),
                        KpiCard(
                          label: 'Appointments',
                          value: '${controller.appointmentsCount.value}',
                          icon: Icons.calendar_today_outlined,
                          color: NelsonColors.successGreen,
                          onTap: () => Get.toNamed(AppRoutes.appointments),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.sectionGap),

                    // Today's priorities
                    _SectionRow(
                      title: "Today's Priorities",
                      actionLabel: 'View All',
                      onAction: () => Get.toNamed(AppRoutes.leads),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _PriorityItem(
                      title: 'Call Meera Patel',
                      subtitle: 'Gynecology • Follow-up overdue',
                      icon: Icons.phone,
                      color: NelsonColors.primaryRed,
                      time: '10:30 AM',
                    ),
                    _PriorityItem(
                      title: 'Assign Dr. Sharma',
                      subtitle: 'Neurology • Amit Sharma',
                      icon: Icons.medical_services_outlined,
                      color: NelsonColors.primaryBlue,
                      time: '',
                    ),
                    _PriorityItem(
                      title: 'Confirm appointment',
                      subtitle: 'Orthopedics • Raj Kumar',
                      icon: Icons.check_circle_outline,
                      color: NelsonColors.successGreen,
                      time: '02:00 PM',
                    ),

                    const SizedBox(height: AppSpacing.sectionGap),

                    // Quick actions
                    Text('Quick Actions', style: AppTypography.sectionTitle),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        _QuickAction(
                          icon: Icons.person_add,
                          label: 'Add Lead',
                          color: NelsonColors.primaryRed,
                          onTap: () => Get.toNamed(AppRoutes.addLead),
                        ),
                        const SizedBox(width: 12),
                        _QuickAction(
                          icon: Icons.chat,
                          label: 'WhatsApp Lead',
                          color: NelsonColors.successGreen,
                          onTap: () => Get.toNamed(AppRoutes.whatsappLead),
                        ),
                        const SizedBox(width: 12),
                        _QuickAction(
                          icon: Icons.calendar_today,
                          label: 'Book Appt.',
                          color: NelsonColors.primaryBlue,
                          onTap: () => Get.toNamed(AppRoutes.bookAppointment),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),
                  ]),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _SectionRow extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  const _SectionRow({required this.title, this.actionLabel, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTypography.sectionTitle),
        if (actionLabel != null)
          TextButton(
            onPressed: onAction,
            child: Text(
              actionLabel!,
              style: AppTypography.bodyMedium.copyWith(
                color: NelsonColors.primaryBlue,
              ),
            ),
          ),
      ],
    );
  }
}

class _PriorityItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String time;

  const _PriorityItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.time,
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
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.bodyMedium),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTypography.caption),
              ],
            ),
          ),
          if (time.isNotEmpty)
            Text(
              time,
              style: AppTypography.captionMedium.copyWith(color: color),
            ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withValues(alpha: 0.15)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(height: 6),
              Text(
                label,
                style: AppTypography.captionMedium.copyWith(color: color),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FollowUpBanner extends StatefulWidget {
  const _FollowUpBanner();

  @override
  State<_FollowUpBanner> createState() => _FollowUpBannerState();
}

class _FollowUpBannerState extends State<_FollowUpBanner> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  Timer? _timer;

  final List<Map<String, String>> _followUps = [
    {
      'name': 'Meera Patel',
      'dept': 'Gynecology',
    },
    {
      'name': 'Rahul Sharma',
      'dept': 'Cardiology',
    },
    {
      'name': 'Anita Desai',
      'dept': 'Orthopedics',
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_pageController.hasClients) {
        int next = _pageController.page!.round() + 1;
        if (next >= _followUps.length) {
          next = 0;
          _pageController.animateToPage(next, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
        } else {
          _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _followUps.length,
        itemBuilder: (context, index) {
          final followUp = _followUps[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: NelsonColors.primaryBlue.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: NelsonColors.primaryBlue.withValues(alpha: 0.2)),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 10,
                  bottom: 10,
                  top: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/dr-nelsa2.gif',
                      fit: BoxFit.contain,
                      width: 90,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0, right: 110.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: NelsonColors.primaryBlue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Priority Action',
                          style: AppTypography.label.copyWith(color: NelsonColors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Call ${followUp['name']} today!',
                        style: AppTypography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${followUp['dept']} • Follow-up overdue',
                        style: AppTypography.caption.copyWith(
                          color: NelsonColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../routes/app_routes.dart';
import '../../auth/controllers/auth_controller.dart';

/// More menu screen with additional navigation options.
class MoreMenuView extends StatelessWidget {
  const MoreMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final user = authController.currentUser.value;

    return Scaffold(
      backgroundColor: NelsonColors.background,
      appBar: AppBar(
        title: const Text('More'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // User card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: NelsonColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: NelsonColors.border, width: 0.5),
            ),
            child: Row(
              children: [
                UserAvatar(name: user?.name ?? 'User', size: 48),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user?.name ?? 'Staff', style: AppTypography.cardTitle),
                      const SizedBox(height: 2),
                      Text(user?.role.label ?? '', style: AppTypography.caption),
                      Text(user?.branch ?? '', style: AppTypography.caption),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: NelsonColors.textTertiary),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          _SectionHeader(title: 'Management'),
          _MenuItem(icon: Icons.people_outline, label: 'Leads', onTap: () => Get.toNamed(AppRoutes.leads)),
          _MenuItem(icon: Icons.event_note_outlined, label: 'Follow-ups', onTap: () => Get.toNamed(AppRoutes.followUps)),
          _MenuItem(icon: Icons.local_hospital_outlined, label: 'Doctors', onTap: () => Get.toNamed(AppRoutes.doctors)),
          _MenuItem(icon: Icons.calendar_today_outlined, label: 'Appointments', onTap: () => Get.toNamed(AppRoutes.appointments)),
          _MenuItem(icon: Icons.person_outline, label: 'Patients', onTap: () => Get.toNamed(AppRoutes.patients)),

          const SizedBox(height: AppSpacing.lg),
          _SectionHeader(title: 'Tools'),
          _MenuItem(icon: Icons.notifications_outlined, label: 'Notifications', onTap: () => Get.toNamed(AppRoutes.notifications)),
          _MenuItem(icon: Icons.swap_horiz, label: 'Shift Handover', onTap: () => Get.toNamed(AppRoutes.shiftHandover)),
          _MenuItem(icon: Icons.analytics_outlined, label: 'Analytics', onTap: () => Get.toNamed(AppRoutes.analytics)),

          const SizedBox(height: AppSpacing.lg),
          _SectionHeader(title: 'Account'),
          _MenuItem(icon: Icons.person_outline, label: 'Profile', onTap: () => Get.toNamed(AppRoutes.profile)),
          _MenuItem(
            icon: Icons.logout,
            label: 'Logout',
            color: NelsonColors.primaryRed,
            onTap: () async {
              final confirm = await ConfirmDialog.show(
                context: context,
                title: 'Logout',
                message: 'Are you sure you want to logout?',
                confirmLabel: 'Logout',
                isDangerous: true,
              );
              if (confirm) authController.logout();
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(title, style: AppTypography.captionMedium.copyWith(
        color: NelsonColors.textTertiary,
        letterSpacing: 0.5,
      )),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _MenuItem({required this.icon, required this.label, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    final itemColor = color ?? NelsonColors.textPrimary;
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, size: 22, color: itemColor),
        title: Text(label, style: AppTypography.body.copyWith(color: itemColor)),
        trailing: Icon(Icons.chevron_right, size: 20, color: NelsonColors.textTertiary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      ),
    );
  }
}

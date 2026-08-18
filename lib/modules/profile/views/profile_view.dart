import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../auth/controllers/auth_controller.dart';

/// Profile view.
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Get.find<AuthController>().currentUser.value;

    return Scaffold(
      backgroundColor: NelsonColors.background,
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
        children: [
          const SizedBox(height: 16),
          Center(child: UserAvatar(name: user?.name ?? 'User', size: 80)),
          const SizedBox(height: 16),
          Center(child: Text(user?.name ?? '', style: AppTypography.sectionTitleLarge)),
          Center(child: Text(user?.role.label ?? '', style: AppTypography.caption)),
          const SizedBox(height: 32),
          _ProfileItem(label: 'Employee ID', value: user?.id ?? ''),
          _ProfileItem(label: 'Phone', value: user?.phone ?? ''),
          _ProfileItem(label: 'Email', value: user?.email ?? 'Not provided'),
          _ProfileItem(label: 'Branch', value: user?.branch ?? ''),
          _ProfileItem(label: 'Department', value: user?.department ?? 'General'),
          _ProfileItem(label: 'Shift', value: user?.shiftName ?? 'Morning'),
          _ProfileItem(label: 'Role', value: user?.role.label ?? ''),
        ],
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final String label, value;
  const _ProfileItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: NelsonColors.divider))),
      child: Row(
        children: [
          SizedBox(width: 110, child: Text(label, style: AppTypography.caption)),
          Expanded(child: Text(value, style: AppTypography.body)),
        ],
      ),
    );
  }
}

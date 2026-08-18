import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../controllers/shell_controller.dart';
import '../../../data/models/enums/user_role.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../dashboard/views/manager_dashboard_view.dart';
import '../../dashboard/views/doctor_dashboard_view.dart';
import '../../leads/views/lead_list_view.dart';
import '../../followups/views/follow_up_list_view.dart';
import '../../appointments/views/appointment_list_view.dart';
import '../../patients/views/patient_list_view.dart';
import '../../analytics/views/analytics_view.dart';
import '../views/more_menu_view.dart';
import '../../../core/utils/responsive_utils.dart';

/// Main shell with role-based bottom navigation.
class MainShellView extends GetView<ShellController> {
  const MainShellView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final items = controller.navItems;
      final pages = _getPagesForRole(controller.userRole);

      final isTablet = ResponsiveUtils.isTabletOrLarger(context);

      return Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              if (isTablet)
                NavigationRail(
                  selectedIndex: controller.currentIndex.value,
                  onDestinationSelected: controller.changeTab,
                  labelType: NavigationRailLabelType.all,
                  selectedIconTheme: const IconThemeData(color: NelsonColors.primaryBlue),
                  selectedLabelTextStyle: const TextStyle(color: NelsonColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 12),
                  unselectedIconTheme: const IconThemeData(color: NelsonColors.textTertiary),
                  unselectedLabelTextStyle: const TextStyle(color: NelsonColors.textTertiary, fontSize: 12),
                  destinations: items.map((item) {
                    return NavigationRailDestination(
                      icon: Icon(item.icon),
                      selectedIcon: Icon(item.activeIcon),
                      label: Text(item.label),
                    );
                  }).toList(),
                ),
              if (isTablet)
                const VerticalDivider(thickness: 1, width: 1),
              Expanded(
                child: IndexedStack(
                  index: controller.currentIndex.value,
                  children: pages,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: isTablet
            ? null
            : Container(
                decoration: BoxDecoration(
                  color: NelsonColors.surface,
                  boxShadow: AppShadows.bottomNav,
                ),
                child: SafeArea(
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(items.length, (index) {
                        final item = items[index];
                        final isActive = controller.currentIndex.value == index;
                        return _NavBarItem(
                          icon: isActive ? item.activeIcon : item.icon,
                          label: item.label,
                          isActive: isActive,
                          onTap: () => controller.changeTab(index),
                        );
                      }),
                    ),
                  ),
                ),
              ),
      );
    });
  }

  List<Widget> _getPagesForRole(UserRole role) {
    switch (role) {
      case UserRole.crmExecutive:
        return const [
          DashboardView(),
          LeadListView(),
          FollowUpListView(),
          AppointmentListView(),
          MoreMenuView(),
        ];
      case UserRole.receptionist:
        return const [
          DashboardView(),
          AppointmentListView(),
          PatientListView(),
          FollowUpListView(),
          MoreMenuView(),
        ];
      case UserRole.doctor:
        return const [
          DoctorDashboardView(),
          AppointmentListView(),
          PatientListView(),
          MoreMenuView(),
        ];
      case UserRole.marketing:
        return const [
          ManagerDashboardView(),
          LeadListView(),
          AnalyticsView(),
          MoreMenuView(),
        ];
      case UserRole.branchManager:
        return const [
          ManagerDashboardView(),
          LeadListView(),
          AppointmentListView(),
          AnalyticsView(),
          MoreMenuView(),
        ];
      case UserRole.admin:
        return const [
          ManagerDashboardView(),
          LeadListView(),
          PatientListView(),
          AppointmentListView(),
          MoreMenuView(),
        ];
    }
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isActive ? NelsonColors.primaryBlue : NelsonColors.textTertiary,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? NelsonColors.primaryBlue : NelsonColors.textTertiary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

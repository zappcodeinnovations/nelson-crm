import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/enums/user_role.dart';
import '../../auth/controllers/auth_controller.dart';

/// Shell controller managing bottom navigation tabs per role.
class ShellController extends GetxController {
  final currentIndex = 0.obs;

  UserRole get userRole => Get.find<AuthController>().currentUser.value?.role ?? UserRole.crmExecutive;

  List<BottomNavItem> get navItems {
    switch (userRole) {
      case UserRole.crmExecutive:
        return const [
          BottomNavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
          BottomNavItem(icon: Icons.people_outline, activeIcon: Icons.people, label: 'Leads'),
          BottomNavItem(icon: Icons.event_note_outlined, activeIcon: Icons.event_note, label: 'Follow-ups'),
          BottomNavItem(icon: Icons.calendar_today_outlined, activeIcon: Icons.calendar_today, label: 'Appointments'),
          BottomNavItem(icon: Icons.more_horiz, activeIcon: Icons.more_horiz, label: 'More'),
        ];
      case UserRole.receptionist:
        return const [
          BottomNavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
          BottomNavItem(icon: Icons.calendar_today_outlined, activeIcon: Icons.calendar_today, label: 'Appointments'),
          BottomNavItem(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Patients'),
          BottomNavItem(icon: Icons.event_note_outlined, activeIcon: Icons.event_note, label: 'Follow-ups'),
          BottomNavItem(icon: Icons.more_horiz, activeIcon: Icons.more_horiz, label: 'More'),
        ];
      case UserRole.doctor:
        return const [
          BottomNavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
          BottomNavItem(icon: Icons.calendar_today_outlined, activeIcon: Icons.calendar_today, label: 'Appointments'),
          BottomNavItem(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Patients'),
          BottomNavItem(icon: Icons.more_horiz, activeIcon: Icons.more_horiz, label: 'More'),
        ];
      case UserRole.marketing:
        return const [
          BottomNavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
          BottomNavItem(icon: Icons.people_outline, activeIcon: Icons.people, label: 'Leads'),
          BottomNavItem(icon: Icons.analytics_outlined, activeIcon: Icons.analytics, label: 'Analytics'),
          BottomNavItem(icon: Icons.more_horiz, activeIcon: Icons.more_horiz, label: 'More'),
        ];
      case UserRole.branchManager:
        return const [
          BottomNavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
          BottomNavItem(icon: Icons.people_outline, activeIcon: Icons.people, label: 'Leads'),
          BottomNavItem(icon: Icons.calendar_today_outlined, activeIcon: Icons.calendar_today, label: 'Appointments'),
          BottomNavItem(icon: Icons.analytics_outlined, activeIcon: Icons.analytics, label: 'Analytics'),
          BottomNavItem(icon: Icons.more_horiz, activeIcon: Icons.more_horiz, label: 'More'),
        ];
      case UserRole.admin:
        return const [
          BottomNavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
          BottomNavItem(icon: Icons.people_outline, activeIcon: Icons.people, label: 'Leads'),
          BottomNavItem(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Patients'),
          BottomNavItem(icon: Icons.calendar_today_outlined, activeIcon: Icons.calendar_today, label: 'Appointments'),
          BottomNavItem(icon: Icons.more_horiz, activeIcon: Icons.more_horiz, label: 'More'),
        ];
    }
  }

  void changeTab(int index) {
    currentIndex.value = index;
  }
}

class BottomNavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const BottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

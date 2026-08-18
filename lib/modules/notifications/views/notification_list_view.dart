import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';

/// Notification list view.
class NotificationListView extends StatelessWidget {
  const NotificationListView({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {'type': 'NEW_LEAD', 'title': 'New Lead Assigned', 'message': 'Nisha Pandey - Critical Care', 'time': '5 min ago', 'icon': Icons.person_add, 'color': NelsonColors.statusNew, 'isRead': false},
      {'type': 'FOLLOW_UP_DUE', 'title': 'Follow-up Due', 'message': 'Amit Sharma - Neurology • Call at 10:30 AM', 'time': '15 min ago', 'icon': Icons.event_note, 'color': NelsonColors.statusFollowUp, 'isRead': false},
      {'type': 'FOLLOW_UP_OVERDUE', 'title': 'Follow-up Overdue', 'message': 'Sunita Devi - Women Care', 'time': '1h ago', 'icon': Icons.warning_amber, 'color': NelsonColors.primaryRed, 'isRead': false},
      {'type': 'APPOINTMENT_CONFIRMED', 'title': 'Appointment Confirmed', 'message': 'Lakshmi Iyer - Dr. Vijay Patel • 15 Aug 11:00 AM', 'time': '2h ago', 'icon': Icons.check_circle, 'color': NelsonColors.successGreen, 'isRead': true},
      {'type': 'SHIFT_HANDOVER', 'title': 'Shift Handover', 'message': '4 tasks received from evening shift', 'time': '4h ago', 'icon': Icons.swap_horiz, 'color': NelsonColors.shiftMorning, 'isRead': true},
      {'type': 'LEAD_ASSIGNED', 'title': 'Lead Assigned', 'message': 'Pooja Nair - Gynecology', 'time': 'Yesterday', 'icon': Icons.assignment_ind, 'color': NelsonColors.statusAssigned, 'isRead': true},
    ];

    return Scaffold(
      backgroundColor: NelsonColors.background,
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Mark All Read', style: AppTypography.bodyMedium.copyWith(color: NelsonColors.primaryBlue)),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: notifications.length,
        itemBuilder: (_, index) {
          final n = notifications[index];
          final isRead = n['isRead'] as bool;
          return Container(
            color: isRead ? NelsonColors.surface : NelsonColors.blueSurface.withValues(alpha: 0.3),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal, vertical: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (n['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(n['icon'] as IconData, size: 18, color: n['color'] as Color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(n['title'] as String, style: AppTypography.bodyMedium.copyWith(fontWeight: isRead ? FontWeight.w400 : FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text(n['message'] as String, style: AppTypography.caption, maxLines: 2),
                    ],
                  ),
                ),
                Text(n['time'] as String, style: AppTypography.caption.copyWith(fontSize: 11)),
              ],
            ),
          );
        },
      ),
    );
  }
}

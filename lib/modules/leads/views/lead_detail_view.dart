import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/widgets/loading_states.dart';
import '../../../core/utils/date_utils.dart';
import '../../../routes/app_routes.dart';
import '../controllers/lead_controller.dart';

/// Lead detail - the central screen of the application.
class LeadDetailView extends StatelessWidget {
  const LeadDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeadDetailController());

    return Scaffold(
      backgroundColor: NelsonColors.background,
      appBar: AppBar(
        title: const Text('Lead Detail'),
        actions: [
          IconButton(icon: const Icon(Icons.edit_outlined, size: 20), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert, size: 20), onPressed: () {}),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) return const LoadingState(isList: false);
        final lead = controller.lead.value;
        if (lead == null) return const ErrorState(message: 'Lead not found.');

        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: NelsonColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: NelsonColors.border, width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(lead.name, style: AppTypography.sectionTitleLarge)),
                        StatusBadge(label: lead.status.label, color: lead.status.color),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _InfoRow(icon: Icons.phone_outlined, value: lead.phone),
                    if (lead.email != null) _InfoRow(icon: Icons.email_outlined, value: lead.email!),
                    _InfoRow(icon: Icons.local_hospital, value: lead.department?.label ?? 'Not assigned'),
                    _InfoRow(icon: Icons.source_outlined, value: '${lead.source.label} • ${lead.entryType.label}'),
                    _InfoRow(icon: Icons.badge_outlined, value: lead.id),
                    _InfoRow(icon: Icons.access_time, value: AppDateUtils.formatDateTime(lead.createdAt)),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Requirement
              _Section(title: 'Requirement', children: [
                Text(lead.requirement, style: AppTypography.body),
                if (lead.remark1 != null) ...[
                  const SizedBox(height: 8),
                  _LabelValue(label: 'Remark 1', value: lead.remark1!),
                ],
                if (lead.remark2 != null) _LabelValue(label: 'Remark 2', value: lead.remark2!),
              ]),

              // Assignment
              if (lead.assignedStaffName != null) ...[
                const SizedBox(height: AppSpacing.lg),
                _Section(title: 'Assignment', children: [
                  _LabelValue(label: 'Staff', value: lead.assignedStaffName!),
                  if (lead.assignedDoctorName != null)
                    _LabelValue(label: 'Doctor', value: lead.assignedDoctorName!),
                  _LabelValue(label: 'Branch', value: lead.branch ?? ''),
                ]),
              ],

              // Follow-up
              if (lead.nextFollowUpAt != null) ...[
                const SizedBox(height: AppSpacing.lg),
                _Section(title: 'Next Follow-up', children: [
                  _LabelValue(
                    label: 'Scheduled',
                    value: AppDateUtils.formatDateTime(lead.nextFollowUpAt!),
                  ),
                ]),
              ],

              const SizedBox(height: AppSpacing.sectionGap),

              // Next recommended action
              _NextAction(lead: lead),

              const SizedBox(height: AppSpacing.lg),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: AppButton.primary(
                      label: 'CALL',
                      icon: Icons.phone,
                      onPressed: () => Get.toNamed(AppRoutes.callOutcome, arguments: {'lead': lead}),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton.outline(
                      label: 'FOLLOW-UP',
                      icon: Icons.event_note,
                      onPressed: () => Get.toNamed(AppRoutes.scheduleFollowUp, arguments: {'lead': lead}),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: AppButton.secondary(
                      label: 'ASSIGN DOCTOR',
                      icon: Icons.medical_services_outlined,
                      onPressed: () => Get.toNamed(AppRoutes.doctorAvailability, arguments: {
                        'lead': lead,
                        'department': lead.department?.value,
                      }),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton.outline(
                      label: 'APPOINTMENT',
                      icon: Icons.calendar_today,
                      onPressed: () => Get.toNamed(AppRoutes.bookAppointment, arguments: {'lead': lead}),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      }),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String value;
  const _InfoRow({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Icon(icon, size: 15, color: NelsonColors.textTertiary),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: AppTypography.body.copyWith(color: NelsonColors.textSecondary))),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: NelsonColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: NelsonColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.label.copyWith(color: NelsonColors.primaryBlue)),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }
}

class _LabelValue extends StatelessWidget {
  final String label;
  final String value;
  const _LabelValue({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(label, style: AppTypography.caption),
          ),
          Expanded(child: Text(value, style: AppTypography.body)),
        ],
      ),
    );
  }
}

class _NextAction extends StatelessWidget {
  final dynamic lead;
  const _NextAction({required this.lead});

  @override
  Widget build(BuildContext context) {
    String action;
    IconData icon;
    Color color;

    // Determine next recommended action based on status
    switch (lead.status.value) {
      case 'NEW':
      case 'ASSIGNED':
        action = 'CALL NOW';
        icon = Icons.phone;
        color = NelsonColors.primaryRed;
      case 'CONTACTED':
      case 'NO_RESPONSE':
        action = 'SCHEDULE FOLLOW-UP';
        icon = Icons.event_note;
        color = NelsonColors.statusFollowUp;
      case 'CONNECTED':
      case 'INTERESTED':
        action = 'ASSIGN DOCTOR';
        icon = Icons.medical_services;
        color = NelsonColors.primaryBlue;
      case 'DOCTOR_ASSIGNMENT':
        action = 'BOOK APPOINTMENT';
        icon = Icons.calendar_today;
        color = NelsonColors.primaryBlue;
      case 'APPOINTMENT_SCHEDULED':
        action = 'CONFIRM APPOINTMENT';
        icon = Icons.check_circle;
        color = NelsonColors.successGreen;
      default:
        action = 'VIEW NEXT ACTION';
        icon = Icons.arrow_forward;
        color = NelsonColors.primaryBlue;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 10),
          Text(
            'Next: $action',
            style: AppTypography.bodyMedium.copyWith(color: color),
          ),
          const Spacer(),
          Icon(Icons.arrow_forward_ios, size: 14, color: color),
        ],
      ),
    );
  }
}

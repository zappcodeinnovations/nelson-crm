import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';

class PatientDetailView extends StatelessWidget {
  const PatientDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final patient = Get.arguments?['patient'] as Map<String, dynamic>?;
    return Scaffold(
      backgroundColor: NelsonColors.background,
      appBar: AppBar(title: Text(patient?['name'] as String? ?? 'Patient')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: NelsonColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: NelsonColors.border, width: 0.5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(patient?['name'] as String? ?? '', style: AppTypography.sectionTitleLarge),
                const SizedBox(height: 8),
                _Row(label: 'Patient ID', value: patient?['id'] as String? ?? ''),
                _Row(label: 'Phone', value: patient?['phone'] as String? ?? ''),
                _Row(label: 'Department', value: patient?['department'] as String? ?? ''),
                _Row(label: 'Lead ID', value: patient?['leadId'] as String? ?? ''),
                _Row(label: 'Source', value: patient?['source'] as String? ?? ''),
                _Row(label: 'Last Visit', value: patient?['lastVisit'] as String? ?? ''),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text('Journey', style: AppTypography.sectionTitle),
          const SizedBox(height: 8),
          _TimelineItem(title: 'Lead Created', subtitle: 'Source: ${patient?['source']}', time: '10 Aug'),
          _TimelineItem(title: 'Called', subtitle: 'Connected - Interested', time: '10 Aug'),
          _TimelineItem(title: 'Doctor Assigned', subtitle: 'Dr. Rajiv Kumar', time: '11 Aug'),
          _TimelineItem(title: 'Appointment', subtitle: 'Confirmed', time: '12 Aug'),
          _TimelineItem(title: 'Visited', subtitle: 'Consultation completed', time: '12 Aug'),
          _TimelineItem(title: 'Converted', subtitle: 'Patient registered', time: '12 Aug', isLast: true),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label, value;
  const _Row({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Row(children: [
      SizedBox(width: 90, child: Text(label, style: AppTypography.caption)),
      Expanded(child: Text(value, style: AppTypography.body)),
    ]));
  }
}

class _TimelineItem extends StatelessWidget {
  final String title, subtitle, time;
  final bool isLast;
  const _TimelineItem({required this.title, required this.subtitle, required this.time, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(width: 10, height: 10, decoration: BoxDecoration(color: NelsonColors.primaryBlue, shape: BoxShape.circle)),
                if (!isLast) Expanded(child: Container(width: 2, color: NelsonColors.border)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: NelsonColors.surface, borderRadius: BorderRadius.circular(8), border: Border.all(color: NelsonColors.border, width: 0.5)),
              child: Row(
                children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(title, style: AppTypography.bodyMedium),
                    Text(subtitle, style: AppTypography.caption),
                  ])),
                  Text(time, style: AppTypography.caption),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_search_bar.dart';
import '../../../core/widgets/loading_states.dart';
import '../../../routes/app_routes.dart';

class PatientListView extends StatelessWidget {
  const PatientListView({super.key});

  @override
  Widget build(BuildContext context) {
    final patients = [
      {'id': 'P-50214', 'name': 'Anita Joshi', 'phone': '9876543217', 'department': 'Ophthalmology', 'leadId': 'NL-10238', 'source': 'Referral', 'lastVisit': 'Today'},
      {'id': 'P-50213', 'name': 'Ramesh Gupta', 'phone': '9876543220', 'department': 'General Medicine', 'leadId': 'NL-10235', 'source': 'Walk-in', 'lastVisit': 'Yesterday'},
      {'id': 'P-50212', 'name': 'Vikram Singh', 'phone': '9876543214', 'department': 'Cardiology', 'leadId': 'NL-10241', 'source': 'Facebook', 'lastVisit': '12 Aug'},
    ];

    return Scaffold(
      backgroundColor: NelsonColors.background,
      appBar: AppBar(title: const Text('Patients')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal, vertical: 8),
            child: AppSearchBar(hint: 'Search patient name, ID, phone...', onChanged: (_) {}),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal),
              itemCount: patients.length,
              itemBuilder: (_, index) {
                final p = patients[index];
                return GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.patientDetail, arguments: {'patient': p}),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: NelsonColors.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: NelsonColors.border, width: 0.5),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: NelsonColors.primaryBlue.withValues(alpha: 0.1),
                          child: Text((p['name'] as String)[0], style: TextStyle(color: NelsonColors.primaryBlue, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p['name'] as String, style: AppTypography.bodyMedium),
                              Text('${p['id']} • ${p['department']}', style: AppTypography.caption),
                              Text('Lead: ${p['leadId']} • Source: ${p['source']}', style: AppTypography.caption.copyWith(fontSize: 11)),
                            ],
                          ),
                        ),
                        Text(p['lastVisit'] as String, style: AppTypography.caption),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

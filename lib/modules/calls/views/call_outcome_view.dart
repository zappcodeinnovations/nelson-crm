import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/app_dropdown.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../../../data/models/lead_model.dart';
import '../../../data/models/enums/call_enums.dart';
import '../../../routes/app_routes.dart';
import '../controllers/call_controller.dart';

/// Call outcome screen - handles Answered / Not Answered flow.
class CallOutcomeView extends StatelessWidget {
  const CallOutcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CallOutcomeController());
    final lead = Get.arguments?['lead'] as LeadModel?;

    return Scaffold(
      backgroundColor: NelsonColors.surface,
      appBar: AppBar(title: const Text('Call Outcome')),
      body: Obx(() {
        // Step 1: Answered or not?
        if (controller.step.value == 0) {
          return _AnswerStep(lead: lead, controller: controller);
        }
        // Step 2: Not Answered
        if (controller.step.value == 1) {
          return _NoAnswerStep(lead: lead, controller: controller);
        }
        // Step 3: Answered
        return _AnsweredStep(lead: lead, controller: controller);
      }),
    );
  }
}

class _AnswerStep extends StatelessWidget {
  final LeadModel? lead;
  final CallOutcomeController controller;
  const _AnswerStep({required this.lead, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (lead != null) ...[
            Text(lead!.name, style: AppTypography.sectionTitleLarge),
            const SizedBox(height: 4),
            Text(lead!.phone, style: AppTypography.body.copyWith(color: NelsonColors.textSecondary)),
            Text(lead!.department?.label ?? '', style: AppTypography.caption),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: NelsonColors.blueSurface, borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, size: 16, color: NelsonColors.primaryBlue),
                  const SizedBox(width: 8),
                  Text('Call recorded by: You', style: AppTypography.caption.copyWith(color: NelsonColors.primaryBlue)),
                ],
              ),
            ),
          ],
          const SizedBox(height: 32),
          Text('CALL OUTCOME', style: AppTypography.sectionTitle),
          const SizedBox(height: 20),
          AppButton.primary(
            label: 'ANSWERED',
            icon: Icons.check_circle_outline,
            onPressed: () => controller.step.value = 2,
          ),
          const SizedBox(height: 12),
          AppButton.outline(
            label: 'NOT ANSWERED',
            icon: Icons.phone_missed_outlined,
            onPressed: () => controller.step.value = 1,
          ),
        ],
      ),
    );
  }
}

class _NoAnswerStep extends StatelessWidget {
  final LeadModel? lead;
  final CallOutcomeController controller;
  const _NoAnswerStep({required this.lead, required this.controller});

  @override
  Widget build(BuildContext context) {
    final noteCtrl = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Not Answered', style: AppTypography.sectionTitle),
          const SizedBox(height: AppSpacing.lg),
          Obx(() => AppDropdown<NoAnswerReason>(
            label: 'Reason',
            hint: 'Select reason',
            value: controller.noAnswerReason.value,
            items: NoAnswerReason.values.map((r) => DropdownMenuItem(value: r, child: Text(r.label))).toList(),
            onChanged: (v) => controller.noAnswerReason.value = v,
          )),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(label: 'Note', hint: 'Add a note...', controller: noteCtrl, maxLines: 3),
          const SizedBox(height: AppSpacing.xxl),
          Text('Schedule Follow-up?', style: AppTypography.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: AppButton.primary(
                  label: 'YES',
                  onPressed: () {
                    SnackbarUtils.showSuccess('Call recorded. Redirecting to follow-up...');
                    Get.offNamed(AppRoutes.scheduleFollowUp, arguments: {'lead': lead});
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton.outline(
                  label: 'NO',
                  onPressed: () {
                    SnackbarUtils.showSuccess('Call recorded.');
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnsweredStep extends StatelessWidget {
  final LeadModel? lead;
  final CallOutcomeController controller;
  const _AnsweredStep({required this.lead, required this.controller});

  @override
  Widget build(BuildContext context) {
    final requirementCtrl = TextEditingController(text: lead?.requirement ?? '');
    final remark1Ctrl = TextEditingController();
    final remark2Ctrl = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Answered', style: AppTypography.sectionTitle),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(label: 'Requirement', hint: 'Patient requirement', controller: requirementCtrl, maxLines: 3),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(label: 'Remark 1', hint: 'First remark', controller: remark1Ctrl, maxLines: 2),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(label: 'Remark 2', hint: 'Second remark', controller: remark2Ctrl, maxLines: 2),
          const SizedBox(height: AppSpacing.lg),
          Obx(() => AppDropdown<CallResult>(
            label: 'Call Result',
            hint: 'Select result',
            value: controller.callResult.value,
            items: CallResult.values.map((r) => DropdownMenuItem(value: r, child: Text(r.label))).toList(),
            onChanged: (v) => controller.callResult.value = v,
          )),
          const SizedBox(height: AppSpacing.lg),
          Obx(() => AppDropdown<NextAction>(
            label: 'Next Action',
            hint: 'Select next action',
            value: controller.nextAction.value,
            items: NextAction.values.map((a) => DropdownMenuItem(value: a, child: Text(a.label))).toList(),
            onChanged: (v) => controller.nextAction.value = v,
          )),
          const SizedBox(height: AppSpacing.xxl),
          Obx(() => AppButton.primary(
            label: 'SAVE & CONTINUE',
            isLoading: controller.isLoading.value,
            onPressed: () {
              SnackbarUtils.showSuccess('Call outcome saved.');
              final nextAction = controller.nextAction.value;
              if (nextAction == NextAction.scheduleFollowUp) {
                Get.offNamed(AppRoutes.scheduleFollowUp, arguments: {'lead': lead});
              } else if (nextAction == NextAction.assignDoctor) {
                Get.offNamed(AppRoutes.doctorAvailability, arguments: {'lead': lead, 'department': lead?.department?.value});
              } else if (nextAction == NextAction.bookAppointment) {
                Get.offNamed(AppRoutes.bookAppointment, arguments: {'lead': lead});
              } else {
                Get.back();
              }
            },
          )),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

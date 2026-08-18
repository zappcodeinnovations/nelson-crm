import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/app_dropdown.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../../../data/models/enums/call_enums.dart';

/// Schedule follow-up form.
class ScheduleFollowUpView extends StatelessWidget {
  const ScheduleFollowUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final notesCtrl = TextEditingController();
    final selectedType = FollowUpType.call.obs;
    final selectedDate = DateTime.now().add(const Duration(days: 1)).obs;
    final selectedTime = const TimeOfDay(hour: 10, minute: 30).obs;

    return Scaffold(
      backgroundColor: NelsonColors.surface,
      appBar: AppBar(title: const Text('Schedule Follow-up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(() => AppDropdown<FollowUpType>(
              label: 'Follow-up Type',
              value: selectedType.value,
              items: FollowUpType.values.map((t) => DropdownMenuItem(value: t, child: Text(t.label))).toList(),
              onChanged: (v) => selectedType.value = v ?? FollowUpType.call,
            )),
            const SizedBox(height: AppSpacing.lg),

            Text('Date', style: AppTypography.label),
            const SizedBox(height: 6),
            Obx(() => GestureDetector(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: selectedDate.value,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) selectedDate.value = date;
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: NelsonColors.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 18, color: NelsonColors.textTertiary),
                    const SizedBox(width: 10),
                    Text('${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}', style: AppTypography.body),
                  ],
                ),
              ),
            )),
            const SizedBox(height: AppSpacing.lg),

            Text('Time', style: AppTypography.label),
            const SizedBox(height: 6),
            Obx(() => GestureDetector(
              onTap: () async {
                final time = await showTimePicker(context: context, initialTime: selectedTime.value);
                if (time != null) selectedTime.value = time;
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: NelsonColors.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time, size: 18, color: NelsonColors.textTertiary),
                    const SizedBox(width: 10),
                    Text(selectedTime.value.format(context), style: AppTypography.body),
                  ],
                ),
              ),
            )),
            const SizedBox(height: AppSpacing.lg),

            AppTextField(label: 'Notes', hint: 'Follow-up notes...', controller: notesCtrl, maxLines: 3),
            const SizedBox(height: AppSpacing.xxl),

            AppButton.primary(
              label: 'SCHEDULE FOLLOW-UP',
              onPressed: () {
                SnackbarUtils.showSuccess('Follow-up scheduled successfully!');
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/utils/validators.dart';
import '../controllers/lead_controller.dart';

/// WhatsApp-specific quick lead form.
class WhatsAppLeadView extends StatelessWidget {
  const WhatsAppLeadView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddLeadController());
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final requirementCtrl = TextEditingController();

    return Scaffold(
      backgroundColor: NelsonColors.surface,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: NelsonColors.successGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.chat, size: 18, color: NelsonColors.successGreen),
            ),
            const SizedBox(width: 8),
            const Text('WhatsApp Lead'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: NelsonColors.greenSurface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, size: 18, color: NelsonColors.greenDark),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Quick form for WhatsApp leads. Source will be set automatically.',
                        style: AppTypography.caption.copyWith(color: NelsonColors.greenDark),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              AppTextField(label: 'Name *', hint: 'Patient name', controller: nameCtrl, validator: Validators.name, prefixIcon: Icons.person_outline, textInputAction: TextInputAction.next),
              const SizedBox(height: AppSpacing.lg),
              AppTextField(label: 'Phone *', hint: 'Phone number', controller: phoneCtrl, validator: Validators.phone, keyboardType: TextInputType.phone, prefixIcon: Icons.phone_outlined, textInputAction: TextInputAction.next),
              const SizedBox(height: AppSpacing.lg),
              AppTextField(label: 'Requirement *', hint: 'What does the patient need?', controller: requirementCtrl, validator: (v) => Validators.required(v, 'Requirement'), maxLines: 3),
              const SizedBox(height: AppSpacing.xxl),

              Obx(() => AppButton.primary(
                label: '+ WHATSAPP LEAD',
                icon: Icons.chat,
                isLoading: controller.isLoading.value,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final success = await controller.createLead({
                      'name': nameCtrl.text.trim(),
                      'phone': phoneCtrl.text.trim(),
                      'requirement': requirementCtrl.text.trim(),
                      'source': 'WHATSAPP',
                      'entry_type': 'MANUAL',
                    });
                    if (success) Get.back();
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

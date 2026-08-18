import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/app_dropdown.dart';
import '../../../core/utils/validators.dart';
import '../../../data/models/enums/lead_source.dart';
import '../../../data/models/enums/department.dart';
import '../controllers/lead_controller.dart';

/// Add lead form.
class AddLeadView extends StatelessWidget {
  const AddLeadView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddLeadController());
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final requirementCtrl = TextEditingController();
    final ageCtrl = TextEditingController();
    final cityCtrl = TextEditingController();
    final campaignCtrl = TextEditingController();
    final notesCtrl = TextEditingController();

    final selectedSource = LeadSource.other.obs;
    final selectedDepartment = Rxn<Department>();
    final selectedGender = Rxn<String>();

    return Scaffold(
      backgroundColor: NelsonColors.surface,
      appBar: AppBar(title: const Text('Add Lead')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(label: 'Name *', hint: 'Patient name', controller: nameCtrl, validator: Validators.name, prefixIcon: Icons.person_outline, textInputAction: TextInputAction.next),
              const SizedBox(height: AppSpacing.lg),
              AppTextField(label: 'Phone *', hint: 'Phone number', controller: phoneCtrl, validator: Validators.phone, keyboardType: TextInputType.phone, prefixIcon: Icons.phone_outlined, textInputAction: TextInputAction.next),
              const SizedBox(height: AppSpacing.lg),
              AppTextField(label: 'Email', hint: 'Email address', controller: emailCtrl, validator: Validators.email, keyboardType: TextInputType.emailAddress, prefixIcon: Icons.email_outlined, textInputAction: TextInputAction.next),
              const SizedBox(height: AppSpacing.lg),
              AppTextField(label: 'Requirement *', hint: 'Describe the requirement', controller: requirementCtrl, validator: (v) => Validators.required(v, 'Requirement'), maxLines: 3, textInputAction: TextInputAction.next),
              const SizedBox(height: AppSpacing.lg),

              Obx(() => AppDropdown<LeadSource>(
                label: 'Source',
                value: selectedSource.value,
                items: LeadSource.values.map((s) => DropdownMenuItem(value: s, child: Text(s.label))).toList(),
                onChanged: (v) => selectedSource.value = v ?? LeadSource.other,
              )),
              const SizedBox(height: AppSpacing.lg),

              Obx(() => AppDropdown<Department>(
                label: 'Department',
                hint: 'Select department',
                value: selectedDepartment.value,
                items: Department.values.map((d) => DropdownMenuItem(value: d, child: Text(d.label))).toList(),
                onChanged: (v) => selectedDepartment.value = v,
              )),
              const SizedBox(height: AppSpacing.lg),

              Row(
                children: [
                  Expanded(child: AppTextField(label: 'Age', hint: 'Age', controller: ageCtrl, keyboardType: TextInputType.number, validator: Validators.age)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Obx(() => AppDropdown<String>(
                      label: 'Gender',
                      hint: 'Select',
                      value: selectedGender.value,
                      items: ['Male', 'Female', 'Other'].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                      onChanged: (v) => selectedGender.value = v,
                    )),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              AppTextField(label: 'City', hint: 'City', controller: cityCtrl),
              const SizedBox(height: AppSpacing.lg),
              AppTextField(label: 'Campaign', hint: 'Campaign name', controller: campaignCtrl),
              const SizedBox(height: AppSpacing.lg),
              AppTextField(label: 'Notes', hint: 'Additional notes', controller: notesCtrl, maxLines: 2),
              const SizedBox(height: AppSpacing.xxl),

              Obx(() => AppButton.primary(
                label: 'CREATE LEAD',
                isLoading: controller.isLoading.value,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final success = await controller.createLead({
                      'name': nameCtrl.text.trim(),
                      'phone': phoneCtrl.text.trim(),
                      'email': emailCtrl.text.trim(),
                      'requirement': requirementCtrl.text.trim(),
                      'source': selectedSource.value.value,
                      'department': selectedDepartment.value?.value,
                      'age': int.tryParse(ageCtrl.text),
                      'gender': selectedGender.value,
                      'city': cityCtrl.text.trim(),
                      'campaign': campaignCtrl.text.trim(),
                      'entry_type': 'MANUAL',
                    });
                    if (success) Get.back();
                  }
                },
              )),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/utils/validators.dart';
import '../controllers/auth_controller.dart';

/// Forgot password screen.
class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final phoneCtrl = TextEditingController();
    final controller = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: NelsonColors.surface,
      appBar: AppBar(
        backgroundColor: NelsonColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Text('Forgot Password', style: AppTypography.screenTitle),
                const SizedBox(height: 8),
                Text(
                  'Enter your phone number and we\'ll send you an OTP to reset your password.',
                  style: AppTypography.body.copyWith(color: NelsonColors.textSecondary),
                ),
                const SizedBox(height: 32),

                AppTextField(
                  label: 'Phone Number',
                  hint: 'Enter your registered phone number',
                  controller: phoneCtrl,
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone_outlined,
                  validator: Validators.phone,
                ),
                const SizedBox(height: 32),

                Obx(() => AppButton.primary(
                  label: 'SEND OTP',
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.forgotPassword(phoneCtrl.text.trim());
                    }
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

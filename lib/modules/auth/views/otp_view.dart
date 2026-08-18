import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../controllers/auth_controller.dart';

/// OTP verification screen.
class OtpView extends GetView<AuthController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final phone = Get.arguments?['phone'] as String? ?? '';
    final otpControllers = List.generate(6, (_) => TextEditingController());
    final focusNodes = List.generate(6, (_) => FocusNode());

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text('Verify OTP', style: AppTypography.screenTitle),
              const SizedBox(height: 8),
              Text(
                'Enter the 6-digit code sent to\n$phone',
                style: AppTypography.body.copyWith(color: NelsonColors.textSecondary),
              ),
              const SizedBox(height: 40),

              // OTP input
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 48,
                    height: 54,
                    child: TextField(
                      controller: otpControllers[index],
                      focusNode: focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: AppTypography.sectionTitleLarge,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: NelsonColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: NelsonColors.primaryBlue, width: 1.5),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          focusNodes[index + 1].requestFocus();
                        }
                        if (value.isEmpty && index > 0) {
                          focusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 32),

              // Verify button
              Obx(() => AppButton.primary(
                label: 'VERIFY',
                isLoading: controller.isLoading.value,
                onPressed: () {
                  final otp = otpControllers.map((c) => c.text).join();
                  controller.verifyOtp(phone, otp);
                },
              )),
              const SizedBox(height: 20),

              // Resend OTP
              Center(
                child: TextButton(
                  onPressed: () {
                    // Resend OTP logic
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Didn't receive code? ",
                      style: AppTypography.body.copyWith(color: NelsonColors.textSecondary),
                      children: [
                        TextSpan(
                          text: 'Resend',
                          style: AppTypography.bodyMedium.copyWith(color: NelsonColors.primaryBlue),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Hint
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: NelsonColors.blueSurface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Test OTP: 123456',
                  style: AppTypography.caption.copyWith(color: NelsonColors.primaryBlue),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

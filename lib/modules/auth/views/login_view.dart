import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/utils/validators.dart';
import '../../../routes/app_routes.dart';
import '../controllers/auth_controller.dart';

/// Login screen with phone and password.
class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final phoneCtrl = TextEditingController(text: '9876543210');
    final passwordCtrl = TextEditingController(text: '123456');

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_background.png'),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Center the form on the screen
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Form(
                                  key: formKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      // Logo
                                      // Center(
                                      //   child: Container(
                                      //     width: 80,
                                      //     height: 80,
                                      //     decoration: BoxDecoration(
                                      //       color: NelsonColors.primaryBlue.withOpacity(0.9),
                                      //       borderRadius: BorderRadius.circular(20),
                                      //       boxShadow: [
                                      //         BoxShadow(
                                      //           color: NelsonColors.primaryBlue.withOpacity(0.3),
                                      //           blurRadius: 20,
                                      //           offset: const Offset(0, 10),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //     child: Center(
                                      //       child: Text(
                                      //         'N',
                                      //         style: AppTypography.kpiValue.copyWith(
                                      //           fontSize: 40,
                                      //           color: NelsonColors.white,
                                      //           fontWeight: FontWeight.w800,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      // const SizedBox(height: 32),
                                      
                                      // // Title
                                      // Center(
                                      //   child: Text(
                                      //     'Welcome Back',
                                      //     style: AppTypography.screenTitle.copyWith(
                                      //       color: NelsonColors.white, // Ensure text is visible on dark backgrounds
                                      //       shadows: [
                                      //         Shadow(
                                      //           color: Colors.black.withOpacity(0.5),
                                      //           blurRadius: 10,
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                      // const SizedBox(height: 8),
                                      // Center(
                                      //   child: Text(
                                      //     'Sign in to Nelson Hospital CRM',
                                      //     style: AppTypography.body.copyWith(
                                      //       color: NelsonColors.white.withOpacity(0.9),
                                      //       shadows: [
                                      //         Shadow(
                                      //           color: Colors.black.withOpacity(0.5),
                                      //           blurRadius: 10,
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                      const SizedBox(height: 320),

                                      // Phone field
                                      AppTextField(
                                        label: 'Phone Number',
                                        hint: 'Enter your phone number',
                                        controller: phoneCtrl,
                                        keyboardType: TextInputType.phone,
                                        textInputAction: TextInputAction.next,
                                        prefixIcon: Icons.phone_outlined,
                                        validator: Validators.phone,
                                      ),
                                      const SizedBox(height: AppSpacing.lg),

                                      // Password field
                                      Obx(() => AppTextField(
                                        label: 'Password',
                                        hint: 'Enter your password',
                                        controller: passwordCtrl,
                                        obscureText: !controller.showPassword.value,
                                        textInputAction: TextInputAction.done,
                                        prefixIcon: Icons.lock_outline,
                                        suffixIcon: controller.showPassword.value
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        onSuffixTap: controller.togglePasswordVisibility,
                                        validator: Validators.password,
                                      )),
                                      const SizedBox(height: AppSpacing.md),

                                      // Forgot password
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
                                          child: Text(
                                            'Forgot Password?',
                                            style: AppTypography.bodyMedium.copyWith(
                                              color: NelsonColors.blueDark,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black.withOpacity(0.5),
                                                  blurRadius: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: AppSpacing.xl),

                                      // Login button
                                      Obx(() => AppButton.primary(
                                        label: 'LOGIN',
                                        isLoading: controller.isLoading.value,
                                        onPressed: () {
                                          if (formKey.currentState!.validate()) {
                                            controller.login(phoneCtrl.text.trim(), passwordCtrl.text);
                                          }
                                        },
                                      )),
                                      const SizedBox(height: AppSpacing.xxl),

                                      // Test credentials hint
                                      // Container(
                                      //   padding: const EdgeInsets.all(16),
                                      //   decoration: BoxDecoration(
                                      //     color: Colors.black.withOpacity(0.4),
                                      //     borderRadius: BorderRadius.circular(12),
                                      //     border: Border.all(color: Colors.white.withOpacity(0.1)),
                                      //   ),
                                      //   child: Column(
                                      //     crossAxisAlignment: CrossAxisAlignment.start,
                                      //     children: [
                                      //       Text(
                                      //         'Test Credentials',
                                      //         style: AppTypography.captionMedium.copyWith(
                                      //           color: NelsonColors.white,
                                      //         ),
                                      //       ),
                                      //       const SizedBox(height: 8),
                                      //       Text(
                                      //         'Executive: 9876543210  |  Admin: 9876543215\nPassword: 123456',
                                      //         style: AppTypography.caption.copyWith(
                                      //           color: NelsonColors.white.withOpacity(0.8),
                                      //           height: 1.5,
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ), // Expanded
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

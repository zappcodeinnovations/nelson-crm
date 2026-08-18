import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/auth_controller.dart';

/// Splash screen with logo and auto-login check.
class SplashView extends GetView<AuthController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger auth check after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        controller.checkAuthState();
      });
    });

    return Scaffold(
      backgroundColor: NelsonColors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/dr-nelsa2.gif',
              height: 100,
            ),
            // const SizedBox(height: 16),
            Image.asset(
              'assets/images/logo.png',
              width: 150,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}

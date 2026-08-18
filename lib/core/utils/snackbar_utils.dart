import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';

/// Centralized snackbar utilities.
class SnackbarUtils {
  SnackbarUtils._();

  static void showSuccess(String message, {String? title}) {
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
    Get.snackbar(
      title ?? 'Success',
      message,
      backgroundColor: NelsonColors.successGreen,
      colorText: NelsonColors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.check_circle, color: NelsonColors.white),
    );
  }

  static void showError(String message, {String? title}) {
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
    Get.snackbar(
      title ?? 'Error',
      message,
      backgroundColor: NelsonColors.primaryRed,
      colorText: NelsonColors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 4),
      icon: const Icon(Icons.error_outline, color: NelsonColors.white),
    );
  }

  static void showWarning(String message, {String? title}) {
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
    Get.snackbar(
      title ?? 'Warning',
      message,
      backgroundColor: NelsonColors.statusContacted,
      colorText: NelsonColors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.warning_amber_rounded, color: NelsonColors.white),
    );
  }

  static void showInfo(String message, {String? title}) {
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
    Get.snackbar(
      title ?? 'Info',
      message,
      backgroundColor: NelsonColors.primaryBlue,
      colorText: NelsonColors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.info_outline, color: NelsonColors.white),
    );
  }
}

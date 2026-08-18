import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'core/network/api_client.dart';
import 'core/network/connectivity_service.dart';
import 'core/storage/secure_storage_service.dart';
import 'core/storage/local_storage_service.dart';

import 'core/constants/api_config.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/lead_repository.dart';
import 'data/repositories/api/api_auth_repository.dart';
import 'data/repositories/api/api_lead_repository.dart';
import 'data/repositories/mock/mock_auth_repository.dart';
import 'data/repositories/mock/mock_lead_repository.dart';

import 'data/repositories/dashboard_repository.dart';
import 'data/repositories/api/api_dashboard_repository.dart';
import 'data/repositories/mock/mock_dashboard_repository.dart';

import 'data/repositories/doctor_repository.dart';
import 'data/repositories/api/api_doctor_repository.dart';
import 'data/repositories/mock/mock_doctor_repository.dart';

import 'data/repositories/follow_up_repository.dart';
import 'data/repositories/api/api_follow_up_repository.dart';
import 'data/repositories/mock/mock_follow_up_repository.dart';

import 'data/repositories/appointment_repository.dart';
import 'data/repositories/api/api_appointment_repository.dart';
import 'data/repositories/mock/mock_appointment_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initServices();
  runApp(const NelsonCrmApp());
}

/// Initialize core services before app starts.
Future<void> _initServices() async {
  // Storage
  Get.put(SecureStorageService(), permanent: true);
  await Get.putAsync(() => LocalStorageService().init(), permanent: true);

  // Network
  Get.put(ConnectivityService(), permanent: true);
  final apiClient = Get.put(ApiClient(), permanent: true);

  // Repositories
  if (ApiConfig.isMockMode) {
    Get.put<AuthRepository>(MockAuthRepository(), permanent: true);
    Get.put<LeadRepository>(MockLeadRepository(), permanent: true);
    Get.put<DashboardRepository>(MockDashboardRepository(), permanent: true);
    Get.put<DoctorRepository>(MockDoctorRepository(), permanent: true);
    Get.put<FollowUpRepository>(MockFollowUpRepository(), permanent: true);
    Get.put<AppointmentRepository>(MockAppointmentRepository(), permanent: true);
  } else {
    Get.put<AuthRepository>(ApiAuthRepository(apiClient), permanent: true);
    Get.put<LeadRepository>(ApiLeadRepository(apiClient), permanent: true);
    Get.put<DashboardRepository>(ApiDashboardRepository(apiClient), permanent: true);
    Get.put<DoctorRepository>(ApiDoctorRepository(apiClient), permanent: true);
    Get.put<FollowUpRepository>(ApiFollowUpRepository(apiClient), permanent: true);
    Get.put<AppointmentRepository>(ApiAppointmentRepository(apiClient), permanent: true);
  }
}

import 'package:get/get.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../../core/utils/date_utils.dart';
import '../../../data/repositories/dashboard_repository.dart';

/// Dashboard controller for CRM staff view.
class DashboardController extends GetxController {
  final isLoading = true.obs;
  final greeting = ''.obs;
  final userName = ''.obs;

  // KPI counts
  final newLeadsCount = 0.obs;
  final callsPendingCount = 0.obs;
  final followUpsCount = 0.obs;
  final overdueCount = 0.obs;
  final doctorAssignmentsCount = 0.obs;
  final appointmentsCount = 0.obs;

  // Manager stats
  final totalLeadsToday = 0.obs;
  final departmentStats = <Map<String, dynamic>>[].obs;
  final sourceStats = <Map<String, dynamic>>[].obs;
  final staffWorkload = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    isLoading.value = true;

    try {
      final authController = Get.find<AuthController>();
      final user = authController.currentUser.value;
      greeting.value = AppDateUtils.greeting();
      userName.value = user?.name.split(' ').first ?? 'Staff';

      final dashboardRepo = Get.find<DashboardRepository>();
      final stats = await dashboardRepo.getStats();

      newLeadsCount.value = stats['newLeadsCount'] ?? 0;
      callsPendingCount.value = stats['callsPendingCount'] ?? 0;
      followUpsCount.value = stats['followUpsCount'] ?? 0;
      overdueCount.value = stats['overdueCount'] ?? 0;
      doctorAssignmentsCount.value = stats['doctorAssignmentsCount'] ?? 0;
      appointmentsCount.value = stats['appointmentsCount'] ?? 0;

      totalLeadsToday.value = stats['totalLeadsToday'] ?? 0;
      departmentStats.value = List<Map<String, dynamic>>.from(stats['departmentStats'] ?? []);
      sourceStats.value = List<Map<String, dynamic>>.from(stats['sourceStats'] ?? []);
      staffWorkload.value = List<Map<String, dynamic>>.from(stats['staffWorkload'] ?? []);
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refresh() async {
    await _loadDashboard();
  }
}

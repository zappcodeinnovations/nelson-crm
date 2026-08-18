import 'package:get/get.dart';
import '../../../data/repositories/follow_up_repository.dart';

class FollowUpController extends GetxController {
  final isLoading = true.obs;
  final todayFollowUps = <Map<String, dynamic>>[].obs;
  final upcomingFollowUps = <Map<String, dynamic>>[].obs;
  final overdueFollowUps = <Map<String, dynamic>>[].obs;
  final completedFollowUps = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadFollowUps();
  }

  Future<void> _loadFollowUps() async {
    final repo = Get.find<FollowUpRepository>();
    final data = await repo.getFollowUps();
    
    todayFollowUps.value = data['today'] ?? [];
    upcomingFollowUps.value = data['upcoming'] ?? [];
    overdueFollowUps.value = data['overdue'] ?? [];
    completedFollowUps.value = data['completed'] ?? [];
    isLoading.value = false;
  }
}

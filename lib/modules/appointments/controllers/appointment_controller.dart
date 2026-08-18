import 'package:get/get.dart';
import '../../../data/repositories/appointment_repository.dart';

class AppointmentListController extends GetxController {
  final isLoading = true.obs;
  final appointments = <Map<String, dynamic>>[].obs;

  @override
  void onInit() { super.onInit(); load(); }

  Future<void> load() async {
    final repo = Get.find<AppointmentRepository>();
    appointments.value = await repo.getAppointments();
    isLoading.value = false;
  }
}

import 'package:get/get.dart';
import '../../../data/repositories/doctor_repository.dart';

class DoctorListController extends GetxController {
  final isLoading = true.obs;
  final doctors = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDoctors();
  }

  Future<void> _loadDoctors() async {
    final repo = Get.find<DoctorRepository>();
    doctors.value = await repo.getDoctors();
    isLoading.value = false;
  }
}

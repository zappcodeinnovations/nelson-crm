import 'package:get/get.dart';
import '../controllers/lead_controller.dart';

class LeadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeadListController>(() => LeadListController());
    Get.lazyPut<LeadDetailController>(() => LeadDetailController());
    Get.lazyPut<AddLeadController>(() => AddLeadController());
  }
}

import 'package:get/get.dart';
import '../controllers/shell_controller.dart';
import '../../dashboard/controllers/dashboard_controller.dart';
import '../../auth/controllers/auth_controller.dart';

/// Shell binding initializing shell and dashboard controllers.
class ShellBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.lazyPut<ShellController>(() => ShellController());
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}

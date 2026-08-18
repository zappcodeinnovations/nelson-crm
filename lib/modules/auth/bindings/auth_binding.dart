import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

/// Auth module dependency injection.
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}

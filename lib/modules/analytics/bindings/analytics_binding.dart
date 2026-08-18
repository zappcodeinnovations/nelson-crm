import 'package:get/get.dart';

class AnalyticsController extends GetxController {
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 400), () => isLoading.value = false);
  }
}

class AnalyticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnalyticsController>(() => AnalyticsController());
  }
}

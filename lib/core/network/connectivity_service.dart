import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

/// Monitors network connectivity state.
class ConnectivityService extends GetxService {
  final _connectivity = Connectivity();
  final isConnected = true.obs;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  @override
  void onInit() {
    super.onInit();
    _checkConnectivity();
    _subscription = _connectivity.onConnectivityChanged.listen(_updateStatus);
  }

  Future<void> _checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _updateStatus(result);
  }

  void _updateStatus(List<ConnectivityResult> results) {
    isConnected.value = results.any(
      (r) => r != ConnectivityResult.none,
    );
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}

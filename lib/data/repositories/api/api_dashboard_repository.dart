import '../../../core/constants/api_config.dart';
import '../../../core/network/api_client.dart';
import '../dashboard_repository.dart';

class ApiDashboardRepository implements DashboardRepository {
  final ApiClient _apiClient;

  ApiDashboardRepository(this._apiClient);

  @override
  Future<Map<String, dynamic>> getStats() async {
    final response = await _apiClient.get(ApiConfig.analytics);
    return response.data['data'] ?? response.data;
  }
}

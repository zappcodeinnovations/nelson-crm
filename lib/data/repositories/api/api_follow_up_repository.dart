import '../../../core/constants/api_config.dart';
import '../../../core/network/api_client.dart';
import '../follow_up_repository.dart';

class ApiFollowUpRepository implements FollowUpRepository {
  final ApiClient _apiClient;

  ApiFollowUpRepository(this._apiClient);

  @override
  Future<Map<String, List<Map<String, dynamic>>>> getFollowUps() async {
    final response = await _apiClient.get(ApiConfig.followUps);
    
    // Convert dynamic Map to specific type
    final Map<String, dynamic> rawData = response.data['data'] ?? response.data;
    final Map<String, List<Map<String, dynamic>>> result = {};
    
    rawData.forEach((key, value) {
      if (value is List) {
        result[key] = value.cast<Map<String, dynamic>>();
      }
    });
    
    return result;
  }
}

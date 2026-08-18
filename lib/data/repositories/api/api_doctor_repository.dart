import '../../../core/constants/api_config.dart';
import '../../../core/network/api_client.dart';
import '../doctor_repository.dart';

class ApiDoctorRepository implements DoctorRepository {
  final ApiClient _apiClient;

  ApiDoctorRepository(this._apiClient);

  @override
  Future<List<Map<String, dynamic>>> getDoctors() async {
    final response = await _apiClient.get(ApiConfig.doctors);
    final List<dynamic> data = response.data['data'] ?? [];
    return data.cast<Map<String, dynamic>>();
  }
}

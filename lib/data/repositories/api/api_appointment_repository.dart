import '../../../core/constants/api_config.dart';
import '../../../core/network/api_client.dart';
import '../appointment_repository.dart';

class ApiAppointmentRepository implements AppointmentRepository {
  final ApiClient _apiClient;

  ApiAppointmentRepository(this._apiClient);

  @override
  Future<List<Map<String, dynamic>>> getAppointments() async {
    final response = await _apiClient.get(ApiConfig.appointments);
    final List<dynamic> data = response.data['data'] ?? [];
    return data.cast<Map<String, dynamic>>();
  }
}

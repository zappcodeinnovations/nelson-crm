import '../../../core/constants/api_config.dart';
import '../../../core/network/api_client.dart';
import '../../models/lead_model.dart';
import '../../models/enums/lead_status.dart';
import '../lead_repository.dart';

class ApiLeadRepository implements LeadRepository {
  final ApiClient _apiClient;

  ApiLeadRepository(this._apiClient);

  @override
  Future<List<LeadModel>> getLeads({
    int page = 1,
    int perPage = 20,
    LeadStatus? status,
    String? search,
    String? source,
    String? department,
    String? staffId,
    String? dateFrom,
    String? dateTo,
  }) async {
    final queryParams = {
      'page': page,
      'per_page': perPage,
      if (status != null) 'status': status.value,
      if (search != null && search.isNotEmpty) 'search': search,
      if (source != null && source.isNotEmpty) 'source': source,
      if (department != null && department.isNotEmpty) 'department': department,
      if (staffId != null && staffId.isNotEmpty) 'staff_id': staffId,
      if (dateFrom != null && dateFrom.isNotEmpty) 'date_from': dateFrom,
      if (dateTo != null && dateTo.isNotEmpty) 'date_to': dateTo,
    };

    final response = await _apiClient.get(
      ApiConfig.leads,
      queryParameters: queryParams,
    );
    
    final List<dynamic> data = response.data['data'] ?? [];
    return data.map((json) => LeadModel.fromJson(json)).toList();
  }

  @override
  Future<LeadModel> getLeadById(String id) async {
    final response = await _apiClient.get('${ApiConfig.leads}/$id');
    return LeadModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<LeadModel> createLead(Map<String, dynamic> data) async {
    final response = await _apiClient.post(
      ApiConfig.leads,
      data: data,
    );
    return LeadModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<LeadModel> updateLead(String id, Map<String, dynamic> data) async {
    final response = await _apiClient.put(
      '${ApiConfig.leads}/$id',
      data: data,
    );
    return LeadModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<void> deleteLead(String id) async {
    await _apiClient.delete('${ApiConfig.leads}/$id');
  }

  @override
  Future<LeadModel> updateLeadStatus(String id, LeadStatus status) async {
    final response = await _apiClient.patch(
      '${ApiConfig.leads}/$id/status',
      data: {'status': status.value},
    );
    return LeadModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<LeadModel> recordCallOutcome(String id, Map<String, dynamic> data) async {
    final response = await _apiClient.post(
      '${ApiConfig.leads}/$id/call-outcome',
      data: data,
    );
    return LeadModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<LeadModel> assignDoctor(String id, String doctorId, String doctorName) async {
    final response = await _apiClient.post(
      '${ApiConfig.leads}/$id/assign-doctor',
      data: {
        'doctor_id': doctorId,
        'doctor_name': doctorName,
      },
    );
    return LeadModel.fromJson(response.data['data'] ?? response.data);
  }
}

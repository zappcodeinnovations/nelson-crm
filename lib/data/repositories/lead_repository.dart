import '../models/lead_model.dart';
import '../models/enums/lead_status.dart';

/// Lead repository interface.
abstract class LeadRepository {
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
  });
  Future<LeadModel> getLeadById(String id);
  Future<LeadModel> createLead(Map<String, dynamic> data);
  Future<LeadModel> updateLead(String id, Map<String, dynamic> data);
  Future<void> deleteLead(String id);
  Future<LeadModel> updateLeadStatus(String id, LeadStatus status);
  Future<LeadModel> recordCallOutcome(String id, Map<String, dynamic> data);
  Future<LeadModel> assignDoctor(String id, String doctorId, String doctorName);
}

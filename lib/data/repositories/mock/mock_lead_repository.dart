import '../../models/lead_model.dart';
import '../../models/enums/lead_status.dart';
import '../../models/enums/lead_source.dart';
import '../../models/enums/department.dart';
import '../lead_repository.dart';

/// Mock lead repository with realistic test data.
class MockLeadRepository implements LeadRepository {
  final List<LeadModel> _leads = _generateMockLeads();

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
    await Future.delayed(const Duration(milliseconds: 400));
    var filtered = List<LeadModel>.from(_leads);

    if (status != null) {
      filtered = filtered.where((l) => l.status == status).toList();
    }
    if (search != null && search.isNotEmpty) {
      final q = search.toLowerCase();
      filtered = filtered.where((l) =>
        l.name.toLowerCase().contains(q) ||
        l.phone.contains(q) ||
        l.id.toLowerCase().contains(q)
      ).toList();
    }
    if (source != null) {
      filtered = filtered.where((l) => l.source.value == source).toList();
    }
    if (department != null) {
      filtered = filtered.where((l) => l.department?.value == department).toList();
    }

    final start = (page - 1) * perPage;
    if (start >= filtered.length) return [];
    final end = (start + perPage).clamp(0, filtered.length);
    return filtered.sublist(start, end);
  }

  @override
  Future<LeadModel> getLeadById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _leads.firstWhere((l) => l.id == id);
  }

  @override
  Future<LeadModel> createLead(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final lead = LeadModel(
      id: 'NL-${10246 + _leads.length}',
      name: data['name'] as String,
      phone: data['phone'] as String,
      email: data['email'] as String?,
      age: data['age'] as int?,
      gender: data['gender'] as String?,
      city: data['city'] as String?,
      requirement: data['requirement'] as String? ?? '',
      requirementCategory: data['requirement_category'] as String?,
      source: LeadSource.fromString(data['source'] as String? ?? 'OTHER'),
      entryType: EntryType.fromString(data['entry_type'] as String? ?? 'MANUAL'),
      campaign: data['campaign'] as String?,
      department: data['department'] != null ? Department.fromString(data['department'] as String) : null,
      branch: 'Nelson Hospital - Dhantoli',
      assignedStaffName: 'Rahul Sharma',
      status: LeadStatus.newLead,
      priority: LeadPriority.fromString(data['priority'] as String? ?? 'MEDIUM'),
      createdBy: 'Rahul Sharma',
      createdAt: DateTime.now(),
    );
    _leads.insert(0, lead);
    return lead;
  }

  @override
  Future<LeadModel> updateLead(String id, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final index = _leads.indexWhere((l) => l.id == id);
    if (index == -1) throw Exception('Lead not found');
    // Return existing lead (simplified mock)
    return _leads[index];
  }

  @override
  Future<void> deleteLead(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _leads.removeWhere((l) => l.id == id);
  }

  @override
  Future<LeadModel> updateLeadStatus(String id, LeadStatus status) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _leads.indexWhere((l) => l.id == id);
    if (index == -1) throw Exception('Lead not found');
    _leads[index] = _leads[index].copyWith(status: status);
    return _leads[index];
  }

  @override
  Future<LeadModel> recordCallOutcome(String id, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final index = _leads.indexWhere((l) => l.id == id);
    if (index == -1) throw Exception('Lead not found');
    _leads[index] = _leads[index].copyWith(
      status: LeadStatus.contacted,
      lastCalledAt: DateTime.now(),
      calledBy: 'Rahul Sharma',
      callResult: data['call_result'] as String?,
      remark1: data['remark1'] as String?,
      remark2: data['remark2'] as String?,
    );
    return _leads[index];
  }

  @override
  Future<LeadModel> assignDoctor(String id, String doctorId, String doctorName) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final index = _leads.indexWhere((l) => l.id == id);
    if (index == -1) throw Exception('Lead not found');
    _leads[index] = _leads[index].copyWith(
      status: LeadStatus.doctorAssignment,
      assignedDoctorId: doctorId,
      assignedDoctorName: doctorName,
    );
    return _leads[index];
  }

  static List<LeadModel> _generateMockLeads() {
    final now = DateTime.now();
    return [
      LeadModel(id: 'NL-10245', name: 'Amit Sharma', phone: '9876543210', requirement: 'Need consultation for neurological treatment', source: LeadSource.whatsApp, entryType: EntryType.manual, department: Department.neurology, status: LeadStatus.newLead, priority: LeadPriority.high, createdBy: 'Rahul Sharma', createdAt: now.subtract(const Duration(minutes: 15)), branch: 'Nelson Hospital - Dhantoli', assignedStaffName: 'Rahul Sharma'),
      LeadModel(id: 'NL-10244', name: 'Meera Patel', phone: '9876543211', requirement: 'Gynecology consultation needed', source: LeadSource.instagram, entryType: EntryType.automatic, department: Department.gynecology, status: LeadStatus.followUp, priority: LeadPriority.high, createdBy: 'System', createdAt: now.subtract(const Duration(hours: 2)), branch: 'Nelson Hospital - Dhantoli', assignedStaffName: 'Rahul Sharma', nextFollowUpAt: now.add(const Duration(hours: 1))),
      LeadModel(id: 'NL-10243', name: 'Raj Kumar', phone: '9876543212', requirement: 'Orthopedic surgery cost enquiry', source: LeadSource.website, entryType: EntryType.automatic, department: Department.orthopedics, status: LeadStatus.contacted, priority: LeadPriority.medium, createdBy: 'System', createdAt: now.subtract(const Duration(hours: 3)), branch: 'Nelson Hospital - Dhantoli', assignedStaffName: 'Priya Patel', remark1: 'Patient interested in surgery'),
      LeadModel(id: 'NL-10242', name: 'Sunita Devi', phone: '9876543213', requirement: 'Women care health package', source: LeadSource.whatsApp, entryType: EntryType.manual, department: Department.womenCare, status: LeadStatus.interested, priority: LeadPriority.medium, createdBy: 'Neha Gupta', createdAt: now.subtract(const Duration(hours: 4)), branch: 'Nelson Hospital - Ramdaspeth', assignedStaffName: 'Neha Gupta'),
      LeadModel(id: 'NL-10241', name: 'Vikram Singh', phone: '9876543214', requirement: 'Cardiology check-up', source: LeadSource.facebook, entryType: EntryType.automatic, department: Department.cardiology, status: LeadStatus.doctorAssignment, priority: LeadPriority.high, createdBy: 'System', createdAt: now.subtract(const Duration(hours: 5)), branch: 'Nelson Hospital - Dhantoli', assignedStaffName: 'Rahul Sharma'),
      LeadModel(id: 'NL-10240', name: 'Priti Agarwal', phone: '9876543215', requirement: 'Pediatric consultation for child', source: LeadSource.whatsApp, entryType: EntryType.manual, department: Department.pediatrics, status: LeadStatus.appointmentScheduled, priority: LeadPriority.medium, createdBy: 'Priya Patel', createdAt: now.subtract(const Duration(hours: 6)), branch: 'Nelson Hospital - Dhantoli', assignedStaffName: 'Priya Patel', assignedDoctorName: 'Dr. Shalini Mehta'),
      LeadModel(id: 'NL-10239', name: 'Mohan Verma', phone: '9876543216', requirement: 'ENT specialist consultation', source: LeadSource.google, entryType: EntryType.automatic, department: Department.ent, status: LeadStatus.noResponse, priority: LeadPriority.low, createdBy: 'System', createdAt: now.subtract(const Duration(hours: 8)), branch: 'Nelson Hospital - Dhantoli', assignedStaffName: 'Rahul Sharma', noAnswerReason: 'Phone Switched Off'),
      LeadModel(id: 'NL-10238', name: 'Anita Joshi', phone: '9876543217', requirement: 'Ophthalmology check-up', source: LeadSource.referral, entryType: EntryType.manual, department: Department.ophthalmology, status: LeadStatus.converted, priority: LeadPriority.medium, createdBy: 'Neha Gupta', createdAt: now.subtract(const Duration(days: 1)), branch: 'Nelson Hospital - Ramdaspeth', assignedStaffName: 'Neha Gupta', assignedDoctorName: 'Dr. Rajiv Kumar'),
      LeadModel(id: 'NL-10237', name: 'Deepak Mishra', phone: '9876543218', requirement: 'Gastroenterology treatment', source: LeadSource.whatsApp, entryType: EntryType.manual, department: Department.gastroenterology, status: LeadStatus.assigned, priority: LeadPriority.medium, createdBy: 'Rahul Sharma', createdAt: now.subtract(const Duration(days: 1, hours: 2)), branch: 'Nelson Hospital - Dhantoli', assignedStaffName: 'Rahul Sharma'),
      LeadModel(id: 'NL-10236', name: 'Kavita Sharma', phone: '9876543219', requirement: 'Urology consultation', source: LeadSource.whatsApp, entryType: EntryType.manual, department: Department.urology, status: LeadStatus.newLead, priority: LeadPriority.medium, createdBy: 'Priya Patel', createdAt: now.subtract(const Duration(days: 1, hours: 4)), branch: 'Nelson Hospital - Dhantoli', assignedStaffName: 'Priya Patel'),
      LeadModel(id: 'NL-10235', name: 'Ramesh Gupta', phone: '9876543220', requirement: 'General medicine consultation', source: LeadSource.walkIn, entryType: EntryType.manual, department: Department.generalMedicine, status: LeadStatus.visited, priority: LeadPriority.low, createdBy: 'Priya Patel', createdAt: now.subtract(const Duration(days: 2)), branch: 'Nelson Hospital - Dhantoli', assignedStaffName: 'Priya Patel'),
      LeadModel(id: 'NL-10234', name: 'Sonia Mehta', phone: '9876543221', requirement: 'Physiotherapy sessions', source: LeadSource.instagram, entryType: EntryType.automatic, department: Department.physiotherapy, status: LeadStatus.newLead, priority: LeadPriority.low, createdBy: 'System', createdAt: now.subtract(const Duration(minutes: 30)), branch: 'Nelson Hospital - Ramdaspeth', assignedStaffName: 'Neha Gupta'),
      LeadModel(id: 'NL-10233', name: 'Arjun Reddy', phone: '9876543222', requirement: 'Neuroscience evaluation', source: LeadSource.whatsApp, entryType: EntryType.manual, department: Department.neuroscience, status: LeadStatus.connected, priority: LeadPriority.high, createdBy: 'Rahul Sharma', createdAt: now.subtract(const Duration(hours: 1)), branch: 'Nelson Hospital - Dhantoli', assignedStaffName: 'Rahul Sharma'),
      LeadModel(id: 'NL-10232', name: 'Lakshmi Iyer', phone: '9876543223', requirement: 'Oncology second opinion', source: LeadSource.doctorReferral, entryType: EntryType.manual, department: Department.oncology, status: LeadStatus.appointmentConfirmed, priority: LeadPriority.high, createdBy: 'Priya Patel', createdAt: now.subtract(const Duration(days: 1, hours: 6)), branch: 'Nelson Hospital - Dhantoli', assignedStaffName: 'Priya Patel', assignedDoctorName: 'Dr. Vijay Patel'),
      LeadModel(id: 'NL-10231', name: 'Suresh Yadav', phone: '9876543224', requirement: 'Radiology diagnostic', source: LeadSource.website, entryType: EntryType.automatic, department: Department.radiology, status: LeadStatus.notInterested, priority: LeadPriority.low, createdBy: 'System', createdAt: now.subtract(const Duration(days: 2, hours: 3)), branch: 'Nelson Hospital - Dhantoli', assignedStaffName: 'Rahul Sharma'),
      LeadModel(id: 'NL-10230', name: 'Pooja Nair', phone: '9876543225', requirement: 'Gynecology health package', source: LeadSource.instagram, entryType: EntryType.automatic, department: Department.gynecology, status: LeadStatus.newLead, priority: LeadPriority.medium, createdBy: 'System', createdAt: now.subtract(const Duration(minutes: 45)), branch: 'Nelson Hospital - Dhantoli', assignedStaffName: 'Rahul Sharma'),
      LeadModel(id: 'NL-10229', name: 'Arun Desai', phone: '9876543226', requirement: 'General surgery consultation', source: LeadSource.phone, entryType: EntryType.manual, department: Department.generalSurgery, status: LeadStatus.followUp, priority: LeadPriority.medium, createdBy: 'Neha Gupta', createdAt: now.subtract(const Duration(days: 1)), branch: 'Nelson Hospital - Ramdaspeth', assignedStaffName: 'Neha Gupta', nextFollowUpAt: now.add(const Duration(hours: 3))),
      LeadModel(id: 'NL-10228', name: 'Nisha Pandey', phone: '9876543227', requirement: 'Critical care admission enquiry', source: LeadSource.whatsApp, entryType: EntryType.manual, department: Department.criticalCare, status: LeadStatus.newLead, priority: LeadPriority.high, createdBy: 'Rahul Sharma', createdAt: now.subtract(const Duration(minutes: 10)), branch: 'Nelson Hospital - Dhantoli', assignedStaffName: 'Rahul Sharma'),
      LeadModel(id: 'NL-10227', name: 'Manoj Tiwari', phone: '9876543228', requirement: 'Urology treatment plan', source: LeadSource.facebook, entryType: EntryType.automatic, department: Department.urology, status: LeadStatus.lost, priority: LeadPriority.low, createdBy: 'System', createdAt: now.subtract(const Duration(days: 3)), branch: 'Nelson Hospital - Dhantoli', assignedStaffName: 'Priya Patel'),
      LeadModel(id: 'NL-10226', name: 'Geeta Saxena', phone: '9876543229', requirement: 'Pathology tests enquiry', source: LeadSource.existingPatient, entryType: EntryType.manual, department: Department.pathology, status: LeadStatus.contacted, priority: LeadPriority.low, createdBy: 'Priya Patel', createdAt: now.subtract(const Duration(days: 1, hours: 8)), branch: 'Nelson Hospital - Dhantoli', assignedStaffName: 'Priya Patel'),
    ];
  }
}

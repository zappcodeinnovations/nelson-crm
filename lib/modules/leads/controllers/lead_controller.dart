import 'package:get/get.dart';
import '../../../data/models/lead_model.dart';
import '../../../data/models/enums/lead_status.dart';
import '../../../data/repositories/lead_repository.dart';
import '../../../core/utils/snackbar_utils.dart';

/// Lead list controller with tabs, search, filters, and pagination.
class LeadListController extends GetxController with GetSingleTickerProviderStateMixin {
  late final LeadRepository _repo;

  final leads = <LeadModel>[].obs;
  final isLoading = true.obs;
  final isLoadingMore = false.obs;
  final searchQuery = ''.obs;
  final selectedStatus = Rxn<LeadStatus>();
  final currentPage = 1.obs;
  final hasMore = true.obs;

  final statusTabs = [
    null, // All
    LeadStatus.newLead,
    LeadStatus.assigned,
    LeadStatus.contacted,
    LeadStatus.connected,
    LeadStatus.followUp,
    LeadStatus.doctorAssignment,
    LeadStatus.appointmentScheduled,
    LeadStatus.visited,
    LeadStatus.converted,
    LeadStatus.lost,
  ];

  final tabLabels = [
    'All', 'New', 'Assigned', 'Contacted', 'Connected',
    'Follow-up', 'Dr. Assign', 'Appt.', 'Visited', 'Converted', 'Lost',
  ];

  @override
  void onInit() {
    super.onInit();
    _repo = Get.find<LeadRepository>();
    loadLeads();
  }

  Future<void> loadLeads() async {
    isLoading.value = true;
    currentPage.value = 1;
    try {
      final result = await _repo.getLeads(
        page: 1,
        status: selectedStatus.value,
        search: searchQuery.value,
      );
      leads.value = result;
      hasMore.value = result.length >= 20;
    } catch (e) {
      SnackbarUtils.showError('Unable to load leads.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMore.value) return;
    isLoadingMore.value = true;
    try {
      currentPage.value++;
      final result = await _repo.getLeads(
        page: currentPage.value,
        status: selectedStatus.value,
        search: searchQuery.value,
      );
      leads.addAll(result);
      hasMore.value = result.length >= 20;
    } catch (e) {
      currentPage.value--;
    } finally {
      isLoadingMore.value = false;
    }
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    loadLeads();
  }

  void onStatusChanged(LeadStatus? status) {
    selectedStatus.value = status;
    loadLeads();
  }

  Future<void> refresh() async {
    await loadLeads();
  }
}

/// Lead detail controller.
class LeadDetailController extends GetxController {
  late final LeadRepository _repo;
  final lead = Rxn<LeadModel>();
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _repo = Get.find<LeadRepository>();
    final leadId = Get.arguments?['leadId'] as String?;
    final passedLead = Get.arguments?['lead'] as LeadModel?;
    if (passedLead != null) {
      lead.value = passedLead;
      isLoading.value = false;
    } else if (leadId != null) {
      _loadLead(leadId);
    }
  }

  Future<void> _loadLead(String id) async {
    isLoading.value = true;
    try {
      lead.value = await _repo.getLeadById(id);
    } catch (e) {
      SnackbarUtils.showError('Unable to load lead details.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateStatus(LeadStatus status) async {
    try {
      lead.value = await _repo.updateLeadStatus(lead.value!.id, status);
      SnackbarUtils.showSuccess('Lead status updated.');
    } catch (e) {
      SnackbarUtils.showError('Unable to update lead status.');
    }
  }
}

/// Add lead controller.
class AddLeadController extends GetxController {
  late final LeadRepository _repo;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _repo = Get.find<LeadRepository>();
  }

  Future<bool> createLead(Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      await _repo.createLead(data);
      SnackbarUtils.showSuccess('Lead created successfully!');
      return true;
    } catch (e) {
      SnackbarUtils.showError('Unable to create lead.');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}

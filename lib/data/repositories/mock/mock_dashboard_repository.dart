import '../dashboard_repository.dart';

class MockDashboardRepository implements DashboardRepository {
  @override
  Future<Map<String, dynamic>> getStats() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return {
      'newLeadsCount': 5,
      'callsPendingCount': 3,
      'followUpsCount': 4,
      'overdueCount': 2,
      'doctorAssignmentsCount': 1,
      'appointmentsCount': 6,
      'totalLeadsToday': 20,
      'departmentStats': [
        {'name': 'Gynecology', 'count': 10, 'percentage': 50.0},
        {'name': 'Neurology', 'count': 5, 'percentage': 25.0},
        {'name': 'Urology', 'count': 5, 'percentage': 25.0},
      ],
      'sourceStats': [
        {'name': 'WhatsApp', 'count': 10, 'percentage': 50.0},
        {'name': 'Instagram', 'count': 4, 'percentage': 20.0},
        {'name': 'Website', 'count': 3, 'percentage': 15.0},
        {'name': 'Facebook', 'count': 2, 'percentage': 10.0},
        {'name': 'Google', 'count': 1, 'percentage': 5.0},
      ],
      'staffWorkload': [
        {'name': 'Rahul', 'count': 5},
        {'name': 'Priya', 'count': 4},
        {'name': 'Amit', 'count': 6},
        {'name': 'Neha', 'count': 5},
      ],
    };
  }
}

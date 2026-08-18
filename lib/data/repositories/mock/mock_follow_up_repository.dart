import '../follow_up_repository.dart';

class MockFollowUpRepository implements FollowUpRepository {
  @override
  Future<Map<String, List<Map<String, dynamic>>>> getFollowUps() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'today': [
        {'patientName': 'Amit Sharma', 'department': 'Neurology', 'type': 'Call', 'time': '10:30 AM', 'status': 'Scheduled', 'isOverdue': false},
        {'patientName': 'Meera Patel', 'department': 'Gynecology', 'type': 'WhatsApp', 'time': '02:00 PM', 'status': 'Scheduled', 'isOverdue': false},
      ],
      'upcoming': [
        {'patientName': 'Raj Kumar', 'department': 'Orthopedics', 'type': 'Call', 'time': 'Tomorrow 11:00 AM', 'status': 'Scheduled', 'isOverdue': false},
        {'patientName': 'Arun Desai', 'department': 'General Surgery', 'type': 'Visit', 'time': '16 Aug 03:00 PM', 'status': 'Scheduled', 'isOverdue': false},
      ],
      'overdue': [
        {'patientName': 'Sunita Devi', 'department': 'Women Care', 'type': 'Call', 'time': 'Yesterday 04:00 PM', 'status': 'Overdue', 'isOverdue': true},
        {'patientName': 'Arjun Reddy', 'department': 'Neuroscience', 'type': 'Call', 'time': '12 Aug 10:00 AM', 'status': 'Overdue', 'isOverdue': true},
      ],
      'completed': [
        {'patientName': 'Anita Joshi', 'department': 'Ophthalmology', 'type': 'Call', 'time': 'Today 09:00 AM', 'status': 'Completed', 'isOverdue': false},
      ]
    };
  }
}

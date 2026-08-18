import '../appointment_repository.dart';

class MockAppointmentRepository implements AppointmentRepository {
  @override
  Future<List<Map<String, dynamic>>> getAppointments() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      {'patientName': 'Amit Sharma', 'doctor': 'Dr. Amit Sharma', 'department': 'Neurology', 'day': '14', 'month': 'Aug', 'time': '05:00 PM', 'status': 'Scheduled'},
      {'patientName': 'Priti Agarwal', 'doctor': 'Dr. Shalini Mehta', 'department': 'Pediatrics', 'day': '14', 'month': 'Aug', 'time': '03:00 PM', 'status': 'Confirmed'},
      {'patientName': 'Lakshmi Iyer', 'doctor': 'Dr. Vijay Patel', 'department': 'Oncology', 'day': '15', 'month': 'Aug', 'time': '11:00 AM', 'status': 'Confirmed'},
      {'patientName': 'Raj Kumar', 'doctor': 'Dr. Suresh Rao', 'department': 'Orthopedics', 'day': '15', 'month': 'Aug', 'time': '02:30 PM', 'status': 'Scheduled'},
      {'patientName': 'Meera Patel', 'doctor': 'Dr. Shalini Mehta', 'department': 'Gynecology', 'day': '16', 'month': 'Aug', 'time': '10:00 AM', 'status': 'Scheduled'},
    ];
  }
}

import '../doctor_repository.dart';

class MockDoctorRepository implements DoctorRepository {
  @override
  Future<List<Map<String, dynamic>>> getDoctors() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      {'name': 'Dr. Amit Sharma', 'department': 'Neurology', 'schedule': 'Mon-Sat, 05:00 PM - 08:00 PM', 'availability': 'Available'},
      {'name': 'Dr. Shalini Mehta', 'department': 'Gynecology', 'schedule': 'Mon-Fri, 10:00 AM - 02:00 PM', 'availability': 'Available'},
      {'name': 'Dr. Rajiv Kumar', 'department': 'Ophthalmology', 'schedule': 'Mon-Sat, 09:00 AM - 01:00 PM', 'availability': 'On Leave'},
      {'name': 'Dr. Vijay Patel', 'department': 'Oncology', 'schedule': 'Tue-Sat, 11:00 AM - 04:00 PM', 'availability': 'Available'},
      {'name': 'Dr. Priya Nair', 'department': 'Neurology', 'schedule': 'Mon-Fri, 10:00 AM - 02:00 PM', 'availability': 'Busy'},
      {'name': 'Dr. Suresh Rao', 'department': 'Cardiology', 'schedule': 'Mon-Sat, 08:00 AM - 12:00 PM', 'availability': 'Available'},
      {'name': 'Dr. Anita Deshmukh', 'department': 'Pediatrics', 'schedule': 'Mon-Fri, 04:00 PM - 08:00 PM', 'availability': 'Available'},
    ];
  }
}

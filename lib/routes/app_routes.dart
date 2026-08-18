/// Named route constants for the application.
abstract class AppRoutes {
  // Auth
  static const String splash = '/splash';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String forgotPassword = '/forgot-password';

  // Main
  static const String home = '/home';
  static const String dashboard = '/dashboard';

  // Leads
  static const String leads = '/leads';
  static const String leadDetail = '/leads/detail';
  static const String addLead = '/leads/add';
  static const String whatsappLead = '/leads/whatsapp';

  // Calls
  static const String callOutcome = '/calls/outcome';

  // Follow-ups
  static const String followUps = '/followups';
  static const String followUpDetail = '/followups/detail';
  static const String scheduleFollowUp = '/followups/schedule';

  // Doctors
  static const String doctors = '/doctors';
  static const String doctorDetail = '/doctors/detail';
  static const String doctorAvailability = '/doctors/availability';
  static const String doctorAssignment = '/doctors/assignment';
  static const String consultation = '/doctors/consultation';

  // Appointments
  static const String appointments = '/appointments';
  static const String appointmentDetail = '/appointments/detail';
  static const String bookAppointment = '/appointments/book';

  // Patients
  static const String patients = '/patients';
  static const String patientDetail = '/patients/detail';

  // Shifts
  static const String shiftHandover = '/shifts/handover';

  // Analytics
  static const String analytics = '/analytics';

  // Notifications
  static const String notifications = '/notifications';

  // Profile
  static const String profile = '/profile';
  static const String settings = '/settings';
}

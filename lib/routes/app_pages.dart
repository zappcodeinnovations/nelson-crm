import 'package:get/get.dart';
import 'app_routes.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/splash_view.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/otp_view.dart';
import '../modules/auth/views/forgot_password_view.dart';
import '../modules/shell/views/main_shell_view.dart';
import '../modules/shell/bindings/shell_binding.dart';
import '../modules/leads/views/lead_list_view.dart';
import '../modules/leads/views/lead_detail_view.dart';
import '../modules/leads/views/add_lead_view.dart';
import '../modules/leads/views/whatsapp_lead_view.dart';
import '../modules/leads/bindings/lead_binding.dart';
import '../modules/calls/views/call_outcome_view.dart';
import '../modules/calls/bindings/call_binding.dart';
import '../modules/followups/views/follow_up_list_view.dart';
import '../modules/followups/views/schedule_follow_up_view.dart';
import '../modules/followups/bindings/follow_up_binding.dart';
import '../modules/doctors/views/doctor_list_view.dart';
import '../modules/doctors/views/doctor_availability_view.dart';
import '../modules/doctors/views/doctor_assignment_view.dart';
import '../modules/doctors/views/consultation_view.dart';
import '../modules/doctors/bindings/doctor_binding.dart';
import '../modules/appointments/views/appointment_list_view.dart';
import '../modules/appointments/views/appointment_detail_view.dart';
import '../modules/appointments/views/book_appointment_view.dart';
import '../modules/appointments/bindings/appointment_binding.dart';
import '../modules/patients/views/patient_list_view.dart';
import '../modules/patients/views/patient_detail_view.dart';
import '../modules/patients/bindings/patient_binding.dart';
import '../modules/shifts/views/shift_handover_view.dart';
import '../modules/shifts/bindings/shift_binding.dart';
import '../modules/analytics/views/analytics_view.dart';
import '../modules/analytics/bindings/analytics_binding.dart';
import '../modules/notifications/views/notification_list_view.dart';
import '../modules/notifications/bindings/notification_binding.dart';
import '../modules/profile/views/profile_view.dart';

/// GetPage definitions with bindings.
class AppPages {
  static final pages = <GetPage>[
    // Auth
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordView(),
    ),

    // Main Shell
    GetPage(
      name: AppRoutes.home,
      page: () => const MainShellView(),
      binding: ShellBinding(),
    ),

    // Leads
    GetPage(
      name: AppRoutes.leads,
      page: () => const LeadListView(),
      binding: LeadBinding(),
    ),
    GetPage(
      name: AppRoutes.leadDetail,
      page: () => const LeadDetailView(),
      binding: LeadBinding(),
    ),
    GetPage(
      name: AppRoutes.addLead,
      page: () => const AddLeadView(),
      binding: LeadBinding(),
    ),
    GetPage(
      name: AppRoutes.whatsappLead,
      page: () => const WhatsAppLeadView(),
      binding: LeadBinding(),
    ),

    // Calls
    GetPage(
      name: AppRoutes.callOutcome,
      page: () => const CallOutcomeView(),
      binding: CallBinding(),
    ),

    // Follow-ups
    GetPage(
      name: AppRoutes.followUps,
      page: () => const FollowUpListView(),
      binding: FollowUpBinding(),
    ),
    GetPage(
      name: AppRoutes.scheduleFollowUp,
      page: () => const ScheduleFollowUpView(),
      binding: FollowUpBinding(),
    ),

    // Doctors
    GetPage(
      name: AppRoutes.doctors,
      page: () => const DoctorListView(),
      binding: DoctorBinding(),
    ),
    GetPage(
      name: AppRoutes.doctorAvailability,
      page: () => const DoctorAvailabilityView(),
      binding: DoctorBinding(),
    ),
    GetPage(
      name: AppRoutes.doctorAssignment,
      page: () => const DoctorAssignmentView(),
      binding: DoctorBinding(),
    ),
    GetPage(
      name: AppRoutes.consultation,
      page: () => const ConsultationView(),
      binding: DoctorBinding(),
    ),

    // Appointments
    GetPage(
      name: AppRoutes.appointments,
      page: () => const AppointmentListView(),
      binding: AppointmentBinding(),
    ),
    GetPage(
      name: AppRoutes.appointmentDetail,
      page: () => const AppointmentDetailView(),
      binding: AppointmentBinding(),
    ),
    GetPage(
      name: AppRoutes.bookAppointment,
      page: () => const BookAppointmentView(),
      binding: AppointmentBinding(),
    ),

    // Patients
    GetPage(
      name: AppRoutes.patients,
      page: () => const PatientListView(),
      binding: PatientBinding(),
    ),
    GetPage(
      name: AppRoutes.patientDetail,
      page: () => const PatientDetailView(),
      binding: PatientBinding(),
    ),

    // Shifts
    GetPage(
      name: AppRoutes.shiftHandover,
      page: () => const ShiftHandoverView(),
      binding: ShiftBinding(),
    ),

    // Analytics
    GetPage(
      name: AppRoutes.analytics,
      page: () => const AnalyticsView(),
      binding: AnalyticsBinding(),
    ),

    // Notifications
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationListView(),
      binding: NotificationBinding(),
    ),

    // Profile
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
    ),
  ];
}

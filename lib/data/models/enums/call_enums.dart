/// Call result outcomes.
enum CallResult {
  interested('INTERESTED', 'Interested'),
  appointmentRequired('APPOINTMENT_REQUIRED', 'Appointment Required'),
  informationRequested('INFORMATION_REQUESTED', 'Information Requested'),
  callBackLater('CALL_BACK_LATER', 'Call Back Later'),
  notInterested('NOT_INTERESTED', 'Not Interested'),
  requirementFulfilled('REQUIREMENT_FULFILLED', 'Requirement Fulfilled'),
  other('OTHER', 'Other');

  final String value;
  final String label;
  const CallResult(this.value, this.label);

  static CallResult fromString(String value) {
    return CallResult.values.firstWhere(
      (r) => r.value == value,
      orElse: () => CallResult.other,
    );
  }
}

/// No-answer reason codes.
enum NoAnswerReason {
  switchedOff('SWITCHED_OFF', 'Phone Switched Off'),
  busy('BUSY', 'Busy'),
  noResponse('NO_RESPONSE', 'No Response'),
  callRejected('CALL_REJECTED', 'Call Rejected'),
  notReachable('NOT_REACHABLE', 'Number Not Reachable'),
  outOfNetwork('OUT_OF_NETWORK', 'Out of Network'),
  wrongNumber('WRONG_NUMBER', 'Wrong Number'),
  invalidNumber('INVALID_NUMBER', 'Invalid Number'),
  other('OTHER', 'Other');

  final String value;
  final String label;
  const NoAnswerReason(this.value, this.label);

  static NoAnswerReason fromString(String value) {
    return NoAnswerReason.values.firstWhere(
      (r) => r.value == value,
      orElse: () => NoAnswerReason.other,
    );
  }
}

/// Next action after a call.
enum NextAction {
  noFollowUp('NO_FOLLOW_UP', 'No Follow-up'),
  scheduleFollowUp('SCHEDULE_FOLLOW_UP', 'Schedule Follow-up'),
  bookAppointment('BOOK_APPOINTMENT', 'Book Appointment'),
  assignDoctor('ASSIGN_DOCTOR', 'Assign Doctor'),
  sendInformation('SEND_INFORMATION', 'Send Information');

  final String value;
  final String label;
  const NextAction(this.value, this.label);

  static NextAction fromString(String value) {
    return NextAction.values.firstWhere(
      (a) => a.value == value,
      orElse: () => NextAction.noFollowUp,
    );
  }
}

/// Follow-up status.
enum FollowUpStatus {
  scheduled('SCHEDULED', 'Scheduled'),
  completed('COMPLETED', 'Completed'),
  overdue('OVERDUE', 'Overdue'),
  cancelled('CANCELLED', 'Cancelled'),
  rescheduled('RESCHEDULED', 'Rescheduled');

  final String value;
  final String label;
  const FollowUpStatus(this.value, this.label);

  static FollowUpStatus fromString(String value) {
    return FollowUpStatus.values.firstWhere(
      (s) => s.value == value,
      orElse: () => FollowUpStatus.scheduled,
    );
  }
}

/// Follow-up type.
enum FollowUpType {
  call('CALL', 'Call'),
  whatsApp('WHATSAPP', 'WhatsApp'),
  email('EMAIL', 'Email'),
  visit('VISIT', 'Visit'),
  other('OTHER', 'Other');

  final String value;
  final String label;
  const FollowUpType(this.value, this.label);

  static FollowUpType fromString(String value) {
    return FollowUpType.values.firstWhere(
      (t) => t.value == value,
      orElse: () => FollowUpType.call,
    );
  }
}

/// Appointment status.
enum AppointmentStatus {
  scheduled('SCHEDULED', 'Scheduled'),
  confirmed('CONFIRMED', 'Confirmed'),
  arrived('ARRIVED', 'Arrived'),
  inProgress('IN_PROGRESS', 'In Progress'),
  completed('COMPLETED', 'Completed'),
  noShow('NO_SHOW', 'No Show'),
  cancelled('CANCELLED', 'Cancelled'),
  rescheduled('RESCHEDULED', 'Rescheduled');

  final String value;
  final String label;
  const AppointmentStatus(this.value, this.label);

  static AppointmentStatus fromString(String value) {
    return AppointmentStatus.values.firstWhere(
      (s) => s.value == value,
      orElse: () => AppointmentStatus.scheduled,
    );
  }
}

/// Doctor availability status.
enum DoctorAvailability {
  available('AVAILABLE', 'Available'),
  busy('BUSY', 'Busy'),
  onLeave('ON_LEAVE', 'On Leave'),
  unavailable('UNAVAILABLE', 'Unavailable');

  final String value;
  final String label;
  const DoctorAvailability(this.value, this.label);

  static DoctorAvailability fromString(String value) {
    return DoctorAvailability.values.firstWhere(
      (a) => a.value == value,
      orElse: () => DoctorAvailability.unavailable,
    );
  }
}

/// Notification types.
enum NotificationType {
  newLead('NEW_LEAD', 'New Lead'),
  followUpDue('FOLLOW_UP_DUE', 'Follow-up Due'),
  followUpOverdue('FOLLOW_UP_OVERDUE', 'Follow-up Overdue'),
  appointmentReminder('APPOINTMENT_REMINDER', 'Appointment Reminder'),
  doctorAvailable('DOCTOR_AVAILABLE', 'Doctor Available'),
  appointmentConfirmed('APPOINTMENT_CONFIRMED', 'Appointment Confirmed'),
  shiftHandover('SHIFT_HANDOVER', 'Shift Handover'),
  leadAssigned('LEAD_ASSIGNED', 'Lead Assigned');

  final String value;
  final String label;
  const NotificationType(this.value, this.label);

  static NotificationType fromString(String value) {
    return NotificationType.values.firstWhere(
      (t) => t.value == value,
      orElse: () => NotificationType.newLead,
    );
  }
}

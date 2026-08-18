import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Lead status progression.
enum LeadStatus {
  newLead('NEW', 'New'),
  assigned('ASSIGNED', 'Assigned'),
  contacted('CONTACTED', 'Contacted'),
  connected('CONNECTED', 'Connected'),
  followUp('FOLLOW_UP', 'Follow Up'),
  interested('INTERESTED', 'Interested'),
  doctorAssignment('DOCTOR_ASSIGNMENT', 'Doctor Assignment'),
  appointmentScheduled('APPOINTMENT_SCHEDULED', 'Appt. Scheduled'),
  appointmentConfirmed('APPOINTMENT_CONFIRMED', 'Appt. Confirmed'),
  visited('VISITED', 'Visited'),
  converted('CONVERTED', 'Converted'),
  notInterested('NOT_INTERESTED', 'Not Interested'),
  noResponse('NO_RESPONSE', 'No Response'),
  lost('LOST', 'Lost');

  final String value;
  final String label;
  const LeadStatus(this.value, this.label);

  static LeadStatus fromString(String value) {
    return LeadStatus.values.firstWhere(
      (s) => s.value == value,
      orElse: () => LeadStatus.newLead,
    );
  }

  Color get color {
    switch (this) {
      case LeadStatus.newLead:
        return NelsonColors.statusNew;
      case LeadStatus.assigned:
        return NelsonColors.statusAssigned;
      case LeadStatus.contacted:
        return NelsonColors.statusContacted;
      case LeadStatus.connected:
        return NelsonColors.statusConnected;
      case LeadStatus.followUp:
        return NelsonColors.statusFollowUp;
      case LeadStatus.interested:
        return NelsonColors.statusInterested;
      case LeadStatus.doctorAssignment:
        return NelsonColors.primaryBlue;
      case LeadStatus.appointmentScheduled:
        return NelsonColors.primaryBlue;
      case LeadStatus.appointmentConfirmed:
        return NelsonColors.successGreen;
      case LeadStatus.visited:
        return NelsonColors.greenDark;
      case LeadStatus.converted:
        return NelsonColors.statusConverted;
      case LeadStatus.notInterested:
        return NelsonColors.statusLost;
      case LeadStatus.noResponse:
        return NelsonColors.statusNoResponse;
      case LeadStatus.lost:
        return NelsonColors.statusLost;
    }
  }

  Color get backgroundColor => color.withValues(alpha: 0.1);

  bool get isActive =>
      this != LeadStatus.notInterested &&
      this != LeadStatus.noResponse &&
      this != LeadStatus.lost &&
      this != LeadStatus.converted;
}

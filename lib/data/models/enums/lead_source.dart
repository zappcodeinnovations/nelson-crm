import 'package:flutter/material.dart';

/// Lead source channels.
enum LeadSource {
  instagram('INSTAGRAM', 'Instagram', Icons.camera_alt_outlined),
  facebook('FACEBOOK', 'Facebook', Icons.facebook_outlined),
  google('GOOGLE', 'Google', Icons.search),
  website('WEBSITE', 'Website', Icons.language),
  email('EMAIL', 'Email', Icons.email_outlined),
  whatsApp('WHATSAPP', 'WhatsApp', Icons.chat_outlined),
  phone('PHONE', 'Phone', Icons.phone_outlined),
  walkIn('WALK_IN', 'Walk-in', Icons.directions_walk),
  referral('REFERRAL', 'Referral', Icons.people_outlined),
  doctorReferral('DOCTOR_REFERRAL', 'Doctor Referral', Icons.medical_services_outlined),
  existingPatient('EXISTING_PATIENT', 'Existing Patient', Icons.person_outlined),
  other('OTHER', 'Other', Icons.more_horiz);

  final String value;
  final String label;
  final IconData icon;
  const LeadSource(this.value, this.label, this.icon);

  static LeadSource fromString(String value) {
    return LeadSource.values.firstWhere(
      (s) => s.value == value,
      orElse: () => LeadSource.other,
    );
  }
}

/// Lead entry type - how the lead was created.
enum EntryType {
  automatic('AUTOMATIC', 'Automatic'),
  manual('MANUAL', 'Manual');

  final String value;
  final String label;
  const EntryType(this.value, this.label);

  static EntryType fromString(String value) {
    return EntryType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => EntryType.manual,
    );
  }
}

/// Lead priority.
enum LeadPriority {
  high('HIGH', 'High'),
  medium('MEDIUM', 'Medium'),
  low('LOW', 'Low');

  final String value;
  final String label;
  const LeadPriority(this.value, this.label);

  static LeadPriority fromString(String value) {
    return LeadPriority.values.firstWhere(
      (p) => p.value == value,
      orElse: () => LeadPriority.medium,
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Hospital departments.
enum Department {
  gynecology('GYNECOLOGY', 'Gynecology', NelsonColors.womenPink),
  womenCare('WOMEN_CARE', 'Women Care', NelsonColors.womenPink),
  neurology('NEUROLOGY', 'Neurology', NelsonColors.primaryBlue),
  neuroscience('NEUROSCIENCE', 'Neuroscience', NelsonColors.primaryBlue),
  urology('UROLOGY', 'Urology', NelsonColors.primaryBlue),
  cardiology('CARDIOLOGY', 'Cardiology', NelsonColors.primaryRed),
  orthopedics('ORTHOPEDICS', 'Orthopedics', NelsonColors.primaryBlue),
  pediatrics('PEDIATRICS', 'Pediatrics', NelsonColors.womenPink),
  oncology('ONCOLOGY', 'Oncology', NelsonColors.primaryBlue),
  ophthalmology('OPHTHALMOLOGY', 'Ophthalmology', NelsonColors.primaryBlue),
  generalMedicine('GENERAL_MEDICINE', 'General Medicine', NelsonColors.primaryBlue),
  generalSurgery('GENERAL_SURGERY', 'General Surgery', NelsonColors.primaryBlue),
  gastroenterology('GASTROENTEROLOGY', 'Gastroenterology', NelsonColors.primaryBlue),
  ent('ENT', 'ENT', NelsonColors.primaryBlue),
  radiology('RADIOLOGY', 'Radiology', NelsonColors.primaryBlue),
  pathology('PATHOLOGY', 'Pathology', NelsonColors.primaryBlue),
  physiotherapy('PHYSIOTHERAPY', 'Physiotherapy', NelsonColors.successGreen),
  criticalCare('CRITICAL_CARE', 'Critical Care', NelsonColors.primaryRed),
  other('OTHER', 'Other', NelsonColors.textSecondary);

  final String value;
  final String label;
  final Color color;
  const Department(this.value, this.label, this.color);

  static Department fromString(String value) {
    return Department.values.firstWhere(
      (d) => d.value == value,
      orElse: () => Department.other,
    );
  }
}

/// Requirement categories.
enum RequirementCategory {
  consultation('CONSULTATION', 'Consultation'),
  treatment('TREATMENT', 'Treatment'),
  surgery('SURGERY', 'Surgery'),
  appointment('APPOINTMENT', 'Appointment'),
  secondOpinion('SECOND_OPINION', 'Second Opinion'),
  healthPackage('HEALTH_PACKAGE', 'Health Package'),
  diagnostic('DIAGNOSTIC', 'Diagnostic'),
  costEnquiry('COST_ENQUIRY', 'Cost Enquiry'),
  other('OTHER', 'Other');

  final String value;
  final String label;
  const RequirementCategory(this.value, this.label);

  static RequirementCategory fromString(String value) {
    return RequirementCategory.values.firstWhere(
      (r) => r.value == value,
      orElse: () => RequirementCategory.other,
    );
  }
}

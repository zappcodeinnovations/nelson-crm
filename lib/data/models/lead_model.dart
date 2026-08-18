import 'enums/lead_status.dart';
import 'enums/lead_source.dart';
import 'enums/department.dart';

/// Comprehensive lead model.
class LeadModel {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final int? age;
  final String? gender;
  final String? city;
  final String requirement;
  final String? requirementCategory;
  final LeadSource source;
  final EntryType entryType;
  final String? campaign;
  final Department? department;
  final String? branch;
  final String? assignedStaffId;
  final String? assignedStaffName;
  final String? shiftId;
  final LeadStatus status;
  final LeadPriority priority;
  final String? createdBy;
  final DateTime createdAt;
  final String? updatedBy;
  final DateTime? updatedAt;
  final DateTime? lastCalledAt;
  final String? calledBy;
  final String? callResult;
  final String? noAnswerReason;
  final String? remark1;
  final String? remark2;
  final DateTime? nextFollowUpAt;
  final String? assignedDoctorId;
  final String? assignedDoctorName;
  final String? appointmentId;

  const LeadModel({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.age,
    this.gender,
    this.city,
    required this.requirement,
    this.requirementCategory,
    required this.source,
    required this.entryType,
    this.campaign,
    this.department,
    this.branch,
    this.assignedStaffId,
    this.assignedStaffName,
    this.shiftId,
    required this.status,
    required this.priority,
    this.createdBy,
    required this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.lastCalledAt,
    this.calledBy,
    this.callResult,
    this.noAnswerReason,
    this.remark1,
    this.remark2,
    this.nextFollowUpAt,
    this.assignedDoctorId,
    this.assignedDoctorName,
    this.appointmentId,
  });

  factory LeadModel.fromJson(Map<String, dynamic> json) {
    return LeadModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String?,
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      city: json['city'] as String?,
      requirement: json['requirement'] as String? ?? '',
      requirementCategory: json['requirement_category'] as String?,
      source: LeadSource.fromString(json['source'] as String? ?? ''),
      entryType: EntryType.fromString(json['entry_type'] as String? ?? ''),
      campaign: json['campaign'] as String?,
      department: json['department'] != null ? Department.fromString(json['department'] as String) : null,
      branch: json['branch'] as String?,
      assignedStaffId: json['assigned_staff_id']?.toString(),
      assignedStaffName: json['assigned_staff_name'] as String?,
      shiftId: json['shift_id']?.toString(),
      status: LeadStatus.fromString(json['status'] as String? ?? ''),
      priority: LeadPriority.fromString(json['priority'] as String? ?? ''),
      createdBy: json['created_by'] as String?,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
      updatedBy: json['updated_by'] as String?,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at'] as String) : null,
      lastCalledAt: json['last_called_at'] != null ? DateTime.tryParse(json['last_called_at'] as String) : null,
      calledBy: json['called_by'] as String?,
      callResult: json['call_result'] as String?,
      noAnswerReason: json['no_answer_reason'] as String?,
      remark1: json['remark1'] as String?,
      remark2: json['remark2'] as String?,
      nextFollowUpAt: json['next_follow_up_at'] != null ? DateTime.tryParse(json['next_follow_up_at'] as String) : null,
      assignedDoctorId: json['assigned_doctor_id']?.toString(),
      assignedDoctorName: json['assigned_doctor_name'] as String?,
      appointmentId: json['appointment_id']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'age': age,
      'gender': gender,
      'city': city,
      'requirement': requirement,
      'requirement_category': requirementCategory,
      'source': source.value,
      'entry_type': entryType.value,
      'campaign': campaign,
      'department': department?.value,
      'branch': branch,
      'assigned_staff_id': assignedStaffId,
      'assigned_staff_name': assignedStaffName,
      'shift_id': shiftId,
      'status': status.value,
      'priority': priority.value,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'remark1': remark1,
      'remark2': remark2,
      'next_follow_up_at': nextFollowUpAt?.toIso8601String(),
      'assigned_doctor_id': assignedDoctorId,
      'assigned_doctor_name': assignedDoctorName,
      'appointment_id': appointmentId,
    };
  }

  LeadModel copyWith({
    LeadStatus? status,
    LeadPriority? priority,
    String? remark1,
    String? remark2,
    String? callResult,
    String? noAnswerReason,
    DateTime? lastCalledAt,
    String? calledBy,
    DateTime? nextFollowUpAt,
    String? assignedDoctorId,
    String? assignedDoctorName,
    String? appointmentId,
    Department? department,
    String? assignedStaffId,
    String? assignedStaffName,
  }) {
    return LeadModel(
      id: id, name: name, phone: phone, email: email, age: age, gender: gender,
      city: city, requirement: requirement, requirementCategory: requirementCategory,
      source: source, entryType: entryType, campaign: campaign,
      department: department ?? this.department,
      branch: branch,
      assignedStaffId: assignedStaffId ?? this.assignedStaffId,
      assignedStaffName: assignedStaffName ?? this.assignedStaffName,
      shiftId: shiftId,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      createdBy: createdBy, createdAt: createdAt,
      updatedBy: updatedBy, updatedAt: DateTime.now(),
      lastCalledAt: lastCalledAt ?? this.lastCalledAt,
      calledBy: calledBy ?? this.calledBy,
      callResult: callResult ?? this.callResult,
      noAnswerReason: noAnswerReason ?? this.noAnswerReason,
      remark1: remark1 ?? this.remark1,
      remark2: remark2 ?? this.remark2,
      nextFollowUpAt: nextFollowUpAt ?? this.nextFollowUpAt,
      assignedDoctorId: assignedDoctorId ?? this.assignedDoctorId,
      assignedDoctorName: assignedDoctorName ?? this.assignedDoctorName,
      appointmentId: appointmentId ?? this.appointmentId,
    );
  }
}

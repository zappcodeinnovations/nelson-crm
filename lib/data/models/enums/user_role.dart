/// User roles with navigation and permission configuration.
enum UserRole {
  crmExecutive('CRM_EXECUTIVE', 'CRM Executive'),
  receptionist('RECEPTIONIST', 'Receptionist'),
  doctor('DOCTOR', 'Doctor'),
  marketing('MARKETING', 'Marketing'),
  branchManager('BRANCH_MANAGER', 'Branch Manager'),
  admin('ADMIN', 'Admin');

  final String value;
  final String label;
  const UserRole(this.value, this.label);

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (role) => role.value == value,
      orElse: () => UserRole.crmExecutive,
    );
  }

  bool get isAdmin => this == UserRole.admin;
  bool get isManager => this == UserRole.branchManager || isAdmin;
  bool get isDoctor => this == UserRole.doctor;
  bool get isMarketing => this == UserRole.marketing;
  bool get isReceptionist => this == UserRole.receptionist;
  bool get isCrmExecutive => this == UserRole.crmExecutive;

  bool get canViewLeads =>
      this == UserRole.crmExecutive ||
      this == UserRole.marketing ||
      this == UserRole.branchManager ||
      this == UserRole.admin;

  bool get canCreateLeads =>
      this == UserRole.crmExecutive ||
      this == UserRole.marketing ||
      this == UserRole.admin;

  bool get canViewAnalytics =>
      this == UserRole.marketing ||
      this == UserRole.branchManager ||
      this == UserRole.admin;

  bool get canManageStaff =>
      this == UserRole.branchManager ||
      this == UserRole.admin;

  bool get canViewPatients =>
      this != UserRole.marketing;

  bool get canViewAppointments => true;

  bool get canViewFollowUps =>
      this == UserRole.crmExecutive ||
      this == UserRole.receptionist ||
      this == UserRole.branchManager ||
      this == UserRole.admin;

  bool get canViewDoctors =>
      this == UserRole.crmExecutive ||
      this == UserRole.receptionist ||
      this == UserRole.branchManager ||
      this == UserRole.admin;

  bool get canConsult => this == UserRole.doctor;
}

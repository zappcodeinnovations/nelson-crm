import '../../data/models/enums/user_role.dart';

/// Role-based permission helper providing navigation and access configuration.
class PermissionHelper {
  PermissionHelper._();

  /// Check if a user role has access to a specific feature.
  static bool hasAccess(UserRole role, String feature) {
    final permissions = _rolePermissions[role] ?? {};
    return permissions.contains(feature) || role.isAdmin;
  }

  static const Map<UserRole, Set<String>> _rolePermissions = {
    UserRole.crmExecutive: {
      'home', 'leads', 'follow_ups', 'appointments', 'patients',
      'calls', 'doctors', 'notifications', 'profile',
    },
    UserRole.receptionist: {
      'home', 'appointments', 'patients', 'follow_ups',
      'notifications', 'profile',
    },
    UserRole.doctor: {
      'home', 'appointments', 'patients', 'consultation',
      'notifications', 'profile',
    },
    UserRole.marketing: {
      'home', 'leads', 'analytics', 'campaigns',
      'notifications', 'profile',
    },
    UserRole.branchManager: {
      'home', 'leads', 'appointments', 'staff', 'analytics',
      'patients', 'follow_ups', 'notifications', 'profile',
    },
    UserRole.admin: {
      // Admin gets full access by default
    },
  };
}

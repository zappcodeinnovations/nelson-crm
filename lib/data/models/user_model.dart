import 'enums/user_role.dart';

/// User profile model.
class UserModel {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final UserRole role;
  final String branch;
  final String? branchId;
  final String? department;
  final String? departmentId;
  final String? shiftId;
  final String? shiftName;
  final String? profileImageUrl;
  final bool isActive;

  const UserModel({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    required this.role,
    required this.branch,
    this.branchId,
    this.department,
    this.departmentId,
    this.shiftId,
    this.shiftName,
    this.profileImageUrl,
    this.isActive = true,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String?,
      role: UserRole.fromString(json['role'] as String? ?? ''),
      branch: json['branch'] as String? ?? '',
      branchId: json['branch_id']?.toString(),
      department: json['department'] as String?,
      departmentId: json['department_id']?.toString(),
      shiftId: json['shift_id']?.toString(),
      shiftName: json['shift_name'] as String?,
      profileImageUrl: json['profile_image_url'] as String?,
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'role': role.value,
      'branch': branch,
      'branch_id': branchId,
      'department': department,
      'department_id': departmentId,
      'shift_id': shiftId,
      'shift_name': shiftName,
      'profile_image_url': profileImageUrl,
      'is_active': isActive,
    };
  }

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}

/// Authentication response model.
class AuthResponseModel {
  final String accessToken;
  final String? refreshToken;
  final UserModel user;

  const AuthResponseModel({
    required this.accessToken,
    this.refreshToken,
    required this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      accessToken: json['access'] as String? ?? json['access_token'] as String? ?? '',
      refreshToken: json['refresh'] as String? ?? json['refresh_token'] as String?,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
    );
  }
}

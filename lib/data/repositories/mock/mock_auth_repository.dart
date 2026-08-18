import '../../models/user_model.dart';
import '../../models/enums/user_role.dart';
import '../auth_repository.dart';

/// Mock auth repository for development.
class MockAuthRepository implements AuthRepository {
  // Test credentials
  static const _testUsers = {
    '9876543210': _TestUser('CRM_EXEC_001', 'Rahul Sharma', 'CRM_EXECUTIVE', 'Nelson Hospital - Dhantoli'),
    '9876543211': _TestUser('RECEP_001', 'Priya Patel', 'RECEPTIONIST', 'Nelson Hospital - Dhantoli'),
    '9876543212': _TestUser('DOC_001', 'Dr. Amit Sharma', 'DOCTOR', 'Nelson Hospital - Dhantoli'),
    '9876543213': _TestUser('MKT_001', 'Neha Gupta', 'MARKETING', 'Nelson Hospital - Ramdaspeth'),
    '9876543214': _TestUser('MGR_001', 'Suresh Kumar', 'BRANCH_MANAGER', 'Nelson Hospital - Dhantoli'),
    '9876543215': _TestUser('ADM_001', 'Admin User', 'ADMIN', 'Nelson Hospital - Head Office'),
  };

  @override
  Future<AuthResponseModel> login({required String phone, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 800));

    if (password != '123456') {
      throw Exception('Invalid credentials. Use password: 123456');
    }

    final testUser = _testUsers[phone];
    if (testUser == null) {
      // Allow any phone number, default to CRM Executive
      return AuthResponseModel(
        accessToken: 'mock_access_token_${DateTime.now().millisecondsSinceEpoch}',
        refreshToken: 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
        user: UserModel(
          id: 'USR_${phone.substring(phone.length - 4)}',
          name: 'Staff Member',
          phone: phone,
          role: UserRole.crmExecutive,
          branch: 'Nelson Hospital - Dhantoli',
          shiftName: 'Morning Shift',
        ),
      );
    }

    return AuthResponseModel(
      accessToken: 'mock_access_token_${DateTime.now().millisecondsSinceEpoch}',
      refreshToken: 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
      user: UserModel(
        id: testUser.id,
        name: testUser.name,
        phone: phone,
        role: UserRole.fromString(testUser.role),
        branch: testUser.branch,
        shiftName: 'Morning Shift',
        department: testUser.role == 'DOCTOR' ? 'Neurology' : null,
      ),
    );
  }

  @override
  Future<AuthResponseModel> verifyOtp({required String phone, required String otp}) async {
    await Future.delayed(const Duration(milliseconds: 600));

    if (otp != '123456') {
      throw Exception('Invalid OTP. Use: 123456');
    }

    return login(phone: phone, password: '123456');
  }

  @override
  Future<void> forgotPassword({required String phone}) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> resetPassword({required String phone, required String otp, required String newPassword}) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<UserModel> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const UserModel(
      id: 'CRM_EXEC_001',
      name: 'Rahul Sharma',
      phone: '9876543210',
      role: UserRole.crmExecutive,
      branch: 'Nelson Hospital - Dhantoli',
      shiftName: 'Morning Shift',
    );
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}

class _TestUser {
  final String id;
  final String name;
  final String role;
  final String branch;
  const _TestUser(this.id, this.name, this.role, this.branch);
}

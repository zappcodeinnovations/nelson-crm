/// Form field validators.
class Validators {
  Validators._();

  static String? required(String? value, [String fieldName = 'This field']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final cleaned = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    if (cleaned.length < 10 || cleaned.length > 13) {
      return 'Enter a valid phone number';
    }
    if (!RegExp(r'^[+]?[0-9]+$').hasMatch(cleaned)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Email is often optional
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? otp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'OTP is required';
    }
    if (value.length != 6 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Enter a valid 6-digit OTP';
    }
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  static String? age(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Age is often optional
    }
    final age = int.tryParse(value);
    if (age == null || age < 0 || age > 150) {
      return 'Enter a valid age';
    }
    return null;
  }
}

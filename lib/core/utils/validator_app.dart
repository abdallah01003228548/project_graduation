import 'package:project_graduation/core/constants/app_keys.dart';
import 'package:project_graduation/core/constants/app_strings.dart';

abstract class Validator {
  static String? validateEmail(String? val) {
    final RegExp emailRegex = RegExp(AppKeys.emailRegex);
    if (val == null || val.trim().isEmpty) {
      return AppStrings.emailCannotBeEmpty;
    } else if (!emailRegex.hasMatch(val)) {
      return AppStrings.enterValidEmail;
    } else {
      return null;
    }
  }

  static String? validatePassword(String? val) {
    if (val == null || val.isEmpty) {
      return AppStrings.passwordCannotBeEmpty;
    } else if (val.length < 8) {
      return AppStrings.passwordMinLength;
    } else if (!RegExp(r'[A-Za-z]').hasMatch(val)) {
      return AppStrings.passwordMustContainLetter;
    } else if (!RegExp(r'[0-9]').hasMatch(val)) {
      return AppStrings.passwordMustContainNumber;
    } else if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-]').hasMatch(val)) {
      return AppStrings.passwordMustContainSpecialChar;
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String? val, String? password) {
    if (val == null || val.isEmpty) {
      return AppStrings.passwordCannotBeEmpty;
    } else if (val != password) {
      return AppStrings.confirmPasswordMustMatch;
    } else {
      return null;
    }
  }

  static String? validateName(String? val) {
    if (val == null || val.isEmpty) {
      return AppStrings.nameCannotBeEmpty;
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? val) {
    if (val == null || val.trim().isEmpty) {
      return AppStrings.phoneCannotBeEmpty;
    }

    final phone = val.trim();
    final isValid = RegExp(r'^\+?\d+$').hasMatch(phone);
    if (!isValid || phone.length < 11 || phone.length > 13) {
      return AppStrings.enterValidPhone;
    }

    return null;
  }

  static String? validateCode(String? val) {
    if (val == null || val.isEmpty) {
      return AppStrings.codeCannotBeEmpty;
    } else if (val.length < 6) {
      return AppStrings.codeMinLength;
    } else {
      return null;
    }
  }
}

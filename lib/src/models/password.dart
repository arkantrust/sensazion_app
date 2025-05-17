import 'package:formz/formz.dart';

enum PasswordValidationError {
  empty,
  lessThan12Chars,
  noNumber,
  noUpper,
  noLower,
  hasSpaces,
  noSymbol,
}

/// A secure password has:
/// - at least 12 characters
/// - at least one number
/// - at least one uppercase letter
/// - at least one lowercase letter
/// - no spaces
/// - TODO: at least one special character
class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;
    if (value.length < 12) return PasswordValidationError.lessThan12Chars;
    if (!value.hasNumber) return PasswordValidationError.noNumber;
    if (!value.hasUpper) return PasswordValidationError.noUpper;
    if (!value.hasLower) return PasswordValidationError.noLower;
    if (value.contains(' ')) return PasswordValidationError.hasSpaces;
    // if (!value.hasSymbol) return PasswordValidationError.noSymbol;
    return null;
  }
}

extension PasswordChecks on String {
  bool get hasNumber => RegExp(r'\d').hasMatch(this);
  bool get hasUpper => RegExp(r'[A-Z]').hasMatch(this);
  bool get hasLower => RegExp(r'[a-z]').hasMatch(this);
  // bool get hasSymbol => RegExp(r'''[!@#$%^&*()_\-+=~`{}\[\]|:;"'\<>,.?/\\]''').hasMatch(this);
}

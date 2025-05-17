import 'package:formz/formz.dart';

/// Validating emails is a PITA. Even " "@example.org and "$#@13"@example.org are valid email addresses 💀
///
/// We'll go with simple empty/notEmpty validations for now
///
/// values: empty, noAtSymbol, noLocal, noDomain
// TODO: Robust email validation
// See email_test.dart for validation tests
enum EmailValidationError { empty, noAtSymbol, noLocal, noDomain }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    final email = value.trim();
    if (email.isEmpty) return EmailValidationError.empty;

    final parts = email.split('@');
    if (parts.length < 2) return EmailValidationError.noAtSymbol;
    if (parts[0].isEmpty) return EmailValidationError.noLocal;
    if (parts[1].isEmpty) return EmailValidationError.noDomain;

    return null;
  }
}

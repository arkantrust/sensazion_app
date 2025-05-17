import 'package:sensazion_app/src/models/password.dart';
import 'package:test/test.dart';

void main() {
  var password = const Password.pure();

  group('Valid passwords', () {
    test('A1b!defghijk should be valid', () {
      password = const Password.dirty('A1b!defghijk');
      expect(password.error, null);
      expect(password.isValid, true);
    });

    test('StrongPass123!@# should be valid', () {
      password = const Password.dirty('StrongPass123!@#');
      expect(password.error, null);
      expect(password.isValid, true);
    });

    test('Aa1@34567890 should be valid', () {
      password = const Password.dirty('Aa1@34567890');
      expect(password.error, null);
      expect(password.isValid, true);
    });
  });

  group('Invalid passwords', () {
    test('Empty password should fail', () {
      password = const Password.dirty('');
      expect(password.isValid, false);
      expect(password.error, PasswordValidationError.empty);
    });

    test('Less than 12 chars should fail', () {
      password = const Password.dirty('A1b!short');
      expect(password.isValid, false);
      expect(password.error, PasswordValidationError.lessThan12Chars);
    });

    test('No number should fail', () {
      password = const Password.dirty('Aa!abcdefghij');
      expect(password.isValid, false);
      expect(password.error, PasswordValidationError.noNumber);
    });

    test('No uppercase should fail', () {
      password = const Password.dirty('a1!abcdefghij');
      expect(password.isValid, false);
      expect(password.error, PasswordValidationError.noUpper);
    });

    test('No lowercase should fail', () {
      password = const Password.dirty('A1!ABCDEFGHIJ');
      expect(password.isValid, false);
      expect(password.error, PasswordValidationError.noLower);
    });

    test('No symbol should fail', () {
      password = const Password.dirty('A1b2c3d4e5f6');
      expect(password.isValid, false);
      expect(password.error, PasswordValidationError.noSymbol);
    });

    test('Password with spaces should fail', () {
      password = const Password.dirty('A1b! withSpace');
      expect(password.isValid, false);
      expect(password.error, PasswordValidationError.hasSpaces);
    });
  });
}

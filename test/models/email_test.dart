import 'package:sensazion_app/src/models/email.dart';
import 'package:test/test.dart';

void main() {
  var email = const Email.pure();

  // Examples taken from https://en.wikipedia.org/wiki/Email_address#Valid_email_addresses
  group('Valid emails', () {
    test('simple@example.com should be valid', () {
      email = const Email.dirty('simple@example.com');
      expect(email.error, null);
      expect(email.isValid, true);
    });

    test('very.common@example.com should be valid', () {
      email = const Email.dirty('very.common@example.com');
      expect(email.error, null);
      expect(email.isValid, true);
    });

    test('FirstName.LastName@EasierReading.org should be valid', () {
      email = const Email.dirty('FirstName.LastName@EasierReading.org');
      expect(email.error, null);
      expect(email.isValid, true, reason: 'case is always ignored after the @ and usually before');
    });

    test('x@example.com should be valid', () {
      email = const Email.dirty('x@example.com');
      expect(email.error, null);
      expect(email.isValid, true, reason: 'x is a valid one-letter local-part');
    });

    test('long.email-address-with-hyphens@and.subdomains.example.com should be valid', () {
      email = const Email.dirty('long.email-address-with-hyphens@and.subdomains.example.com');
      expect(email.error, null);
      expect(email.isValid, true);
    });

    test('user.name+tag+sorting@example.com should be valid', () {
      email = const Email.dirty('user.name+tag+sorting@example.com');
      expect(email.error, null);
      expect(
        email.isValid,
        true,
        reason: 'may be routed to user.name@example.com inbox depending on mail server',
      );
    });

    test('name/surname@example.com should be valid', () {
      email = const Email.dirty('name/surname@example.com');
      expect(email.error, null);
      expect(
        email.isValid,
        true,
        reason: 'slashes are a printable character, and allowed in the local-part',
      );
    });

    test('admin@example should be valid', () {
      email = const Email.dirty('admin@example');
      expect(email.error, null);
      expect(
        email.isValid,
        true,
        reason:
            'local domain name with no TLD, although ICANN highly discourages dotless email addresses',
      );
    });

    test('example@s.example should be valid', () {
      email = const Email.dirty('example@s.example');
      expect(email.error, null);
      expect(
        email.isValid,
        true,
        reason:
            'see the List of Internet top-level domains: https://en.wikipedia.org/wiki/List_of_Internet_top-level_domains',
      );
    });

    test('" "@example.org should be valid', () {
      email = const Email.dirty('" "@example.org');
      expect(email.error, null);
      expect(email.isValid, true, reason: 'quoted string with a space is valid');
    });

    test('"john..doe"@example.org should be valid', () {
      email = const Email.dirty('"john..doe"@example.org');
      expect(email.error, null);
      expect(email.isValid, true, reason: 'quoted string with two dots is valid');
    });

    test('mailhost!username@example.org should be valid', () {
      email = const Email.dirty('mailhost!username@example.org');
      expect(email.error, null);
      expect(
        email.isValid,
        true,
        reason: 'bangified host route used for uucp mailers, not common anymore',
      );
    });

    test(
      '"very.(),:;<>[]\\".VERY.\\"very@\\ \\"very\\".unusual"@strange.example.com should be valid',
      () {
        email = const Email.dirty(
          '"very.(),:;<>[]\\".VERY.\\"very@\\ \\"very\\".unusual"@strange.example.com',
        );
        expect(email.error, null);
        expect(
          email.isValid,
          true,
          reason:
              'include non-letters character AND multiple at sign, the first one being double quoted',
        );
      },
    );

    test('user%example.com@example.org should be valid', () {
      email = const Email.dirty('user%example.com@example.org');
      expect(email.error, null);
      expect(
        email.isValid,
        true,
        reason: '% escaped mail route to user@example.com via example.org',
      );
    });

    test('user-@example.org should be valid', () {
      email = const Email.dirty('user-@example.org');
      expect(email.error, null);
      expect(
        email.isValid,
        true,
        reason:
            'local-part ending with non-alphanumeric character from the list of allowed printable characters',
      );
    });

    test('postmaster@[123.123.123.123] should be valid', () {
      email = const Email.dirty('postmaster@[123.123.123.123]');
      expect(email.error, null);
      expect(
        email.isValid,
        true,
        reason:
            'IP addresses are allowed instead of domains when in square brackets, but strongly discouraged',
      );
    });

    test('postmaster@[IPv6:2001:0db8:85a3:0000:0000:8a2e:0370:7334] should be valid', () {
      email = const Email.dirty('postmaster@[IPv6:2001:0db8:85a3:0000:0000:8a2e:0370:7334]');
      expect(email.error, null);
      expect(email.isValid, true, reason: 'IPv6 uses a different syntax');
    });

    test('_test@[IPv6:2001:0db8:85a3:0000:0000:8a2e:0370:7334] should be valid', () {
      email = const Email.dirty('_test@[IPv6:2001:0db8:85a3:0000:0000:8a2e:0370:7334]');
      expect(email.error, null);
      expect(email.isValid, true, reason: 'begin with underscore different syntax');
    });
  });

  // Examples taken from https://en.wikipedia.org/wiki/Email_address#Invalid_email_addresses
  group('Invalid emails', () {
    test('Empty should be invalid', () {
      email = const Email.dirty('');
      expect(email.error, EmailValidationError.empty);
      expect(email.isValid, false);
    });

    test('abc@ should be invalid', () {
      email = const Email.dirty('abc@');
      expect(email.error, EmailValidationError.noDomain);
      expect(email.isValid, false, reason: 'missing domain part');
    });

    test('@ddulce.app should be invalid', () {
      email = const Email.dirty('@ddulce.app');
      expect(email.error, EmailValidationError.noLocal);
      expect(email.isValid, false, reason: 'missing local part');
    });

    test('abc.example.com (no @ character) should be invalid', () {
      email = const Email.dirty('abc.example.com');
      expect(email.error, EmailValidationError.noAtSymbol);
      expect(email.isValid, false, reason: 'missing @ character');
    });

    test('a@b@c@example.com (multiple @) should be invalid', () {
      email = const Email.dirty('a@b@c@example.com');
      expect(email.isValid, false, reason: 'only one @ is allowed outside quotation marks');
    });

    test('a"b(c)d,e:f;g<h>i[j\\k]l@example.com (invalid special chars) should be invalid', () {
      email = const Email.dirty('a"b(c)d,e:f;g<h>i[j\\k]l@example.com');
      expect(email.isValid, false, reason: 'special characters not allowed outside quotes');
    });

    test('just"not"right@example.com (invalid quoted string) should be invalid', () {
      email = const Email.dirty('just"not"right@example.com');
      expect(
        email.isValid,
        false,
        reason: 'quoted strings must be dot separated or the only element',
      );
    });

    test('this is"not\\allowed@example.com (invalid space/quote) should be invalid', () {
      email = const Email.dirty('this is"not\\allowed@example.com');
      expect(
        email.isValid,
        false,
        reason: 'spaces, quotes, and backslashes must be within quoted strings and escaped',
      );
    });

    test('this\\ still\\"not\\\\allowed@example.com (invalid escaped chars) should be invalid', () {
      email = const Email.dirty('this\\ still\\"not\\\\allowed@example.com');
      expect(
        email.isValid,
        false,
        reason: 'escaped spaces, quotes, and backslashes must be inside quotes',
      );
    });

    test(
      '1234567890123456789012345678901234567890123456789012345678901234+x@example.com (local-part too long) should be invalid',
      () {
        email = const Email.dirty(
          '1234567890123456789012345678901234567890123456789012345678901234+x@example.com',
        );
        expect(email.isValid, false, reason: 'local-part is longer than 64 characters');
      },
    );

    test(
      'i.like.underscores@but_they_are_not_allowed_in_this_part (underscore in domain) should be invalid',
      () {
        email = const Email.dirty('i.like.underscores@but_they_are_not_allowed_in_this_part');
        expect(email.isValid, false, reason: 'underscore is not allowed in domain part');
      },
    );
  });
}

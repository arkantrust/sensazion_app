import 'package:sensazion_app/src/models/name.dart';
import 'package:test/test.dart';

void main() {
  var name = const Name.pure();

  test('Empty should be invalid', () {
    name = const Name.dirty('');
    expect(name.error, NameValidationError.empty);
    expect(name.isValid, false);
  });

  test('Not empty should be valid', () {
    name = const Name.dirty('David Dulce');
    expect(name.error, null);
    expect(name.isValid, true);
  });
}

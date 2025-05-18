import 'package:test/test.dart';
import 'package:core/src/utils/result.dart';

void main() {
  group('Result', () {
    test('Success stores and returns value', () {
      final result = Success<int>(42);
      expect(result.value, 42);
      expect(result.isSuccess, isTrue);
      expect(result.isFailure, isFalse);
      expect(result.valueOrNull, 42);
      expect(result.errorOrNull, isNull);
    });

    test('Failure throws on .value and returns error', () {
      final error = Exception('Something went wrong');
      final result = Failure(error);

      expect(result.isSuccess, isFalse);
      expect(result.isFailure, isTrue);
      expect(() => result.value, throwsA(same(error)));
      expect(result.valueOrNull, isNull);
      expect(result.errorOrNull, error);
    });

    test('Success.empty behaves like return;', () {
      const result = Success<void>.empty();
      expect(result, isA<Success<void>>());
      // This is unnecesary as per https://dart.dev/tools/diagnostics/use_of_void_result
      // This expression has a type of 'void' so its value can't be used.
      // expect(result.value, isNull);
    });

    test('can return Success.empty() from void function', () {
      Result<void> sideEffect() {
        // pretend to perform a side-effect
        return const Success.empty();
      }

      final result = sideEffect();
      expect(result, isA<Success<void>>());
      // This is unnecesary as per https://dart.dev/tools/diagnostics/use_of_void_result
      // This expression has a type of 'void' so its value can't be used.
      // expect(result.valueOrNull, isNull);
    });

    test('Result.value throws for failure, returns for success', () {
      final s = Success<int>(10);
      final f = Failure(Exception('nope'));

      expect(s.value, 10);
      expect(() => f.value, throwsA(isA<Exception>()));
    });

    test('Result.valueOrNull and errorOrNull behave correctly', () {
      final s = Success('hello');
      final f = Failure(Exception('oops'));

      expect(s.valueOrNull, 'hello');
      expect(s.errorOrNull, null);

      expect(f.valueOrNull, null);
      expect(f.errorOrNull, isA<Exception>());
    });
  });
}

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
      final result = Failure<int>(error);

      expect(result.isSuccess, isFalse);
      expect(result.isFailure, isTrue);
      expect(() => result.value, throwsA(same(error)));
      expect(result.valueOrNull, isNull);
      expect(result.errorOrNull, error);
    });

    test('map transforms success value', () {
      final result = Success<int>(2);
      final mapped = result.map((v) => v * 2);
      expect(mapped, isA<Success<int>>());
      expect((mapped as Success<int>).value, 4);
    });

    test('map preserves failure', () {
      final error = Exception('fail');
      final result = Failure<int>(error);
      final mapped = result.map((v) => v * 2);
      expect(mapped, isA<Failure<int>>());
      expect((mapped as Failure).error, error);
    });

    test('flatMap chains multiple successes', () {
      final r1 = Success<int>(2);
      final chained = r1.flatMap((v) => Success(v * 2)).flatMap((v) => Success('$v units'));

      expect(chained, isA<Success<String>>());
      expect((chained as Success).value, '4 units');
    });

    test('flatMap short-circuits on failure', () {
      final error = Exception('nope');
      final result = Success(2)
          .flatMap((v) => Failure<int>(error))
          .flatMap((v) => Success(v * 100)); // should not be called

      expect(result, isA<Failure<int>>());
      expect(result.errorOrNull, error);
    });

    test('fold handles success and failure correctly', () {
      final s = Success<String>('ok');
      final f = Failure<String>(Exception('fail'));

      expect(s.fold((v) => 'S: $v', (e) => 'F: $e'), 'S: ok');
      expect(f.fold((v) => 'S: $v', (e) => 'F: $e'), startsWith('F: Exception: fail'));
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
      final f = Failure<int>(Exception('nope'));

      expect(s.value, 10);
      expect(() => f.value, throwsA(isA<Exception>()));
    });

    test('Result.valueOrNull and errorOrNull behave correctly', () {
      final s = Success('hello');
      final f = Failure<String>(Exception('oops'));

      expect(s.valueOrNull, 'hello');
      expect(s.errorOrNull, null);

      expect(f.valueOrNull, null);
      expect(f.errorOrNull, isA<Exception>());
    });
  });
}

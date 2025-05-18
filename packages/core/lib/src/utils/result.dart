/// A result is an abstraction over the success and failure of an operation.
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T value;

  const Success(this.value);

  /// Use this constructor to create a success void result for methods that return no value.
  ///
  /// Use `Result<void>` as the type parameter.
  ///
  /// `return const Success<void>.empty();`
  const Success.empty() : value = null as T;
}

class Failure<T> extends Result<T> {
  final Exception error;

  /// Optionally provide a stack trace for unknown errors.
  StackTrace? stackTrace;

  Failure(this.error);

  /// Use this constructor for unknown failures (e.g., caught errors that are not Exception).
  Failure.unknown([Object? error, this.stackTrace])
    : error = error is Exception ? error : Exception(error?.toString() ?? 'Unknown error');
}

/// Extension methods to reduce boilerplate
extension ResultExtensions<T> on Result<T> {
  /// Check if result is success
  bool get isSuccess => this is Success<T>;

  /// Check if result is failure
  bool get isFailure => this is Failure<T>;

  /// Get value (throws if failure)
  T get value => switch (this) {
    Success(value: final v) => v,
    Failure(error: final e) => throw e,
  };

  /// Get value or null
  T? get valueOrNull => switch (this) {
    Success(value: final v) => v,
    Failure() => null,
  };

  /// Get error or null
  Exception? get errorOrNull => switch (this) {
    Success() => null,
    Failure(error: final e) => e,
  };

  /// Transform success value
  Result<U> map<U>(U Function(T) transform) => switch (this) {
    Success(value: final v) => Success(transform(v)),
    Failure(error: final e) => Failure(e),
  };

  /// Chain operations (flatMap/bind)
  Result<U> flatMap<U>(Result<U> Function(T) transform) => switch (this) {
    Success(value: final v) => transform(v),
    Failure(error: final e) => Failure(e),
  };

  /// Handle both cases
  U fold<U>(U Function(T) onSuccess, U Function(Exception) onFailure) => switch (this) {
    Success(value: final v) => onSuccess(v),
    Failure(error: final e) => onFailure(e),
  };
}

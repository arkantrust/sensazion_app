part of 'sign_in_bloc.dart';

final class SignInState extends Equatable {
  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final bool isValid;
  final String error;

  const SignInState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.error = '',
  });

  SignInState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    bool? isValid,
    String? error,
  }) {
    final e = email ?? this.email;
    final p = password ?? this.password;
    return SignInState(
      status: status ?? this.status,
      email: e,
      password: p,
      isValid: isValid ?? Formz.validate([p, e]),
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, email, password];
}

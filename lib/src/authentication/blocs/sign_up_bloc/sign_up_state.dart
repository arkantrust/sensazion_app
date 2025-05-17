part of 'sign_up_bloc.dart';

final class SignUpState extends Equatable {
  final FormzSubmissionStatus status;
  final String first;
  final String last;
  final Email email;
  final Password password;
  final Password confirm;
  final bool isValid;
  final String error;

  const SignUpState({
    this.status = FormzSubmissionStatus.initial,
    this.first = '',
    this.last = '',
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirm = const Password.pure(),
    this.isValid = false,
    this.error = '',
  });

  SignUpState copyWith({
    FormzSubmissionStatus? status,
    String? first,
    String? last,
    Email? email,
    Password? password,
    Password? confirm,
    bool? isValid,
    String? error,
  }) {
    final e = email ?? this.email;
    final p = password ?? this.password;
    final c = confirm ?? this.confirm;
    final validated = Formz.validate([e, p, c]) && p.value == c.value;

    return SignUpState(
      status: status ?? this.status,
      first: first ?? this.first,
      last: last ?? this.last,
      email: e,
      password: p,
      confirm: c,
      isValid: isValid ?? validated,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, first, last, email, password, confirm, isValid, error];
}

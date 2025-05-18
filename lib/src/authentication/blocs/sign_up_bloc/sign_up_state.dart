part of 'sign_up_bloc.dart';

final class SignUpState extends Equatable {
  final FormzSubmissionStatus status;
  final Name first;
  final Name last;
  final Email email;
  final Password password;
  final Password confirm;
  final bool isValid;
  final String error;

  const SignUpState({
    this.status = FormzSubmissionStatus.initial,
    this.first = const Name.pure(),
    this.last = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirm = const Password.pure(),
    this.isValid = false,
    this.error = '',
  });

  SignUpState copyWith({
    FormzSubmissionStatus? status,
    Name? first,
    Name? last,
    Email? email,
    Password? password,
    Password? confirm,
    bool? isValid,
    String? error,
  }) {
    final f = first ?? this.first;
    final l = last ?? this.last;
    final e = email ?? this.email;
    final p = password ?? this.password;
    final c = confirm ?? this.confirm;
    final validated = Formz.validate([f, l, e, p, c]) && p.value == c.value;

    return SignUpState(
      status: status ?? this.status,
      first: f,
      last: l,
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

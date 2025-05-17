part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

final class SignUpEmailChanged extends SignUpEvent {
  const SignUpEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class SignUpFirstChanged extends SignUpEvent {
  const SignUpFirstChanged(this.first);

  final String first;

  @override
  List<Object> get props => [first];
}

final class SignUpLastChanged extends SignUpEvent {
  const SignUpLastChanged(this.last);

  final String last;

  @override
  List<Object> get props => [last];
}

final class SignUpPasswordChanged extends SignUpEvent {
  const SignUpPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class SignUpConfirmChanged extends SignUpEvent {
  const SignUpConfirmChanged(this.confirm);

  final String confirm;

  @override
  List<Object> get props => [confirm];
}

final class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted();
}

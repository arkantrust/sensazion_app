import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:sensazion_app/src/models/models.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticationRepository _authenticationRepository;

  SignInBloc({required AuthenticationRepository authenticationRepository})
    : _authenticationRepository = authenticationRepository,
      super(SignInState()) {
    on<SignInEmailChanged>(_onEmailChanged);
    on<SignInPasswordChanged>(_onPasswordChanged);
    on<SignInSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(SignInEmailChanged event, Emitter<SignInState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(email: email));
  }

  void _onPasswordChanged(SignInPasswordChanged event, Emitter<SignInState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(password: password));
  }

  Future<void> _onSubmitted(SignInSubmitted event, Emitter<SignInState> emit) async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress, error: ''));

    final res = await _authenticationRepository.signIn(
      email: state.email.value,
      password: state.password.value,
    );

    if (res.isFailure) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, error: 'Unknown error'));
      return;
    }
    emit(state.copyWith(status: FormzSubmissionStatus.success, error: ''));
  }
}

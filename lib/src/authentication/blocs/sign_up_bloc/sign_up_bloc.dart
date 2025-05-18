import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:sensazion_app/src/models/models.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationRepository _authenticationRepository;

  SignUpBloc({required AuthenticationRepository authenticationRepository})
    : _authenticationRepository = authenticationRepository,
      super(SignUpState()) {
    on<SignUpFirstChanged>(_onFirstChanged);
    on<SignUpLastChanged>(_onLastChanged);
    on<SignUpEmailChanged>(_onEmailChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpConfirmChanged>(_onConfirmChanged);
    on<SignUpSubmitted>(_onSubmitted);
  }

  void _onFirstChanged(SignUpFirstChanged event, Emitter<SignUpState> emit) {
    final first = Name.dirty(event.first);
    emit(state.copyWith(first: first));
  }

  void _onLastChanged(SignUpLastChanged event, Emitter<SignUpState> emit) {
    final last = Name.dirty(event.last);
    emit(state.copyWith(last: last));
  }

  void _onEmailChanged(SignUpEmailChanged event, Emitter<SignUpState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(email: email));
  }

  void _onPasswordChanged(SignUpPasswordChanged event, Emitter<SignUpState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(password: password));
  }

  void _onConfirmChanged(SignUpConfirmChanged event, Emitter<SignUpState> emit) {
    final confirm = Password.dirty(event.confirm);
    emit(state.copyWith(confirm: confirm));
  }

  Future<void> _onSubmitted(SignUpSubmitted event, Emitter<SignUpState> emit) async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress, error: ''));

    final res = await _authenticationRepository.signUp(
      firstName: state.first.value,
      lastName: state.last.value,
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

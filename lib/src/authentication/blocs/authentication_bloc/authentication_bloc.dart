import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:core/core.dart';
import 'package:user_repository/user_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  }) : _authenticationRepository = authenticationRepository,
       _userRepository = userRepository,
       super(AuthenticationState.unknown()) {
    on<AuthenticationSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthenticationSignOutPressed>(_onSignOutPressed);
  }

  Future<void> _onSubscriptionRequested(
    AuthenticationSubscriptionRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    return emit.onEach(
      _authenticationRepository.status,
      onData:
          (status) async => switch (status) {
            AuthenticationStatus.unauthenticated => emit(
              const AuthenticationState.unauthenticated(),
            ),
            AuthenticationStatus.authenticated => await _emitUserIfExists(emit),
            AuthenticationStatus.unknown => emit(const AuthenticationState.unknown()),
          },
      onError: addError,
    );
  }

  void _onSignOutPressed(AuthenticationSignOutPressed event, Emitter<AuthenticationState> emit) {
    _authenticationRepository.signOut();
  }

  Future<void> _emitUserIfExists(Emitter<AuthenticationState> emit) async {
    final res = await _userRepository.getUser();
    // TODO: Handle errors
    if (res.isFailure) {
      emit(const AuthenticationState.unauthenticated());
    }
    final user = res.value;
    emit(
      user != null
          ? AuthenticationState.authenticated(user)
          : const AuthenticationState.unauthenticated(),
    );
  }
}

import 'package:get_it/get_it.dart';
import 'package:user_repository/user_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:sensazion_app/src/config/config.dart';
import 'package:sensazion_app/src/authentication/authentication.dart';
import 'package:sensazion_app/src/home/home.dart';

GetIt sl = GetIt.instance;
void initServiceLocator() {
  sl.registerSingleton<UserRepository>(SupabaseUserRepository(supabase: supabase));
  sl.registerSingleton<AuthenticationRepository>(
    SupabaseAuthenticationRepository(supabase: supabase),
  );
  sl.registerSingleton<AuthenticationBloc>(
    AuthenticationBloc(
      authenticationRepository: sl<AuthenticationRepository>(),
      userRepository: sl<UserRepository>(),
    ),
  );
  sl.registerFactory<CounterCubit>(() => CounterCubit());
  sl.registerFactory<SignUpBloc>(
    () => SignUpBloc(authenticationRepository: sl<AuthenticationRepository>()),
  );
  sl.registerFactory<SignInBloc>(
    () => SignInBloc(authenticationRepository: sl<AuthenticationRepository>()),
  );
}

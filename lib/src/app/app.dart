import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';

import 'package:sensazion_app/src/authentication/authentication.dart';
import 'package:sensazion_app/src/config/config.dart';
import 'package:sensazion_app/src/app/theme.dart';
import 'package:sensazion_app/src/app/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (_) => sl<AuthenticationRepository>(),
          dispose: (repo) => repo.dispose(),
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => sl<UserRepository>(),
          dispose: (repo) => repo.dispose(),
        ),
      ],
      child: BlocProvider(
        create: (context) => sl<AuthenticationBloc>()..add(AuthenticationSubscriptionRequested()),
        child: Builder(
          builder: (context) {
            return MaterialApp.router(
              title: 'SensazionApp',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              routerConfig: AppRouter(context.read<AuthenticationBloc>()).router,
            );
          },
        ),
      ),
    );
  }
}

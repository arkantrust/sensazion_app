import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:sensazion_app/src/home/home.dart';
import 'package:sensazion_app/src/authentication/authentication.dart';
import 'package:sensazion_app/src/profile/profile.dart';
import 'package:authentication_repository/authentication_repository.dart';

class AuthenticationRefreshStream extends ChangeNotifier {
  late final StreamSubscription _subscription;

  AuthenticationRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class AppRouter {
  final AuthenticationBloc auth;

  late final GoRouter router;

  AppRouter(this.auth) {
    router = GoRouter(
      initialLocation: '/auth',
      debugLogDiagnostics: true,
      refreshListenable: AuthenticationRefreshStream(auth.stream),
      redirect: (context, state) {
        final authState = auth.state;

        // The route is /auth/* (e.g., /auth/sign-in, /auth/sign-up, etc.)
        final goingToAuth = state.matchedLocation.contains('/auth/');

        final isAuthenticated = authState.status == AuthenticationStatus.authenticated;

        if (!isAuthenticated && !goingToAuth) return SignInPage.route().path;

        if (isAuthenticated && goingToAuth) return ProfilePage.route().path;

        // Unreacheable
        return null;
      },
      routes: [
        HomePage.route(), // rpute: /
        SignInPage.route(), // route: /auth/sign-in
        SignUpPage.route(), // route: /auth/sign-up
        GoRoute(
          path: '/auth',
          builder: (context, state) {
            final authStatus = context.select((AuthenticationBloc bloc) => bloc.state.status);
            if (authStatus == AuthenticationStatus.unknown) {
              return const SafeArea(
                child: Scaffold(body: Center(child: CircularProgressIndicator())),
              );
            }

            return const HomePage();
          },
        ),
        ProfilePage.route(), // route: /profile
      ],
      errorBuilder:
          (context, state) =>
              SafeArea(child: Scaffold(body: Center(child: Text('Error: ${state.error}')))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sensazion_app/src/home/home.dart';
import 'package:sensazion_app/src/authentication/authentication.dart';

GoRouter router = GoRouter(
  initialLocation: '/auth/sign-in',
  debugLogDiagnostics: true,
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Error: ${state.error}')
    )
  ),
  routes: [
    HomePage.route(), // route: /
    SignInPage.route(), // route: /auth/sign-in
  ],
);

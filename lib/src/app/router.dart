import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sensazion_app/src/home/home.dart';

GoRouter router = GoRouter(
  initialLocation:
      '/', // This can be changed arbitrarily to test different routes but for production, it should be the home route.
  debugLogDiagnostics: true,
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Error: ${state.error}')
    )
  ),
  routes: [
    HomePage.route(),
  ],
);

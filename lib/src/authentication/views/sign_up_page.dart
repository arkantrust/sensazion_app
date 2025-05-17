import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static GoRoute route() {
    return GoRoute(path: '/auth/sign-up', builder: (context, state) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: Padding(padding: const EdgeInsets.all(12), child: const Text('Sign Up Page')),
      ),
    );
  }
}

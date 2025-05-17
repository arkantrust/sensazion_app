import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:sensazion_app/src/authentication/authentication.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  static GoRoute route() {
    return GoRoute(path: '/auth/sign-in', builder: (context, state) => const SignInPage());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: BlocProvider(
            create: (context) {
              return SignInBloc(authenticationRepository: context.read<AuthenticationRepository>());
            },
            child: BlocListener<SignInBloc, SignInState>(
              listener: (context, state) {
                if (state.status.isFailure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(const SnackBar(content: Text('Invalid credentials')));
                }
              },
              child: Align(
                alignment: const Alignment(0, -1 / 3),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // TODO: Welcome
                    const _WelcomeText(),

                    const SizedBox(height: 50),

                    // Email
                    const _EmailInput(),

                    const SizedBox(height: 30),

                    // Password
                    const _PasswordInput(),

                    // TODO: Forgot password?
                    const _ResetPasswordButton(),

                    const SizedBox(height: 40),

                    // Sign In
                    _SignInButton(),

                    const SizedBox(height: 120),

                    // TODO: Don't have an account? Sign Up!
                    const _SignUpButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WelcomeText extends StatelessWidget {
  const _WelcomeText();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome to SensazionApp',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        onChanged: (password) {
          context.read<SignInBloc>().add(SignInPasswordChanged(password));
        },
        onSubmitted: (_) {
          context.read<SignInBloc>().add(const SignInSubmitted());
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(labelText: 'Password'),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        onChanged: (email) {
          context.read<SignInBloc>().add(SignInEmailChanged(email));
        },
        enableSuggestions: true,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(labelText: 'Email'),
      ),
    );
  }
}

class _ResetPasswordButton extends StatelessWidget {
  const _ResetPasswordButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Forgot password?',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.blue),
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    return RichText(
      textScaler: MediaQuery.textScalerOf(context),
      text: TextSpan(
        text: 'Don\'t have an account? ',
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(
            text: 'Sign Up',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgressOrSuccess = context.select(
      (SignInBloc bloc) => bloc.state.status.isInProgressOrSuccess,
    );

    if (isInProgressOrSuccess) return const CircularProgressIndicator();

    final isValid = context.select((SignInBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
      key: const Key('SignInForm_button'),
      onPressed: isValid ? () => context.read<SignInBloc>().add(const SignInSubmitted()) : null,
      child: const Text('Sign In'),
    );
  }
}

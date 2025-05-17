import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:sensazion_app/src/authentication/authentication.dart';

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
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: BlocProvider(
            create: (context) {
              return SignUpBloc(authenticationRepository: context.read<AuthenticationRepository>());
            },
            child: BlocListener<SignUpBloc, SignUpState>(
              listenWhen: (previous, current) => previous.error != current.error,
              listener: (context, state) {
                if (state.error != '') {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              child: Align(
                alignment: const Alignment(0, -1 / 3),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // TODO: Welcome
                      const _WelcomeText(),
                      const SizedBox(height: 50),

                      // Full Name
                      const _FullNameInput(),
                      const SizedBox(height: 16),

                      // Email
                      const _EmailInput(),
                      const SizedBox(height: 16),

                      // Password
                      BlocBuilder<SignUpBloc, SignUpState>(
                        buildWhen: (previous, current) => previous.password != current.password,
                        builder: (context, state) {
                          return _PasswordInput(
                            onChanged: (password) {
                              context.read<SignUpBloc>().add(SignUpPasswordChanged(password));
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      // Confirm Password
                      BlocBuilder<SignUpBloc, SignUpState>(
                        buildWhen: (previous, current) => previous.confirm != previous.confirm,
                        builder: (context, state) {
                          return _PasswordInput(
                            label: 'Confirmar contraseña',
                            onChanged: (confirm) {
                              context.read<SignUpBloc>().add(SignUpConfirmChanged(confirm));
                            },
                            textInputAction: TextInputAction.done,
                          );
                        },
                      ),

                      const SizedBox(height: 40),

                      // Sign Up
                      _SignUpButton(),

                      const SizedBox(height: 120),

                      // TODO: Already have an account? Sign In
                      const _SignInButton(),
                    ],
                  ),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Bienvenido a SensazionApp',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput({required this.onChanged, required this.label});

  final String label;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        onChanged: onChanged,
        enableSuggestions: true,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      ),
    );
  }
}

class _FullNameInput extends StatelessWidget {
  const _FullNameInput();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        spacing: 8,
        children: [
          _NameInput(
            onChanged: (first) {
              context.read<SignUpBloc>().add(SignUpFirstChanged(first));
            },
            label: 'Nombre',
          ),
          _NameInput(
            onChanged: (last) {
              context.read<SignUpBloc>().add(SignUpLastChanged(last));
            },
            label: 'Apellido',
          ),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            onChanged: (email) {
              context.read<SignUpBloc>().add(SignUpEmailChanged(email));
            },
            keyboardType: TextInputType.emailAddress,
            enableSuggestions: true,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: 'Email', border: const OutlineInputBorder()),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({required this.onChanged, String? label, TextInputAction? textInputAction})
    : _label = label ?? 'Contraseña',
      _textInputAction = textInputAction ?? TextInputAction.next;

  final void Function(String) onChanged;
  final String _label;
  final TextInputAction _textInputAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        onChanged: onChanged,
        textInputAction: _textInputAction,
        decoration: InputDecoration(labelText: _label, border: const OutlineInputBorder()),
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton();

  @override
  Widget build(BuildContext context) {
    return RichText(
      textScaler: MediaQuery.textScalerOf(context),
      text: TextSpan(
        text: 'Ya tienes una cuenta? ',
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(
            text: 'Inicia sesión',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blue),
            recognizer: TapGestureRecognizer()..onTap = () => context.push(SignInPage.route().path),
          ),
        ],
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgressOrSuccess = context.select(
      (SignUpBloc bloc) => bloc.state.status.isInProgressOrSuccess,
    );

    if (isInProgressOrSuccess) return const CircularProgressIndicator();

    final isValid = context.select((SignUpBloc bloc) => bloc.state.isValid);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          key: const Key('signUpButton'),
          onPressed: isValid ? () => context.read<SignUpBloc>().add(const SignUpSubmitted()) : null,
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
          child: const Text('Registrarme'),
        ),
      ),
    );
  }
}

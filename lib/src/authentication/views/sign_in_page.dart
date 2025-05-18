import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import 'package:sensazion_app/src/app/snack_bar.dart';
import 'package:sensazion_app/src/config/service_locator.dart';
import 'package:sensazion_app/src/authentication/authentication.dart';
import 'package:sensazion_app/src/components/components.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  static GoRoute route() {
    return GoRoute(path: '/auth/sign-in', builder: (context, state) => const SignInPage());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: BlocProvider(
            create: (context) {
              return sl<SignInBloc>();
            },
            child: BlocListener<SignInBloc, SignInState>(
              listenWhen:
                  (previous, current) =>
                      previous.status != current.status && current.status.isFailure,
              listener: (context, state) {
                if (state.status.isFailure) {
                  HapticFeedback.mediumImpact();
                  context.showSnackBar(state.error);
                }
              },
              child: Align(
                alignment: const Alignment(0, -1 / 3),
                child: BlocBuilder<SignInBloc, SignInState>(
                  builder: (context, state) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Bienvenido de vuelta',
                              textScaler: MediaQuery.textScalerOf(context),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: Theme.of(
                                context,
                              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 50),

                          // Email
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: EmailField(
                              onChanged: (email) {
                                context.read<SignInBloc>().add(SignInEmailChanged(email));
                              },
                              validationError: context.select(
                                (SignInBloc bloc) => bloc.state.email.displayError,
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Password
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: PasswordField(
                              onChanged: (password) {
                                context.read<SignInBloc>().add(SignInPasswordChanged(password));
                              },
                              validationError: context.select(
                                (SignInBloc bloc) => bloc.state.password.displayError,
                              ),
                              onSubmitted: (_) {
                                context.read<SignInBloc>().add(const SignInSubmitted());
                              },
                              textInputAction: TextInputAction.send,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // TODO: Forgot password?
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Olvidaste tu contraseña?',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(color: Colors.blue),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Sign In
                          ThemedTextButton(
                            isInProgressOrSuccess: context.select(
                              (SignInBloc bloc) => bloc.state.status.isInProgressOrSuccess,
                            ),
                            onPressed:
                                context.select((SignInBloc bloc) => bloc.state.isValid)
                                    ? () => context.read<SignInBloc>().add(const SignInSubmitted())
                                    : null,
                            text: 'Iniciar sesión',
                          ),
                          const SizedBox(height: 120),

                          // Don't have an account? Sign Up!
                          RichText(
                            textScaler: MediaQuery.textScalerOf(context),
                            text: TextSpan(
                              text: 'No tienes una cuenta aún? ',
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: [
                                TextSpan(
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () => context.go(SignUpPage.route().path),
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(color: Colors.blue),
                                  text: 'Regístrate',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

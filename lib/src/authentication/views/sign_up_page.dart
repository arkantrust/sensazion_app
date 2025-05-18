import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:sensazion_app/src/app/snack_bar.dart';
import 'package:sensazion_app/src/config/service_locator.dart';
import 'package:sensazion_app/src/authentication/authentication.dart';
import 'package:sensazion_app/src/components/components.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static GoRoute route() {
    return GoRoute(path: '/auth/sign-up', builder: (context, state) => const SignUpPage());
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
              return sl<SignUpBloc>();
            },
            child: BlocListener<SignUpBloc, SignUpState>(
              listenWhen: (previous, current) => previous.error != current.error,
              listener: (context, state) {
                if (state.error != '') {
                  HapticFeedback.mediumImpact();
                  context.showSnackBar(state.error);
                }
              },
              child: Align(
                alignment: const Alignment(0, -1 / 3),
                child: BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Bienvenido a SensazionApp',
                              textScaler: MediaQuery.textScalerOf(context),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: Theme.of(
                                context,
                              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 50),

                          // Full Name
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Row(
                              spacing: 8,
                              children: [
                                Expanded(
                                  child: NameField(
                                    onChanged: (first) {
                                      context.read<SignUpBloc>().add(SignUpFirstChanged(first));
                                    },
                                    isEmpty: state.first.isEmpty, // TODO: Add validation
                                    textInputAction: TextInputAction.next,
                                    label: 'Nombre',
                                  ),
                                ),
                                Expanded(
                                  child: NameField(
                                    onChanged: (last) {
                                      context.read<SignUpBloc>().add(SignUpLastChanged(last));
                                    },
                                    isEmpty: state.last.isEmpty, // TODO: Add validation
                                    textInputAction: TextInputAction.next,
                                    label: 'Apellido',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Email
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: EmailField(
                              onChanged: (email) {
                                context.read<SignUpBloc>().add(SignUpEmailChanged(email));
                              },
                              validationError: context.select(
                                (SignUpBloc bloc) => bloc.state.email.displayError,
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
                                context.read<SignUpBloc>().add(SignUpPasswordChanged(password));
                              },
                              onSubmitted: (_) {
                                context.read<SignUpBloc>().add(const SignUpSubmitted());
                              },
                              validationError: context.select(
                                (SignUpBloc bloc) => bloc.state.password.displayError,
                              ),
                              textInputAction: TextInputAction.send,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Confirm Password
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: PasswordField(
                              onChanged: (confirm) {
                                context.read<SignUpBloc>().add(SignUpConfirmChanged(confirm));
                              },
                              onSubmitted: (_) {
                                context.read<SignUpBloc>().add(const SignUpSubmitted());
                              },
                              validationError: context.select(
                                (SignUpBloc bloc) => bloc.state.confirm.displayError,
                              ),
                              textInputAction: TextInputAction.send,
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Sign Up
                          ThemedTextButton(
                            isInProgressOrSuccess: context.select(
                              (SignUpBloc bloc) => bloc.state.status.isInProgressOrSuccess,
                            ),
                            onPressed:
                                context.select((SignUpBloc bloc) => bloc.state.isValid)
                                    ? () => context.read<SignUpBloc>().add(const SignUpSubmitted())
                                    : null,
                            text: 'Registrarme',
                          ),
                          const SizedBox(height: 120),

                          // Already have an account? Sign In
                          RichText(
                            textScaler: MediaQuery.textScalerOf(context),
                            text: TextSpan(
                              text: 'Ya tienes una cuenta? ',
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: [
                                TextSpan(
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () => context.go(SignInPage.route().path),
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(color: Colors.blue),
                                  text: 'Inicia sesión',
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

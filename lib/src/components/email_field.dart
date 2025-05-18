import 'package:flutter/material.dart';
import 'package:sensazion_app/src/components/components.dart';
import 'package:sensazion_app/src/models/models.dart';

class EmailField extends StatelessWidget {
  final void Function(String) onChanged;
  final void Function(String)? onSubmitted;
  final EmailValidationError? validationError;
  final TextInputAction? textInputAction;

  const EmailField({
    super.key,
    required this.onChanged,
    required this.validationError,
    this.onSubmitted,
    this.textInputAction,
  });

  String? _getError(EmailValidationError? e) => switch (e) {
    EmailValidationError.empty => 'Escribe tu email',
    EmailValidationError.noAtSymbol => 'No incluiste un @',
    EmailValidationError.noLocal => 'No incluiste tu nombre de usuario',
    EmailValidationError.noDomain => 'No incluiste el dominio',
    null => null,
  };

  @override
  Widget build(BuildContext context) {
    return ThemedTextField(
      label: 'Email',
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: textInputAction,
      error: _getError(validationError),
      enableSuggestions: true,
      keyboardType: TextInputType.emailAddress,
    );
  }
}

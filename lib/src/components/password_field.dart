import 'package:flutter/material.dart';

import 'package:sensazion_app/src/models/models.dart';
import 'themed_text_field.dart';

class PasswordField extends StatelessWidget {
  final String label;
  final void Function(String) onChanged;
  final void Function(String)? onSubmitted;
  final PasswordValidationError? validationError;
  final TextInputAction? textInputAction;

  const PasswordField({
    super.key,
    required this.onChanged,
    required this.validationError,
    this.label = 'Contraseña',
    this.onSubmitted,
    this.textInputAction,
  });

  String? _getError(PasswordValidationError? e) => switch (e) {
    PasswordValidationError.empty => 'Escribe tu contraseña',
    PasswordValidationError.lessThan12Chars => 'Debe tener al menos 12 caracteres',
    PasswordValidationError.noNumber => 'Debe incluir al menos un número',
    PasswordValidationError.noUpper => 'Debe incluir al menos una letra mayúscula',
    PasswordValidationError.noLower => 'Debe incluir al menos una letra minúscula',
    PasswordValidationError.hasSpaces => 'No debe contener espacios',
    PasswordValidationError.noSymbol => 'Debe incluir al menos un carácter especial',
    null => null,
  };

  @override
  Widget build(BuildContext context) {
    return ThemedTextField(
      label: label,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: textInputAction,
      error: _getError(validationError),
      obscure: true,
      keyboardType: TextInputType.visiblePassword,
    );
  }
}

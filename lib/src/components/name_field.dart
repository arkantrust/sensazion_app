import 'package:flutter/material.dart';
import 'package:sensazion_app/src/components/components.dart';

class NameField extends StatelessWidget {
  final String label;
  final bool isEmpty;
  final void Function(String) onChanged;
  final void Function(String)? onSubmitted;
  final TextInputAction? textInputAction;

  const NameField({
    super.key,
    required this.label,
    required this.onChanged,
    required this.isEmpty,
    this.onSubmitted,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return ThemedTextField(
      label: label,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: textInputAction,
      error: isEmpty ? 'Escribe tu ${label.toLowerCase()}' : null,
      enableSuggestions: true,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.name,
    );
  }
}

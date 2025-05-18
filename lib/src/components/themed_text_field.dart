import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemedTextField extends StatelessWidget {
  final String label;
  final String? error;
  final void Function(String) onChanged;
  final bool obscure;
  final void Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final bool enableSuggestions;
  final bool autocorrect;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;

  const ThemedTextField({
    super.key,
    required this.label,
    required this.onChanged,
    required this.error,
    this.onSubmitted,
    this.textInputAction,
    this.obscure = false,
    this.enableSuggestions = false,
    this.autocorrect = false,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    var palette = Theme.of(context).colorScheme;
    return BlocProvider(
      lazy: true,
      create: (context) => _VisibilityCubit(),
      child: Builder(
        builder:
            (context) => TextField(
              key: key,
              obscureText:
                  obscure ? context.select((_VisibilityCubit cubit) => cubit.state) : false,
              onChanged: onChanged,
              enableSuggestions: enableSuggestions,
              autocorrect: autocorrect,
              keyboardType: keyboardType,
              textCapitalization: textCapitalization,
              textInputAction: textInputAction,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(color: palette.onSurface),
                suffixIcon: obscure ? _VisibilityButton() : null,
                errorText: error,
                errorStyle: TextStyle(color: palette.error),
              ),
            ),
      ),
    );
  }
}

class _VisibilityCubit extends Cubit<bool> {
  _VisibilityCubit() : super(true);

  void toggle() => emit(!state);
}

class _VisibilityButton extends StatelessWidget {
  const _VisibilityButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        context.select((_VisibilityCubit cubit) => cubit.state)
            ? Icons.visibility
            : Icons.visibility_off,
      ),
      onPressed: () => context.read<_VisibilityCubit>().toggle(),
    );
  }
}

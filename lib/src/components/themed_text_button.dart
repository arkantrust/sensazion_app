import 'package:flutter/material.dart';

class ThemedTextButton extends StatelessWidget {
  final String text;
  final bool isInProgressOrSuccess;
  final void Function()? onPressed;
  final double padding;

  const ThemedTextButton({
    super.key,
    required this.text,
    required this.isInProgressOrSuccess,
    required this.onPressed,
    this.padding = 25.0,
  });

  @override
  Widget build(BuildContext context) {
    var palette = Theme.of(context).colorScheme;

    if (isInProgressOrSuccess) return const CircularProgressIndicator();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: palette.primary,
            foregroundColor: palette.onPrimary,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(text),
        ),
      ),
    );
  }
}

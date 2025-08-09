
import 'package:flutter/material.dart';


class DefaultFilledButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? fillColor;
  final Color? textColor;

  const DefaultFilledButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.fillColor,
    this.textColor,
  });

  @override
  State<DefaultFilledButton> createState() => _DefaultFilledButtonState();
}

class _DefaultFilledButtonState extends State<DefaultFilledButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 53,
      child: FilledButton(
        onPressed: widget.isLoading ? null : widget.onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: widget.fillColor ?? Theme.of(context).primaryColor,
          disabledBackgroundColor: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
        ),
        child: widget.isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              )
            : Text(
                widget.label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: widget.textColor ??
                      Theme.of(context).colorScheme.onPrimary,
                ),
              ),
      ),
    );
  }
}

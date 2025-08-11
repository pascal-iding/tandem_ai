
import 'package:flutter/material.dart';


class Snackbar {
  static SnackBar build(BuildContext context, String message) {
    return SnackBar(
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      duration: const Duration(seconds: 3),
    );
  }
}
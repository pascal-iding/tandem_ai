
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class DefaultTextInput extends StatelessWidget {
  final String? title;
  final String hint;
  final String? topicIconPath;
  final TextEditingController? controller;
  final bool isPassword;
  final ValueChanged<String>? onChanged;

  const DefaultTextInput({
    super.key,
    this.title,
    required this.hint,
    this.controller,
    this.topicIconPath,
    this.isPassword = false,
    this.onChanged, // Add this parameter
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        if (title != null)
          const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (topicIconPath != null)
              Container(
                width: 53,
                height: 53,
                padding: EdgeInsets.all(8),
                child: SvgPicture.asset(
                  topicIconPath!
                ),
              ),
            if (topicIconPath != null)
              const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 51,
                child: TextFormField(
                  controller: controller,
                  obscureText: isPassword,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  onChanged: onChanged,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface, width: 1),
                    ),
                  ),
                ),
              ),
            )
          ]
        )
      ],
    );
  }
}

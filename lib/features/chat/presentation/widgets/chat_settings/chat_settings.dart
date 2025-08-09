
import 'package:flutter/material.dart';

import 'package:tandem_ai/shared/widgets/header/header.dart';
import 'package:tandem_ai/shared/widgets/form_elements/buttons/default_filled_button.dart';
import './chat_settings_options.dart';


class ChatSettings extends StatelessWidget {
  final double maxHeight;

  const ChatSettings({super.key, required this.maxHeight});

  @override
  Widget build(BuildContext context) {
    final double safeAreaPaddingTop = MediaQuery.of(context).padding.top;
    final double padding = 21;
    final double gapToScrollIndicator = 8;

    return Container(
      width: double.infinity,
      height: maxHeight * 0.9,
      padding: EdgeInsets.only(
        top: safeAreaPaddingTop + padding,
        left: padding,
        right: padding,
        bottom: padding + gapToScrollIndicator,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(),
                const SizedBox(height: 21),
                Text(
                  'Starte eine Konversation',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 21),
                ChatSettingsOptions()
              ],
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 8),
              DefaultFilledButton(
                label: 'Neue Konvertion starten',
                onPressed: () => print('Pressed')
              ),
            ]
          )
        ]
      )
    );
  }
}

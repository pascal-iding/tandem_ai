
import 'package:flutter/material.dart';

import 'package:tandem_ai/shared/widgets/form_elements/dropdowns/default_dropdown.dart';
import 'package:tandem_ai/shared/widgets/form_elements/text_inputs/default_text_input.dart';
import '../active_chat_list/active_chat_list.dart';


class ChatSettingsOptions extends StatelessWidget {
  ChatSettingsOptions({super.key});

  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ActiveChatList(),
            const SizedBox(height: 11),
            DefaultTextInput(
              title: 'Wie möchtest du genannt werden', 
              hint: 'Jonas',
              controller: usernameController
            ),
            const SizedBox(height: 11),
            DefaultDropdown(
              title: 'Worüber möchtest du reden',
              hint: 'Alltag',
              dropdownItems: const [
                'Reisen',
                'Business',
                'Alltag'
              ]
            ),
            const SizedBox(height: 11),
            DefaultDropdown(
              title: 'Welche Sprache möchtest du lernen',
              hint: 'Spanisch',
              value: 'Spanisch',
              dropdownItems: const [
                'Deutsch',
                'Spanisch',
                'Englisch',
                'Italienisch'
              ]
            ),
            const SizedBox(height: 11),
            DefaultDropdown(
              title: 'Was ist dein aktuelles Level',
              hint: 'Anfänger - A1',
              dropdownItems: const [
                'Anfänger - A1',
                'Anfänger - A2',
                'Fortgeschritten - B1',
                'Fortgeschritten - B2',
                'Sehr fortgeschritten - C1',
                'Muttersprachlich - C2'
              ]
            ),
            const SizedBox(height: 11)
          ],
        ),
      ),
    );
  }
}
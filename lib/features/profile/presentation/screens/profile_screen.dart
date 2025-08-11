import 'package:flutter/material.dart';
import 'package:tandem_ai/shared/widgets/form_elements/buttons/default_filled_button.dart';
import 'package:tandem_ai/shared/widgets/form_elements/error_message.dart';
import 'package:tandem_ai/shared/widgets/header/header.dart';
import 'package:tandem_ai/shared/widgets/form_elements/text_inputs/default_text_input.dart';
import '../../../../shared/utils/api_key_repository.dart';
import 'package:tandem_ai/shared/widgets/snackbar.dart' as tandem_ai;


class ProfileScreen extends StatefulWidget {
  final String? errorMessage;

  const ProfileScreen({super.key, this.errorMessage});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _apiKeyController = TextEditingController();
  final ApiKeyRepository _apiKeyStorage = ApiKeyRepository();
  String _initialKey = '';
  String _currentKey = '';

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getApiKey();
  }

  void _getApiKey() async {
    try {
      String key = await _apiKeyStorage.getApiKey();
      _apiKeyController.text = key;
      setState(() {
        _initialKey = key;
        _currentKey = key;
      });
    } catch (e) {
      if (mounted) {
        tandem_ai.Snackbar.show(context, 'Ein unbekannter Fehler ist aufgetreten');
      }
    }
  }

  void _saveApiKey() {
    try {
      _apiKeyStorage.saveApiKey(_apiKeyController.text);
      setState(() {
        _initialKey = _apiKeyController.text;
      });
      
      tandem_ai.Snackbar.show(context, 'Api Key gespeichert.');
    } catch (e) {
      tandem_ai.Snackbar.show(context, 'Ein unbekannter Fehler ist aufgetreten.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double paddingTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: paddingTop + 21,
          right: 21,
          left: 21,
          bottom: 21
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              showBackButton: true,
            ),
            const SizedBox(height: 21),
            Text(
              'Dein Profil',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 21),
            DefaultTextInput(
              hint: 'Dein Api Key', 
              title: 'Api Key',
              controller: _apiKeyController,
              onChanged: (value) => setState(() {
                _currentKey = value;
              }),
            ),
            if (widget.errorMessage != null)
              const SizedBox(height: 11),
            if (widget.errorMessage != null)
              ErrorMessage(errorMessage: widget.errorMessage!),
            const SizedBox(height: 11),
            if (_initialKey != _currentKey)
              DefaultFilledButton(
                label: 'Speichern', 
                onPressed: _saveApiKey,
              ),
          ]
        )
      )
    );
  }
}
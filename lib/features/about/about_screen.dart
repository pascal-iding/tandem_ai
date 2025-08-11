import 'package:flutter/material.dart';
import 'package:tandem_ai/l10n/app_localizations.dart';
import 'package:tandem_ai/shared/widgets/form_elements/buttons/default_outlined_button.dart';
import 'package:tandem_ai/shared/widgets/header/header.dart';

class AboutScreen extends StatefulWidget {
  final String? errorMessage;

  const AboutScreen({super.key, this.errorMessage});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
          bottom: 21,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(showBackButton: true),
            const SizedBox(height: 21),
            Text(
              AppLocalizations.of(context)!.yourProfile,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 21),
            DefaultOutlinedButton(
              label: AppLocalizations.of(context)!.agb,
              borderWidth: 1,
              onPressed: () {},
            ),
            const SizedBox(height: 11),
            DefaultOutlinedButton(
              label: AppLocalizations.of(context)!.privacy,
              borderWidth: 1,
              onPressed: () {},
            ),
            const SizedBox(height: 11),
            DefaultOutlinedButton(
              label: AppLocalizations.of(context)!.legalNotice,
              borderWidth: 1,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

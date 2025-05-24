import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_fl_app/Service/settings_provider.dart';
import 'package:quiz_fl_app/l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final loc = AppLocalizations.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text(loc.darkMode),
              value: settingsProvider.themeMode == ThemeMode.dark,
              onChanged: (value) {
                settingsProvider.toggleTheme(value);
              },
            ),
            ListTile(
              title: Text(loc.language),
              trailing: DropdownButton<String>(
                value: settingsProvider.locale.languageCode,
                items: const [
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'ru', child: Text('Русский')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    settingsProvider.switchLanguage(value);
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: Text(
                loc.logout,
                style: const TextStyle(color: Colors.red),
              ),
              leading: const Icon(Icons.logout, color: Colors.red),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

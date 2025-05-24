import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_fl_app/Widgets/my_button.dart';
import 'package:quiz_fl_app/Widgets/snackbar.dart';
import 'package:quiz_fl_app/l10n/app_localizations.dart';
import 'package:quiz_fl_app/service/password_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PasswordService _passwordService = PasswordService();
  String generatedPassword = "";
  final TextEditingController _noteController = TextEditingController(); 

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _copyPassword() {
    if (generatedPassword.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: generatedPassword));
      showSnackBar(context, AppLocalizations.of(context).passwordCopied);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(loc.passwordLength),
            Slider(
              value: _passwordService.passwordLength,
              min: 6,
              max: 24,
              divisions: 18,
              label: _passwordService.passwordLength.round().toString(),
              onChanged: (value) {
                setState(() {
                  _passwordService.passwordLength = value;
                });
              },
            ),
            CheckboxListTile(
              value: _passwordService.useUppercase,
              onChanged: (val) => setState(() => _passwordService.useUppercase = val!),
              title: Text(loc.uppercaseLetters),
            ),
            CheckboxListTile(
              value: _passwordService.useLowercase,
              onChanged: (val) => setState(() => _passwordService.useLowercase = val!),
              title: Text(loc.lowercaseLetters),
            ),
            CheckboxListTile(
              value: _passwordService.useNumbers,
              onChanged: (val) => setState(() => _passwordService.useNumbers = val!),
              title: Text(loc.numbers),
            ),
            CheckboxListTile(
              value: _passwordService.useSymbols,
              onChanged: (val) => setState(() => _passwordService.useSymbols = val!),
              title: Text(loc.symbols),
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: TextEditingController(text: generatedPassword),
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: _copyPassword,
                  tooltip: loc.copyPassword,
                ),
              ],
            ),

            const SizedBox(height: 20),
            MyButton(
              onTap: () {
                setState(() {
                  generatedPassword = _passwordService.generatePassword();
                });
                if (generatedPassword.startsWith("Выбери хотя бы один тип символов")) {
                  showSnackBar(context, loc.selectAtLeastOneOption);
                }
              },
              buttonText: loc.generate,
            ),

            const SizedBox(height: 20),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: loc.note,
              ),
              onChanged: (value) {
                _passwordService.note = value;
              },
            ),
            const SizedBox(height: 20),
            MyButton(
              onTap: () async {
                String result = await _passwordService.savePassword();
                showSnackBar(context, result);
                setState(() {
                  generatedPassword = _passwordService.generatedPassword;
                });
                _noteController.clear();
              },
              buttonText: loc.savePassword,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

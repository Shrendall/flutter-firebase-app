import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const _localizedStrings = {
    'en': {
      'settings': 'Settings',
      'dark_mode': 'Dark Mode',
      'language': 'Language',
      'password_generator': 'Password Generator',
      'password_history': 'Password History',
      'logout': 'Log out',


      // MainScreen
      'password_length': 'Password Length',
      'uppercase_letters': 'Uppercase letters (A-Z)',
      'lowercase_letters': 'Lowercase letters (a-z)',
      'numbers': 'Numbers (0-9)',
      'symbols': 'Symbols (!@#...)',
      'generate': 'Generate',
      'note': 'Note',
      'save_password': 'Save Password',
      'copy_password': 'Copy Password',
      'password_copied': 'Password copied!',
      'select_at_least_one_option': 'Select at least one character type',

      // HistoryScreen
      'user_not_logged_in': 'User not logged in',
      'no_saved_passwords': 'No saved passwords',
      'unknown_date': 'Unknown date',
      'password_deleted': 'Password deleted',
      'note_colon': 'Note:',
      'created_at': 'Created:',
       'error_occurred': 'An error occurred',
   
    },
    'ru': {
      'settings': 'Настройки',
      'dark_mode': 'Тёмная тема',
      'language': 'Язык',
      'password_generator': 'Генератор паролей',
      'password_history': 'История паролей',
      'logout': 'Выйти',

      // MainScreen
      'password_length': 'Длина пароля',
      'uppercase_letters': 'Заглавные буквы (A-Z)',
      'lowercase_letters': 'Строчные буквы (a-z)',
      'numbers': 'Цифры (0-9)',
      'symbols': 'Символы (!@#...)',
      'generate': 'Сгенерировать',
      'note': 'Примечание',
      'save_password': 'Сохранить пароль',
      'copy_password': 'Копировать пароль',
      'password_copied': 'Пароль скопирован!',
      'select_at_least_one_option': 'Выбери хотя бы один тип символов',

      // HistoryScreen
      'user_not_logged_in': 'Пользователь не авторизован',
      'no_saved_passwords': 'Нет сохранённых паролей',
      'unknown_date': 'Дата неизвестна',
      'password_deleted': 'Пароль удалён',
      'note_colon': '📝 Примечание:',
      'created_at': '📅 Создан:',
      'error_occurred': 'Произошла ошибка',
  
    },
  };

  String _t(String key) => _localizedStrings[locale.languageCode]![key]!;


  String get settings => _t('settings');
  String get darkMode => _t('dark_mode');
  String get language => _t('language');
  String get passwordGenerator => _t('password_generator');
  String get passwordHistory => _t('password_history');

  // MainScreen
  String get passwordLength => _t('password_length');
  String get uppercaseLetters => _t('uppercase_letters');
  String get lowercaseLetters => _t('lowercase_letters');
  String get numbers => _t('numbers');
  String get symbols => _t('symbols');
  String get generate => _t('generate');
  String get note => _t('note');
  String get savePassword => _t('save_password');
  String get copyPassword => _t('copy_password');
  String get passwordCopied => _t('password_copied');
  String get selectAtLeastOneOption => _t('select_at_least_one_option');

  // HistoryScreen
  String get userNotLoggedIn => _t('user_not_logged_in');
  String get noSavedPasswords => _t('no_saved_passwords');
  String get unknownDate => _t('unknown_date');
  String get passwordDeleted => _t('password_deleted');
  String get noteColon => _t('note_colon');
  String get createdAt => _t('created_at');
  String get errorOccurred => _t('error_occurred');



  String get logout => _t('logout');

}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}

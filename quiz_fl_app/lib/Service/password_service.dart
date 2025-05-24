import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PasswordService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  double passwordLength = 12;
  bool useUppercase = true;
  bool useLowercase = true;
  bool useNumbers = true;
  bool useSymbols = true;
  String generatedPassword = "";
  String note = ""; 

  String generatePassword() {
    const upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const lower = "abcdefghijklmnopqrstuvwxyz";
    const numbers = "0123456789";
    const symbols = "!@#\$%^&*()_+-=[]{}|;:',.<>?/";

    String chars = "";
    if (useUppercase) chars += upper;
    if (useLowercase) chars += lower;
    if (useNumbers) chars += numbers;
    if (useSymbols) chars += symbols;

    if (chars.isEmpty) {
      return "Выбери хотя бы один тип символов!";
    }

    String password = "";
    final rand = Random();

    for (int i = 0; i < passwordLength.round(); i++) {
      password += chars[rand.nextInt(chars.length)];
    }

    generatedPassword = password;
    return generatedPassword;
  }

  Future<String> savePassword() async {
  final user = _auth.currentUser;

  if (user == null) {
    return "Ошибка: пользователь не найден";
  }

  if (generatedPassword.isEmpty) {
    return "Сначала сгенерируй пароль";
  }

  try {
    await _firestore.collection("userPasswords").add({
      "uid": user.uid,
      "password": generatedPassword,
      "note": note,
      "createdAt": Timestamp.now(),
    });
    
    // Очищаем поля после успешного сохранения
    generatedPassword = "";
    note = "";
    
    return "Пароль сохранён!";
  } catch (e) {
    return "Ошибка при сохранении: $e";
  }
}
}
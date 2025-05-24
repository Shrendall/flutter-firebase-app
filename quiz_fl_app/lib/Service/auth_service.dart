import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Регистрация нового пользователя с email и паролем

  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    String res = "Появилась какая-то ошибка!";
    
    try {
      // Проверка заполнения всех полей
      if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
        // Создание пользователя в Firebase Auth
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Сохранение дополнительных данных пользователя в Firestore
        await _firestore.collection("userData").doc(credential.user!.uid).set({
          'name': name,
          'uid': credential.user!.uid,
          'score': 0,
        });

        res = 'success';
      } else {
        res = "Заполни все поля!";
      }
    } catch (err) {
      return err.toString();
    }
    
    return res;
  }


/// Авторизация пользователя по email и паролю

Future<String> loginUser({
  required String email,
  required String password,
}) async {
  String res = "Появилась какая-то ошибка!";
  
  try {
    // Проверка заполнения полей
    if (email.isNotEmpty && password.isNotEmpty) {
      // Попытка входа
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      res = 'success';
    } else {
      res = "Заполни все поля!";
    }
  } catch (err) {
    return err.toString(); // Возвращаем текст ошибки
  }
  
  return res;
}
}
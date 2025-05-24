import 'package:flutter/material.dart';
import 'package:quiz_fl_app/Service/auth_service.dart';
import 'package:quiz_fl_app/Views/login_screen.dart';
import 'package:quiz_fl_app/Widgets/my_button.dart';
import 'package:quiz_fl_app/Widgets/snackbar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isPasswordHiden = true;
  final AuthService _authService = AuthService();

  //Функция для регистрации юзера
  void _signUp() async {
    setState(() {
      isLoading = true;
    });

    // call the method
    final result = await _authService.signUpUser(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
    );

    if (result == "success") {
      setState(() {
        isLoading = false;
      });

      // на след экран
      showSnackBar(context, "Регистрация успешна!Теперь войдите!");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, "Регистрация неудалась.$result");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Image.asset("assets/signup_img.jpg"),
              const SizedBox(height: 20),
              // Поле для имени
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Имя",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Поле для email (добавлено)
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Поле для пароля
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Пароль",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordHiden = !isPasswordHiden;
                      });
                    },
                    icon: Icon(
                      isPasswordHiden ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                obscureText: isPasswordHiden,
              ),
              const SizedBox(height: 20),
              // Кнопка регистрации
              isLoading
                ?const Center(
                  child: CircularProgressIndicator(),
                )
              :SizedBox(
                width: double.infinity,
                child: MyButton(
                  onTap: _signUp,
                  buttonText: "Зарегистрироваться",
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Уже зарегистрированы?",
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      " Войти",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

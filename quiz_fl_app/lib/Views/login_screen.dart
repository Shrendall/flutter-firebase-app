import 'package:flutter/material.dart';
import 'package:quiz_fl_app/Service/auth_service.dart';
import 'package:quiz_fl_app/Views/home_screen.dart';
import 'package:quiz_fl_app/Views/signup_screen.dart';
import 'package:quiz_fl_app/Widgets/my_button.dart';
import 'package:quiz_fl_app/Widgets/snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
   bool isLoading = false;
  bool isPasswordHiden = true;
  final AuthService _authService = AuthService();

  
  void _login() async {
    setState(() {
      isLoading = true;
    });

    // call the method
    final result = await _authService.loginUser(
      email: emailController.text,
      password: passwordController.text,
    );

    if (result == "success") {
      setState(() {
        isLoading = false;
      });

      // на след экран
      
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, "Регистрация неудалась.$result");
    }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Image.asset("assets/login_img.jpg"),
              const SizedBox(height: 20),
              // Поле для емейла
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Почта",
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
              // Кнопка логина
               isLoading
                ?const Center(
                  child: CircularProgressIndicator(),
                )
              :SizedBox(
                width: double.infinity,
                child: MyButton(onTap:_login, buttonText: "Войти"),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "У вас нет аккаунта?",
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      " Зарегистрироваться",
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

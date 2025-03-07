import 'dart:developer';

import 'package:curso_de_verano/core/themes/app_theme.dart';
import 'package:curso_de_verano/home_screen.dart';
import 'package:curso_de_verano/navigator_bar.dart';
import 'package:curso_de_verano/signup_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  

  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controladores de los TextField de la pantalla de inicio.
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String email = "";
  String password = "";

  //Funcion de inicio de session con Firebase
  Future<void> _login(BuildContext context,
      {required String email, required String password}) async {
    try {
      //Iniciamos session con Firebase.
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        log('User signed in successfully: ${userCredential.user!.uid}');

        await FirebaseAnalytics.instance.logEvent(name: "loginSuccess" );

        // Navigate to the home screen
        context.go(NavigatorBar.routeName);
      } else {
        log('User sign in failed');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    registerScreen();
  }

  Future<void> registerScreen()async {
     await FirebaseAnalytics.instance.logScreenView( screenName:  "Login");
  }


  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 24,
                  bottom: 24,
                  left: 16,
                  right: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.abc_sharp,
                      size: 50,
                    ),
                    SizedBox(width: 16),
                    Text('Curso de Verano',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Inicia sesión con tu cuenta',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 100),

              TextField(
                controller: _userController,
                decoration: InputDecoration(
                  hintText: 'Correo',
                ),
                onChanged: (value) {
                  email = value;
                  log(email);
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                ),
                onChanged: (value) {
                  password = value;
                  print(password);
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                  onPressed: () {
                    _login(context, email: email, password: password);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        'Iniciar sesión',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 2, 18, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  )),

              const SizedBox(height: 8),
              //Boton de registro a la app
              RichText(
                text: TextSpan(
                  text: '¿No tienes una cuenta? ',
                  style: TextStyle(
                      color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Regístrate',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer(
                      )..onTap = () {
                        context.push(SignUpScreen.routeName);
                      }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:curso_de_verano/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {

  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Future<void> _login(BuildContext context ,{required String email, required String password} ) async {
    log('Email: $email');
    log('Password: $password');

    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      
      if (userCredential.user!= null) {
        log('User signed in successfully: ${userCredential.user!.uid}');
        // Navigate to the home screen
        context.go(HomeScreen.routeName);

      } else {
        log('User sign in failed');
      }

    }catch(e) {
      log('Error: $e');
    }

  }

  @override
  Widget build(BuildContext context) {

    String email = "";
    String password = "";

    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Correo',
                  ),
                  onChanged: (value){
                    email = value;
                    log(email);
                  },
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                  ),
                  onChanged: (value){
                    password = value;
                    print(password);
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(onPressed: (){
                  _login(context ,email: email, password: password);
                }, child: Text('Iniciar sesión')),
              ],
            ),
          ),
        ),
      );
  }
}